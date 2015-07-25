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

    // Init items on load
    self.networkManager = [[CarouselViewNetworkManager alloc] init];
    self.networkManager.delegate = self;
    [self.networkManager getAllParams: self.customItemsOption];
    
    //configure carousel
    carousel.type = iCarouselTypeCoverFlow2;
}

- (void)viewDidAppear:(BOOL)animated {
    // Init items on load
    //CarouselViewNetworkManager *networkManager = [[CarouselViewNetworkManager alloc] init];
    //networkManager.delegate = self;
    //[networkManager getAllParams: self.customItemsOption];
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

    // Set the popup delegate to be self
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
        Authorization *auth = (Authorization *)[[Authorization loadAuth] objectAtIndex:selectedTargetIndex];
        targetId = auth.target_id;
        targetName = auth.name;
    }
    
    // Get the product which selected in carousel
    Product *prod = [Product getProductByIndex:self.currentPopup.productIndex];
    // Get the product id
    NSNumber *prodId = prod.prod_id;
    // Save the current date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-mm-dd"];
    NSString *currentDate = [formatter stringFromDate:[NSDate date]];
    NSNumber *numOfItems = [NSNumber numberWithInt:[self.currentPopup.numOfItems.text intValue]];
    
    // Get all orders ordered by targetId in the current date
    NSArray *orders = [Order loadOrdersByTarget:targetId andDate:currentDate];
    
    
    // Check if it's 1st or 2nd item of the target
    // x2 of the same product - Save 2 items in local db (Cart)
    if(([orders count] == MAX_PER_EMPLOYEE) ||
       ([orders count] + [numOfItems intValue] > MAX_PER_EMPLOYEE) ||
       ([numOfItemsFromServer intValue] + [orders count] + [numOfItems intValue] > MAX_PER_EMPLOYEE)) {
        // Alert - Can't order anymore!
        [[[UIAlertView alloc] initWithTitle:@"שגיאה"
                                    message:[NSString stringWithFormat:@"עברת את הגבלת הפריטים ליום"]
                                   delegate:nil
                          cancelButtonTitle:@"אישור"
                          otherButtonTitles:nil] show];
        
        // Remove the popup
        [self.currentPopup removeAnimate];
        return;
    }
    // LowPrice is the price of the first product
    // highPrice is the price of the other products
    NSNumber *lowPrice;
    NSNumber *highPrice;
    
    if(numOfItems == 0) {
        [self.currentPopup removeAnimate];
        return;
    }
    // Max items order in local data
    if(([numOfItems intValue] == MAX_PER_EMPLOYEE) && ([numOfItemsFromServer intValue] == 0)){
        lowPrice = [NSNumber numberWithFloat:([prod.price floatValue] * 0.9)];
        highPrice = prod.price;
    }
    // Already ordered item/s
    else if (([numOfItems intValue] == MAX_PER_EMPLOYEE - 1) && ([numOfItemsFromServer intValue] > 0)) {
        highPrice = prod.price;
    }
    
    NSError *error;
    
    //build an info object and convert to json
    NSDictionary* info = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"value1", @"key1",
                          @"value2", @"key2",
                          @"value3", @"key3",
                          nil];
    
    //convert object to data
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:info
                                                       options:NSJSONWritingPrettyPrinted error:&error];
    
    //print out the data contents
    NSString *jsonSummary = [[NSString alloc] initWithData:jsonData
                                                  encoding:NSUTF8StringEncoding];
    NSLog(@"%@", jsonSummary);
    
    [Order saveOrder:[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil]];
    
}

#warning edit
- (void) errorFound:(NSError *) error{
    // Show error messege.
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"alert" message:@"Wrong ID or Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark - PopUpViewDelegate
- (void) addToCart:(id) popup
{
    self.currentPopup = (CustomPopUp *)popup;
    
    /*
    // Create the array of the order //
    
    // The id of employee who makes the order
    NSNumber *employeeId = [Employee getSessionId];
    // Get the target name + id
    NSInteger selectedTargetIndex = [currentPopup.targetPicker selectedRowInComponent:0];
    NSNumber *targetId;
    NSString *targetName;
    // If for me
    if(selectedTargetIndex == 0) {
        targetId = employeeId;
        targetName = [Employee getSessionName];
    }
    else {
        // Check in local db who is the target
        Authorization *auth = (Authorization *)[[Authorization loadAuth] objectAtIndex:selectedTargetIndex];
        targetId = auth.target_id;
        targetName = auth.name;
    }
    
    // Get the product which selected in carousel
    Product *prod = [Product getProductByIndex:currentPopup.productIndex];
    // Get the product id
    NSNumber *prodId = prod.prod_id;
    // Save the current date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-mm-dd"];
    NSString *currentDate = [formatter stringFromDate:[NSDate date]];
    NSNumber *numOfItems = [NSNumber numberWithInt:[currentPopup.numOfItems.text intValue]];
    
    // Get all orders ordered by targetId in the current date
    NSArray *orders = [Order loadOrdersByTarget:targetId andDate:currentDate];

    
    // Check if it's 1st or 2nd item of the target
    // x2 of the same product - Save 2 items in local db (Cart)
    if(([orders count] == MAX_PER_ITEM) ||
       ([orders count] + [numOfItems intValue] > MAX_PER_ITEM) ||
        (fromServer + [orders count] + [numOfItems intValue] > MAX_PER_ITEM)) {
        // Alert - Can't order anymore!
        [[[UIAlertView alloc] initWithTitle:@"שגיאה"
                                    message:[NSString stringWithFormat:@"עברת את הגבלת הפריטים ליום"]
                                   delegate:nil
                          cancelButtonTitle:@"אישור"
                          otherButtonTitles:nil] show];
        
        // Remove the popup
        [currentPopup removeAnimate];
        return;
    }
    if([numOfItems intValue] == MAX_PER_ITEM) {
        NSNumber *price1 = prod.price;
        NSNumber *price2 = [NSNumber numberWithInt:([prod.price intValue] + 10)];
    }
    NSError *error;
    
    //build an info object and convert to json
    NSDictionary* info = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"value1", @"key1",
                          @"value2", @"key2",
                          @"value3", @"key3",
                          nil];
    
    //convert object to data
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:info 
                                                       options:NSJSONWritingPrettyPrinted error:&error];
    
    //print out the data contents
    NSString *jsonSummary = [[NSString alloc] initWithData:jsonData
                                             encoding:NSUTF8StringEncoding];
    NSLog(@"%@", jsonSummary);
    
    [Order saveOrder:[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil]];
  */
}

@end
