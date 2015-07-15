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
    [self getAllParams: self.customItemsOption];
    
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
    UIButton *button;
    //create new view if no view is available for recycling
    if(view == nil)
    {
        button = (UIButton *)view;
        // Get item from items array
        Item *item = [items objectAtIndex:index];
        
        // **********************
        // Move to Function!!!!!!
        // **********************
        NSString *ImageURL = item.imageUrl;
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
        UIImage *image = [UIImage imageWithData:imageData];
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor redColor]];
        [button setFrame:CGRectMake(0, 0, 200, 200)];
        
        button.imageView.contentMode = UIViewContentModeCenter;
        
        //Create Label
        UILabel *description = [[UILabel alloc]initWithFrame:CGRectMake(0, 160, 200, 100)];
        [description setFont:[UIFont fontWithName:@"Arial-BoldMT" size:13]];
        [description setText:item.itemDescription];
        description.font = [UIFont boldSystemFontOfSize:16];
        description.textAlignment = NSTextAlignmentCenter;
        [description setTextColor:[UIColor darkGrayColor]];
        [description setBackgroundColor:[UIColor clearColor]];
        [button addSubview:description];
        
        UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(0, 180, 200, 100)];
        [price setFont:[UIFont fontWithName:@"Arial-BoldMT" size:13]];
        [price setText: [[NSString stringWithFormat:@"%f", item.price] stringByAppendingString:@"ש״ח"]];
        price.font = [UIFont boldSystemFontOfSize:16];
        price.textAlignment = NSTextAlignmentCenter;
        [price setTextColor:[UIColor darkGrayColor]];
        [price setBackgroundColor:[UIColor clearColor]];
        [button addSubview:price];
        
        UILabel *calories = [[UILabel alloc]initWithFrame:CGRectMake(0, 200, 200, 100)];
        [calories setFont:[UIFont fontWithName:@"Arial-BoldMT" size:13]];
        [calories setText:[[NSString stringWithFormat:@"%ld", (long)item.calories] stringByAppendingString:@"קלוריות"]];
        
        calories.font = [UIFont boldSystemFontOfSize:16];
        calories.textAlignment = NSTextAlignmentCenter;
        [calories setTextColor:[UIColor darkGrayColor]];
        [calories setBackgroundColor:[UIColor clearColor]];
        [button addSubview:calories];
        
        UILabel *quantity = [[UILabel alloc]initWithFrame:CGRectMake(0, 220, 200, 100)];
        [quantity setFont:[UIFont fontWithName:@"Arial-BoldMT" size:13]];
        [quantity setText: [[NSString stringWithFormat:@"%ld", (long)item.quantity] stringByAppendingString:@"במלאי"]];
        quantity.font = [UIFont boldSystemFontOfSize:16];
        quantity.textAlignment = NSTextAlignmentCenter;
        [quantity setTextColor:[UIColor darkGrayColor]];
        [quantity setBackgroundColor:[UIColor clearColor]];
        [button addSubview:quantity];

        button.tag = index;
        [button addTarget:self.tabViewController action:@selector(buttonIsPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}

-(void) getAllParams:(NSNumber *)option
{
    NSString *url = @"http://webmail.dan.co.il/restaurantservice/RestaurantService.svc/GetItems";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *params = @ {@"type" : option};
    
    [[manager operationQueue] waitUntilAllOperationsAreFinished];
    
    [manager POST:url parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *response = [operation responseString];

         NSData *objectData = [response dataUsingEncoding:NSUTF8StringEncoding];
         
         NSArray *json = [NSJSONSerialization JSONObjectWithData:objectData options:NSJSONReadingMutableContainers error:nil];
         
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
         [self.carousel reloadData];
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
     }];

}

-(void) buttonIsPressed:(UIButton *)sender
{
    NSLog(@"Pressed");
}

@end
