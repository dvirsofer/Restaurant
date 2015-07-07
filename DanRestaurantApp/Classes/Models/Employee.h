//
//  Employee.h
//  DanRestaurantApp
//
//  Created by Or on 7/7/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Employee : NSObject

@property (strong, nonatomic) NSString *employeeId;
@property (strong, nonatomic) NSString *personalNumber;
@property (strong, nonatomic) NSString *employeeName;

-(id) initWithEmployeeId: (NSString *) eId andPersonalNumber: (NSString *) pNumber andEmployeeName: (NSString *)eName;

@end
