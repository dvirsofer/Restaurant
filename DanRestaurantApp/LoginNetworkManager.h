//
//  LoginNetworkManager.h
//  DanRestaurantApp
//
//  Created by Or on 7/18/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Employee.h"

@protocol LoginNetworkManagerDelegate <NSObject>
@required
- (void) resultFound:(Employee *)employee;
- (void) errorFound;
@end

@interface LoginNetworkManager : NSObject

@property (nonatomic, weak) id<LoginNetworkManagerDelegate>	delegate;

-(void) asyncLogin:(NSString *)employee_id withPass:(NSString *)personal_number;

@end
