//
//  CarouselViewController.m
//  DanRestaurantApp
//
//  Created by DvirSofer on 7/1/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "CarouselViewController.h"
#import "CustomPopUp.h"
#import "AFHTTPRequestOperationManager.h"
#import "Product+CoreData.h"
#import "Authorization+CoreData.h"
#import "Employee+CoreData.h"
#import "CarouselView.h"
#import "AppDelegate.h"
#import "Order+CoreData.h"
#import "MBProgressHUD.h"
#import "HelpFunction.h"

@interface CarouselViewController ()
@property (strong, nonatomic) MBProgressHUD *hud;
@property (strong, nonatomic) CustomPopUp *currentPopup;

@end

@implementation CarouselViewController

@synthesize carousel, items;

- (void)awakeFromNib
{
    //Setups done in the segue
    
}

- (void)dealloc
{
    //it's a good idea to set these to nil here to avoid
    //sending messages to a deallocated viewcontroller
    carousel.delegate = nil;
    carousel.dataSource = nil;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //setup spinner
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hud];
    self.hud.labelText = @"אנא המתן...";
    [self.hud show:YES];

    // Remove all old products from local database
    [Product deleteAllProducts];
    
    // Init items on load
    self.networkManager = [[CarouselViewNetworkManager alloc] init];
    self.networkManager.delegate = self;
    [self.networkManager getAllParams: self.customItemsOption];
    
    //configure carousel
    carousel.type = iCarouselTypeCoverFlow2;
}

