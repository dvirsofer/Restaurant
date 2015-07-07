//
//  LoginViewController.h
//  DanRestaurantApp
//
//  Created by Or on 6/27/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *personal_number;
@property (strong, nonatomic) IBOutlet UITextField *password;

@end
