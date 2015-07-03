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
    //UILabel *label = nil;
    UIButton *button = nil;
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)];
        ((UIImageView *)view).image = [UIImage imageNamed:@"page.png"];
        view.contentMode = UIViewContentModeCenter;
        /*label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        [view addSubview:label];*/
        
        //button = [UIButton buttonWithType:UIButtonTypeSystem];
        //button.backgroundColor = [UIColor cle];
        
        // Button settings
        button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.backgroundColor = [UIColor clearColor];
        button.frame = CGRectMake(85.0f, 100.0f, 150.0f, 37.0f);
        [button setTitle:@"הזמן" forState:UIControlStateNormal];
        [button setTitle:@"Button is Pressed" forState:UIControlStateHighlighted];
        //add action to capture the button press down event
        [button addTarget:self action:@selector(buttonIsPressed) forControlEvents:UIControlEventTouchUpInside];
        //[button addTarget:self action:@selector(buttonIsPressed) forControlEvents:UIControlEventTouchDown];
        //add action to capture when the button is released
        //[button addTarget:self action:@selector(buttonIsReleased:) forControlEvents:UIControlEventTouchUpInside];
        //set button tag
        [button setTag:1];
        //add the button to the view
        //[self.view addSubview:button];

        
        button.center = CGPointMake(320/2, 60);
        
        //button.frame = CGRectMake(60.0f, 200.0f, 200.0f, 37.0f);
        
        //[button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:button];
        [view addSubview:button];
    }
    else
    {
        button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        //get a reference to the label in the recycled view
        button = (UIButton *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    //label.text = [items[index] stringValue];
    //[button setTitle:@"Press Me" forState:UIControlStateNormal];
    [button sizeToFit];
    [button setTag:index];
    
    return view;
}

- (void) buttonIsPressed
{
    NSLog(@"My Standard Button is pressed down.");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ROFL"
                                                    message:@"Dee dee doo doo."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];

}

- (void) buttonIsReleased:(UIButton *)paramSender{
    switch (paramSender.tag) {
        case 1:
            NSLog(@"My Standard Button was just released.");
            break;
        case 2:
            NSLog(@"My Custom Image Button was just released.");
            break;
        default:
            NSLog(@"No idea which Button was just released.");
            break;
    }
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

- (void) buttonPressed:(UIButton *)paramSender
{
    NSLog(@"Hi");
    
}


@end
