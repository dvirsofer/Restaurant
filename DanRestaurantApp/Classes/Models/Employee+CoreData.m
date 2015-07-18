//
//  Employee+CoreData.m
//  DanRestaurantApp
//
//  Created by Or on 7/17/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "Employee+CoreData.h"
#import "AppDelegate.h"

@implementation Employee (CoreData)

+ (void)saveEmployee:(NSDictionary *)employeeDict {
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appdelegate managedObjectContext];
    
    Employee *employee = [[Employee alloc] init];
    
    NSNumber *employee_id =[employeeDict valueForKey:@"employee_id"];
    employee.employee_id = [employeeDict valueForKey:@"employee_id"] != NSNull.null ? employee_id : [NSNumber numberWithInt:0];
    
    NSString *name = [employeeDict valueForKey:@"employee_name"];
    employee.name = [employeeDict valueForKey:@"employee_name"] != NSNull.null ? name : @"";
    
    NSNumber *personal_number =[employeeDict valueForKey:@"personal_number"];
    employee.personal_number = [employeeDict valueForKey:@"personal_number"] != NSNull.null ? personal_number : [NSNumber numberWithFloat:0];

    // save coredata context here. cderror should include the operation error,if occured
    NSError *cderror;
    
    if (![context save:&cderror]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", cderror, [cderror userInfo]);
        abort();  // Abort save operation if failed
    }
}

@end
