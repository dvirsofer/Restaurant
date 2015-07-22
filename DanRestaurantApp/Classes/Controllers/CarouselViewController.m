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

@interface CarouselViewController ()

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
    // Save items info in self.items array
    self.items = [Product setItemsArray: json];
    
    // Reload the carousel with updated items
    [self.carousel reloadData];
}

- (void) errorFound:(NSError *) error{
    // Show error messege.
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"alert" message:@"Wrong ID or Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark - PopUpViewDelegate
- (void) addToCart:(id) popup
{
    CustomPopUp *currentPopup = (CustomPopUp *)popup;
    // Create the array of the order
    // Get the target name + id
    //NSString *target_id = currentPopup.targetPicker
    
    NSNumber *employee_id = [Employee getSessionId];
    NSNumber *numOfItems = [NSNumber numberWithInt:[currentPopup.numOfItems.text intValue]];
    
    // TO BE CONTINUED....
    
    
    
    
}

@end
