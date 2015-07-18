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
#import "Item.h"
#import "CarouselView.h"

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
    //[self getAllParams: self.customItemsOption];
    CarouselViewNetworkManager *networkManager = [[CarouselViewNetworkManager alloc] init];
    networkManager.delegate = self;
    //[networkManager ];
    
    //configure carousel
    carousel.type = iCarouselTypeCoverFlow2;
    //carousel.type = iCarouselTypeRotary;
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
        
        // Create
        button = [[CarouselView alloc] initWithItem:[items objectAtIndex:index]];
        
        button.tag = index;
        [button addTarget:self.tabViewController action:@selector(buttonIsPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}

#pragma mark - LoginNetworkManagerDelegate

- (void) resultFound:(NSArray *)json {
    
    
}

- (void) errorFound:(NSError *) error{
    //show error messege.
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"alert" message:@"Wrong ID or Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

/*Move To model
         items = [[NSMutableArray alloc] initWithCapacity:[json count]];
         for (id object in json) 
         {
             NSInteger item_id = [object[@"item_id"] intValue];
             NSString *description = object[@"description"];
             float price = [object[@"price"] floatValue];
             NSInteger quantity = [object[@"quantity"] intValue];
             NSInteger type = [object[@"type"] intValue];
             NSInteger calories = [object[@"calories"] intValue];
             NSString *img_url = object[@"img_url"];
             
             Item *item = [[Item alloc] initWithItemId:item_id andDescription:description andPrice:price andQuantity:quantity andType:type andCalories:calories andImageUrl:img_url];
             
             [items addObject:item];
         }
         [self.carousel reloadData];*/


-(void) buttonIsPressed:(UIButton *)sender
{
    NSLog(@"Pressed");
}

@end
