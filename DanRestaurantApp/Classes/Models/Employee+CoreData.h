//
//  Employee+CoreData.h
//  DanRestaurantApp
//
//  Created by Dvir&Or on 7/17/15.
//  Copyright (c) 2015 Dvir&Or. All rights reserved.
//

#import "Employee.h"

@interface Employee (CoreData)

+ (void)saveEmployee:(NSArray *)json;
//+ (Employee *)getEmployee;
+ (void)deleteAllEmployees;
+ (NSArray *)loadAllEmployees;
+ (NSString *)getSessionName;
+ (NSNumber *)getSessionId;

@end
