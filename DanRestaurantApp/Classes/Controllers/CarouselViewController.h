//
//  CarouselViewController.h
//  DanRestaurantApp
//
//  Created by Dvir&Or on 7/1/15.
//  Copyright (c) 2015 Dvir&Or. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "MainViewController.h"
#import "CarouselViewNetworkManager.h"
#import "CustomPopUp.h"

@interface CarouselViewController : UIViewController <iCarouselDataSource, iCarouselDelegate, CarouselViewNetworkManagerDelegate, PopUpViewDelegate>

@property (nonatomic, strong) CarouselViewNetworkManager *networkManager;

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSNumber *customItemsOption; // property for holding the option type

@property (strong, nonatomic) CustomPopUp *popup;
@property (strong, nonatomic) NSMutableArray *auths;

@property (nonatomic, strong) MainViewController *tabViewController;
@property (nonatomic, strong) IBOutlet iCarousel *carousel;



@end