- (void)viewDidAppear:(BOOL)animated {

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    //free up memory by releasing subviews
    self.carousel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark -
#pragma mark iCarousel methods
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [self.items count];
    
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    CarouselView *button;
    //create new view if no view is available for recycling
    if(view == nil)
    {
        button = (CarouselView *)view;
        
        // Create custom carousel view (which is clickable)
        button = [[CarouselView alloc] initWithItem:[items objectAtIndex:index]];
        
        // Set button tag to save the index
        button.tag = index;
        [button addTarget:self.tabViewController action:@selector(buttonIsPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}

-(void) buttonIsPressed:(UIButton *)sender {
    // Get item index for button
    NSNumber *index = [NSNumber numberWithLong:[sender tag]];
    // Initiate the popup view
    self.popup = [[CustomPopUp alloc] initWithNibName:@"PopupView" bundle:nil];
    // Save the clicked item index
    self.popup.productIndex = index;
    // Get authorizations from local db
    self.auths = [Authorization loadAuth];
    // Add "My Self" as target option
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appdelegate managedObjectContext];
    Authorization *mySelf = (Authorization*)[NSEntityDescription insertNewObjectForEntityForName:@"Authorization" inManagedObjectContext:context];
    mySelf.target_id = [Employee getSessionId];
    mySelf.name = @"עבורי";
    [self.auths insertObject:mySelf atIndex:0];

    // Set the popup delegate to be the controller
    self.popup.delegate = self;
    
    // Show popup
    [self.popup showInView:self.view animated:YES withTargets: self.auths];
}

#pragma mark - CarouselViewNetworkManagerDelegate
- (void) resultsFound:(NSArray *)json {
    [self.hud hide:YES];
    // Save items info in self.items array
    self.items = [Product setItemsArray: json];
    
    // Reload the carousel with updated items
    [self.carousel reloadData];
}

-(void) itemsFound:(NSNumber *)numOfItemsFromServer {
    // Create the array of the order //
    
    // The id of employee who makes the order
    NSNumber *employeeId = [Employee getSessionId];
    // Get the target name + id
    NSInteger selectedTargetIndex = [self.currentPopup.targetPicker selectedRowInComponent:0];
    NSNumber *targetId;
    NSString *targetName;
    // If for me
    if(selectedTargetIndex == 0) {
        targetId = employeeId;
        targetName = [Employee getSessionName];
    }
    else {
        // Check in local db who is the target
        Authorization *auth = (Authorization *)[[Authorization loadAuth] objectAtIndex:(selectedTargetIndex-1)];
        targetId = auth.target_id;
        targetName = auth.name;
    }
    
    // Get the product which selected in carousel
    Product *prod = [Product getProductByIndex:self.currentPopup.productIndex];
    
    // Get the product id
    NSNumber *prodId = prod.prod_id;
    // Get product image url
    NSString *imgUrl = prod.img_url;
    // Get product name
    NSString *prodName = prod.prod_desc;
    // Save the current date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDate = [formatter stringFromDate:[NSDate date]];
    NSNumber *numOfItems = [NSNumber numberWithInt:[self.currentPopup.numOfItems.text intValue]];
    
    // Get all orders ordered by targetId in the current date from Local Database
    NSArray *orders = [Order loadOrdersByTarget:targetId andDate:currentDate];
    
    // LowPrice is the price of the first product
    // highPrice is the price of the other products
    NSNumber *lowPrice = [NSNumber numberWithFloat:([prod.price floatValue] * 0.9)];
    NSNumber *highPrice = prod.price;
    NSMutableArray *prices;
    
    //******************** Check if there are items in quantity ********************//
    if(numOfItems > prod.quantity) {
        // Show error message - out of quantity
        [[[HelpFunction alloc] init] showAlert:@"אין מספיק מוצרים במלאי"];
        // Remove the popup
        [self.currentPopup removeAnimate];
        return;
    }
    
    //******************** Check target items ********************//
    // Only 1 item by same employee - Low price
    if([numOfItemsFromServer intValue] + [orders count] + [numOfItems intValue] == 1) {
        prices = [[NSMutableArray alloc] init];
        [prices addObject:lowPrice];
    }
    // Between 2 to max items ordered by same employee - Add to cart (1 item in low price, others in high price)
    else if([numOfItemsFromServer intValue] + [orders count] + [numOfItems intValue] > 1 &&
            [numOfItemsFromServer intValue] + [orders count] + [numOfItems intValue] <= MAX_PER_EMPLOYEE) {
        prices = [[NSMutableArray alloc] init];
        // check if it's first item of the day - low price or not - high price
        // All items in high price
        if([numOfItemsFromServer intValue]>0 || [orders count]>0) {
            for(int i = 0; i < [numOfItems intValue]; i++) {
                [prices addObject:highPrice];
            }
        }
        // First item is low price and others are high price
        else {
            [prices addObject:lowPrice];
            for(int i = 1; i < [numOfItems intValue]; i++) {
                [prices addObject:highPrice];
            }
        }
    }
    // More than maximum items per employee - Show Error Alert
    else if([numOfItemsFromServer intValue] + [orders count] + [numOfItems intValue] > MAX_PER_EMPLOYEE) {
        // Alert - Can't order anymore!
        [[[HelpFunction alloc] init] showAlert:@"עברת את הגבלת הפריטים ליום"];
        // Remove the popup
        [self.currentPopup removeAnimate];
        return;
    }
    
    NSError *error;
    NSMutableArray *products = [[NSMutableArray alloc] init];
    for(int i = 0; i < [numOfItems intValue]; i++) {
        //build an info object and convert to json
        NSDictionary* info = [NSDictionary dictionaryWithObjectsAndKeys:
                              employeeId, @"employee_id",
                              prodId, @"prod_id",
                              [prices objectAtIndex:i], @"price",
                              targetId, @"target_id",
                              currentDate, @"order_date",
                              targetName, @"target_name",
                              imgUrl, @"img_url",
                              prodName, @"prod_name",
                              nil];
        [products addObject:info];
    }
    //convert object to data
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:products
                                                       options:NSJSONWritingPrettyPrinted error:&error];
    //print out the data contents
    NSString *jsonSummary = [[NSString alloc] initWithData:jsonData
                                                  encoding:NSUTF8StringEncoding];
#warning REMOVE THIS
    NSLog(@"%@", jsonSummary);
    // Save in local database
    [Order saveOrder:[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil]];
    
    // Remove the popup
    [self.currentPopup removeAnimate];
}

#warning edit
- (void) errorFound:(NSError *) error{
    // Show error messege.
    [[[HelpFunction alloc] init] showAlert:@"Wrong ID or Password"];
}

#pragma mark - PopUpViewDelegate
- (void) addToCart:(id) popup
{
    self.currentPopup = (CustomPopUp *)popup;
    
    NSNumber *numOfItems = [NSNumber numberWithInt:[self.currentPopup.numOfItems.text intValue]];
    // No items in popup - Do nothing
    if([numOfItems intValue] == 0) {
        // Remove the popup
        [self.currentPopup removeAnimate];
        return;
    }
    
    NSInteger selectedTargetIndex = [self.currentPopup.targetPicker selectedRowInComponent:0];
    NSNumber *targetId;
    // If for me
    if(selectedTargetIndex == 0) {
        targetId = [Employee getSessionId];
    }
    else {
        // Check in local db who is the target
        Authorization *auth = (Authorization *)[[Authorization loadAuth] objectAtIndex:selectedTargetIndex];
        targetId = auth.target_id;
    }
    // Get the current date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDate = [formatter stringFromDate:[NSDate date]];
    
    // Get number of items from Server
    [self.networkManager getGetItemsByTarget:targetId andDate:currentDate];
}

@end
