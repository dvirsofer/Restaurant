//
//  HelpFunction.m
//  DanRestaurantApp
//
//  Created by DvirSofer on 7/25/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "HelpFunction.h"

@implementation HelpFunction

-(void)showAlert:(NSString *)alert {
    [[[UIAlertView alloc] initWithTitle:@"שגיאה"
                               message:alert delegate:nil
                     cancelButtonTitle:@"אישור"
                      otherButtonTitles:nil] show];
}

@end
