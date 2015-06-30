//
//  PastaViewController.h
//  DanRestaurantApp
//
//  Created by DvirSofer on 6/30/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface PastaViewController : UIViewController

@property (nonatomic, strong) IBOutlet iCarousel *carousel;
@property (nonatomic, strong) NSArray *images;

@end
