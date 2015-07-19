//
//  MainViewController.h
//  DanRestaurantApp
//
//  Created by DvirSofer on 6/29/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartViewController.h"
#import "iCarousel.h"
#import "CustomPopUp.h"

@interface MainViewController : UIViewController

@property (strong, nonatomic) CustomPopUp *popup;
@property (weak, nonatomic) IBOutlet UIView *placeholderView;
@property (weak, nonatomic) UIViewController *currentViewController;
@property (strong, nonatomic) IBOutlet UILabel *employeeNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *dateLbl;

@end
