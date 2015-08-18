//
//  LoginNetworkManager.h
//  DanRestaurantApp
//
//  Created by Dvir&Or on 7/18/15.
//  Copyright (c) 2015 Dvir&Or. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LoginNetworkManagerDelegate <NSObject>
@required
- (void) resultFound:(NSArray *)employee;
- (void) errorFound:(NSError *) error;
@end

@interface LoginNetworkManager : NSObject

@property (nonatomic, weak) id<LoginNetworkManagerDelegate>	delegate;

-(void) asyncLogin:(NSString *)employee_id withPass:(NSString *)personal_number;

@end
