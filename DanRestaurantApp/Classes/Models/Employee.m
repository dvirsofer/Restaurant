//
//  Employee.m
//  DanRestaurantApp
//
//  Created by Or on 7/7/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "Employee.h"

@implementation Employee

@synthesize employeeId, personalNumber, employeeName;


- (id) initWithEmployeeId:(NSString *)eId andPersonalNumber:(NSString *)pNumber andEmployeeName:(NSString *)eName
{
    self = [super init];
    if (self)
    {
        employeeId = eId;
        personalNumber = pNumber;
        employeeName = eName;
    }
    return self;
}

@end
