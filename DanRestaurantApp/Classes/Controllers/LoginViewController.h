//
//  LoginViewController.h
//  DanRestaurantApp
//
//  Created by Or on 6/27/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginNetworkManager.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate, LoginNetworkManagerDelegate>
@end
