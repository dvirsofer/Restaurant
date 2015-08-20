//
//  CarouselViewController.m
//  DanRestaurantApp
//
//  Created by Dvir&Or on 7/1/15.
//  Copyright (c) 2015 Dvir&Or. All rights reserved.
//

#import "CarouselViewController.h"
#import "CustomPopUp.h"
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
- (void)dealloc
{
    //it's a good idea to set these to nil here to avoid
    //sending messages to a deallocated viewcontroller
    self.carousel.delegate = nil;
    self.carousel.dataSource = nil;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //setup spinner
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.view addSubview:self.hud];
    // Set the hud to display with a color
    self.hud.color = [UIColor colorWithRed:0.23 green:0.50 blue:0.82 alpha:0.90];
    [self.hud show:YES];
    

    // Remove all old products from local database
    [Product deleteAllProducts];
    
    // Init items on load
    self.networkManager = [[CarouselViewNetworkManager alloc] init];
    self.networkManager.delegate = self;
    [self.networkManager getAllParams: self.customItemsOption];
    
    //configure carousel
    self.carousel.type = iCarouselTypeCoverFlow2;
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
        // Create custom carousel view (which is clickable)
        button = [[CarouselView alloc] initWithItem:[self.items objectAtIndex:index] andVC:self andIndex:index];
        
        // Set button tag to save the index
        button.tag = index;
        [button addTarget:self action:@selector(buttonIsPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}

-(void) buttonIsPressed:(UIButton *)sender {
    // Get item index for button
    NSNumber *index = [NSNumber numberWithLong:[sender tag]];
    // Initiate the popup view
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // iPad
        self.popup = [[CustomPopUp alloc] initWithNibName:@"iPadPopupView" bundle:nil];
    } else {
        if ([UIScreen mainScreen].bounds.size.width > 320) {
            if ([UIScreen mainScreen].scale == 3) {
                // iPhone6Plus - 5.5" - 414x736
                self.popup = [[CustomPopUp alloc] initWithNibName:@"iPhone6PlusPopupView" bundle:nil];
            } else {
                // iPhone6 - 4.7" - 375x667
                self.popup = [[CustomPopUp alloc] initWithNibName:@"iPhone6PopupView" bundle:nil];
            }
        } else {
            if([UIScreen mainScreen].bounds.size.height > 480) {
                // iPhone 5/5s - 4"
                self.popup = [[CustomPopUp alloc] initWithNibName:@"iPhone5PopupView" bundle:nil];
            } else {
                // iPhone 4s and earlier - 3.5"
                self.popup = [[CustomPopUp alloc] initWithNibName:@"iPhone4PopupView" bundle:nil];
            }
        }
    }
    // Save the clicked item index
    self.popup.productIndex = index;
    // Get authorizations from local db
    self.auths = [Authorization loadAuth];
    // Insert "my self" to the authorized array
    [self.auths insertObject:[Authorization createMySelfTarget:[Employee getSessionId]] atIndex:0];

    // Set the popup delegate to be this controller
    self.popup.delegate = self;
    // Show popup
    [self.popup showInView:self.view animated:YES];
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
    NSArray *orders = [Order loadOrdersByTarget:targetId andDate:currentDate andEmployeeId:employeeId];
    
    // LowPrice is the price of the first product
    // highPrice is the price of the other products
    NSNumber *lowPrice = [NSNumber numberWithFloat:([prod.price floatValue] * 0.9)];
    NSNumber *highPrice = prod.price;
    NSMutableArray *prices;
    
    // Get number of items of the product in localDB
    NSNumber *numOfProducts = [Order getNumOfProductById:prodId andEmployeeId:employeeId];
    //******************** Check if there are items in quantity ********************//
    if([numOfItems intValue] + [numOfProducts intValue] > [prod.quantity intValue]) {
        // Show error message - out of quantity
        [HelpFunction showAlert:@"שגיאה" andMessage:@"אין מספיק מוצרים במלאי"];
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
        [HelpFunction showAlert:@"שגיאה" andMessage:@"עברת את הגבלת הפריטים ליום"];
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
    //convert products to NSData
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:products
                                                       options:NSJSONWritingPrettyPrinted error:&error];
    // Save in local database
    [Order saveOrder:[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil]];
    // Remove the popup
    [self.currentPopup removeAnimate];
}

- (void) errorFound:(NSError *) error{
    // Show error messege.
    [HelpFunction showAlert:@"שגיאה" andMessage:[error localizedDescription]];
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
        Authorization *auth = (Authorization *)[[Authorization loadAuth] objectAtIndex:selectedTargetIndex-1];
        targetId = auth.target_id;
    }
    // Get number of items from Server
    [self.networkManager getItemsByTarget:targetId];
}

-(void) endOrder:(id) popup
{
    [self addToCart:popup];
    // Check if has no items in localDB
    if([[Order loadOrders:[Employee getSessionId]] count] == 0 && [self.currentPopup.numOfItems.text isEqualToString:@"0"]) {
        // No items
        // Show "are you sure?" alert
        [HelpFunction showAlert:@"שגיאה" andMessage:@"אין מוצרים בעגלה"];
        return;
    }
    // Show "are you sure?" alert
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"הזמן"
                                                message:@"האם אתה בטוח שברצונך לסיים את ההזמנה?"
                                                delegate:self.tabViewController
                                                cancelButtonTitle:@"לא"
                                                otherButtonTitles:@"כן", nil];
    [alert show];
}

-(NSString *) getAuthName:(NSInteger)row {
    return ((Authorization *)[self.auths objectAtIndex:row]).name;
}

-(NSInteger) getCount {
    return [self.auths count];
}

@end
