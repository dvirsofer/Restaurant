//
//  HelpFunction.m
//  DanRestaurantApp
//
//  Created by Dvir&Or on 7/25/15.
//  Copyright (c) 2015 Dvir&Or. All rights reserved.
//

#import "HelpFunction.h"

@implementation HelpFunction

+(void)showAlert:(NSString *)title andMessage:(NSString *)message {
    [[[UIAlertView alloc] initWithTitle:title
                            message:message
                            delegate:nil
                            cancelButtonTitle:@"אישור"
                            otherButtonTitles:nil] show];
}

@end
