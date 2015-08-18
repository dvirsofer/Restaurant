//
//  Employee.h
//  DanRestaurantApp
//
//  Created by Dvir&Or on 7/17/15.
//  Copyright (c) 2015 Dvir&Or. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Employee : NSManagedObject

@property (nonatomic, retain) NSNumber *employee_id;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *personal_number;

@end
