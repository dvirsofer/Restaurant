//
//  CarouselViewController.m
//  DanRestaurantApp
//
//  Created by DvirSofer on 7/1/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "CarouselViewController.h"
#import "CustomPopUp.h"

@interface CarouselViewController ()

@end

@implementation CarouselViewController

@synthesize carousel;

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
    
    //configure carousel
    //carousel.type = iCarouselTypeCoverFlow2;
    carousel.type = iCarouselTypeCylinder;
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
    return [self.images count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIButton *button;
    //create new view if no view is available for recycling
    if(view == nil)
    {
        button = (UIButton *)view;
        //UIImage *image = [UIImage imageNamed:[self.images objectAtIndex:index]];
        NSString *ImageURL = @"http://www.sweeteatstraditions.com/wp-content/uploads/2014/02/tuna.jpg";
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
        [description setText:@"טונה"];
        description.font = [UIFont boldSystemFontOfSize:16];
        description.textAlignment = NSTextAlignmentCenter;
        [description setTextColor:[UIColor darkGrayColor]];
        [description setBackgroundColor:[UIColor clearColor]];
        [button addSubview:description];
        
        UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(0, 180, 200, 100)];
        [price setFont:[UIFont fontWithName:@"Arial-BoldMT" size:13]];
        [price setText: @"5.60 ש״ח"];
        price.font = [UIFont boldSystemFontOfSize:16];
        price.textAlignment = NSTextAlignmentCenter;
        [price setTextColor:[UIColor darkGrayColor]];
        [price setBackgroundColor:[UIColor clearColor]];
        [button addSubview:price];

        button.tag = index;
        [button addTarget:self.tabViewController action:@selector(buttonIsPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}

-(void) buttonIsPressed:(UIButton *)sender
{
    NSLog(@"Pressed");
}

-(void)setCustomImages:(int)option
{
    if(option == 0) {
        self.images=[[NSMutableArray alloc]initWithObjects:@"dan_logo.png",@"dan_logo.png", @"dan_logo.png", nil];
    }
    else {
        self.images=[[NSMutableArray alloc]initWithObjects:@"dan_logo.png",@"dan_logo.png", @"dan_logo.png", @"dan_logo.png", nil];
    }
}

@end
