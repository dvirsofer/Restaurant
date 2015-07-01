//
//  CarouselViewController.h
//  DanRestaurantApp
//
//  Created by DvirSofer on 7/1/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface CarouselViewController : UIViewController
-(void)setCustomImages:(int)option;

@property (nonatomic, strong) IBOutlet iCarousel *carousel;
@property (nonatomic, strong) NSArray *images;

@end