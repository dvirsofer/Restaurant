//
//  Authorization+CoreData.h
//  DanRestaurantApp
//
//  Created by Or on 7/22/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "Authorization.h"

@interface Authorization (CoreData)

+ (void)saveAuth:(NSArray *)json;
+ (NSMutableArray *)loadAuth;
+ (void)deleteAllAuth;

@end
