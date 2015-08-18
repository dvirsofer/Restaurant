//
//  LoginViewController.h
//  DanRestaurantApp
//
//  Created by Dvir&Or on 6/27/15.
//  Copyright (c) 2015 Dvir&Or. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginNetworkManager.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate, LoginNetworkManagerDelegate>
@end
