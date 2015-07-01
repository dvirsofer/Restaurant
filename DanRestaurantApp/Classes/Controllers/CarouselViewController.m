//
//  CarouselViewController.m
//  DanRestaurantApp
//
//  Created by DvirSofer on 7/1/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "CarouselViewController.h"

@interface CarouselViewController ()

@end

@implementation CarouselViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    [carousel setType:iCarouselTypeCylinder];
    //self.images=[[NSMutableArray alloc]initWithObjects:@"dan_logo_x1.png",@"dan_logo_x1.png", @"dan_logo_x1.png", nil];
    return [self.images count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    view = [[UIView alloc] init];
    view.contentMode = UIViewContentModeScaleAspectFit;
    CGRect rec = view.frame;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        rec.size.width = 250;
        rec.size.height = 250;
    }
    view.frame = rec;
    UIImageView *iv;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    {
        iv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 240, 240)];
    }
    NSString *temp=[self.images objectAtIndex:index];
    iv.image=[UIImage imageNamed:temp];
    iv.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:iv];
    return view;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"Image is selected.");
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            return YES;
        }
        default:
        {
            return value;
        }
    }
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
