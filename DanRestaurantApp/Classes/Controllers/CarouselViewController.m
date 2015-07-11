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
    return [self.images count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIButton *button = (UIButton *)view;
    //create new view if no view is available for recycling
    if (button == nil)
    {
        //no button available to recycle, so create new one
        UIImage *image = [UIImage imageNamed:[self.images objectAtIndex:index]];
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
        [button setBackgroundImage:image forState:UIControlStateNormal];
        button.tag = index;
        [button addTarget:self.tabViewController action:@selector(buttonIsPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}

- (void) buttonIsPressed:(UIButton *)sender
{
    /*
    //get item index for button
    NSInteger index = [sender tag];

    self.tabViewController.popup = [[CustomPopUp alloc] initWithNibName:@"PopupView" bundle:nil];
    self.tabViewController.popupTitle.text = [NSString stringWithFormat:@"Index: %li", (long)index];
    [self.tabViewController.popup showInView:self.view animated:YES];
     */
}

-(void)setCustomImages:(int)option
{
    if(option == 0) {
        self.images=[[NSMutableArray alloc]initWithObjects:@"dan_logo_x1.png",@"dan_logo_x1.png", @"dan_logo_x1.png", nil];
    }
    else {
        self.images=[[NSMutableArray alloc]initWithObjects:@"dan_logo_x1.png",@"dan_logo_x1.png", @"dan_logo_x1.png", @"dan_logo_x1.png", nil];
    }
}

@end
