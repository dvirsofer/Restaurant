//
//  Employee+CoreData.h
//  DanRestaurantApp
//
//  Created by Or on 7/17/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "Employee.h"

@interface Employee (CoreData)

//+(void)saveEmployee:(NSDictionary *)employeeDict;
+(void)saveEmployee:(NSArray *)json;
+(Employee *)getEmployee;

@end
