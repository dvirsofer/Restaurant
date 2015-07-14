//
//  CarouselViewController.h
//  DanRestaurantApp
//
//  Created by DvirSofer on 7/1/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "MainViewController.h"

@interface CarouselViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>

-(void)setCustomItems:(int)option;

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong) MainViewController *tabViewController;
@property (nonatomic, strong) IBOutlet iCarousel *carousel;


@end
