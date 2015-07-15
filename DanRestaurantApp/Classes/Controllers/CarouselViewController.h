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

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSNumber *customItemsOption; // property for holding the option type

@property (nonatomic, strong) MainViewController *tabViewController;
@property (nonatomic, strong) IBOutlet iCarousel *carousel;

-(void) getAllParams:(NSNumber *)option;



@end
