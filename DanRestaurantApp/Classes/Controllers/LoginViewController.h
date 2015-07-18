//
//  LoginViewController.h
//  DanRestaurantApp
//
//  Created by Or on 6/27/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "AppDelegate.h"
#import "MainViewController.h"
#import "Employee.h"
#import "LoginNetworkManager.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate, LoginNetworkManagerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *personal_number;
@property (strong, nonatomic) IBOutlet UITextField *password;

@property (strong, nonatomic) UINavigationController *vc;

@end
