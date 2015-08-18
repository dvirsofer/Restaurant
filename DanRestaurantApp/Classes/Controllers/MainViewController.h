//
//  MainViewController.h
//  DanRestaurantApp
//
//  Created by Dvir&Or on 6/29/15.
//  Copyright (c) 2015 Dvir&Or. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupNetworkManager.h"

@interface MainViewController : UIViewController <PopupNetworkManagerDelegate>

@property (weak, nonatomic) IBOutlet UIView *placeholderView;
@property (weak, nonatomic) UIViewController *currentViewController;
@property (strong, nonatomic) IBOutlet UILabel *employeeNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *dateLbl;

@end
