//
//  CarouselViewController.m
//  DanRestaurantApp
//
//  Created by DvirSofer on 7/1/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "CarouselViewController.h"

@interface CarouselViewController ()

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation CarouselViewController

@synthesize carousel;
@synthesize items;

- (void)awakeFromNib
{
    //set up data
    //your carousel should always be driven by an array of
    //data of some kind - don't store data in your item views
    //or the recycling mechanism will destroy your data once
    //your item views move off-screen
    self.items = [NSMutableArray array];
    for (int i = 0; i < 5; i++)
    {
        [items addObject:@(i)];
    }
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
    
    //configure carousel
    carousel.type = iCarouselTypeCoverFlow2;
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
    return [items count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIButton *button = (UIButton *)view;
    //create new view if no view is available for recycling
    if (button == nil)
    {
        //no button available to recycle, so create new one
        UIImage *image = [UIImage imageNamed:@"page.png"];
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        button.titleLabel.font = [button.titleLabel.font fontWithSize:50];
        button.tag = index;
        [button addTarget:self.tabViewController action:@selector(buttonIsPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    //set button label
    [button setTitle:[NSString stringWithFormat:@"%li", (long)index] forState:UIControlStateNormal];
    
    return button;
}

- (void) buttonIsPressed:(UIButton *)sender
{
    //get item index for button
    NSInteger index = [sender tag];
    
    [[[UIAlertView alloc] initWithTitle:@"Button Tapped"
                                message:[NSString stringWithFormat:@"You tapped button number %li", (long)index]
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

-(void)setCustomImages:(int)option
{
    if(option == 0) {
        //self.images=[[NSMutableArray alloc]initWithObjects:@"dan_logo_x1.png",@"dan_logo_x1.png", @"dan_logo_x1.png", nil];
    }
    else {
        //self.images=[[NSMutableArray alloc]initWithObjects:@"dan_logo_x1.png",@"dan_logo_x1.png", @"dan_logo_x1.png", @"dan_logo_x1.png", nil];
    }
}

@end
