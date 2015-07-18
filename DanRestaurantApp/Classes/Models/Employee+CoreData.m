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

/*+ (void)saveEmployee:(NSDictionary *)employeeDict {
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
}*/
+ (void)saveEmployee:(NSArray *)json {
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appdelegate managedObjectContext];

    Employee *new_employee = (Employee*)[NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:context];
    // Get the json information
    new_employee.employee_id = [json[0] valueForKey:@"employee_id"];
    new_employee.personal_number = [json[0] valueForKey:@"personal_number"];
    new_employee.name = [json[0] valueForKey:@"employee_name"];
    
    // save coredata context here. cderror should include the operation error,if occured
    NSError *cderror;
    
    if (![context save:&cderror]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", cderror, [cderror userInfo]);
        abort();  // Abort save operation if failed
    }
}

+(Employee *) getEmployee {
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Create and configure a fetch request with the Book entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Employee" inManagedObjectContext:[appdelegate managedObjectContext]];
    [fetchRequest setEntity:entity];
    
    // Create the sort descriptors array.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Create and initialize the fetch results controller.
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:appdelegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    NSError *error;
    
    if (![aFetchedResultsController performFetch:&error]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    NSArray *result = [aFetchedResultsController fetchedObjects];
    NSLog(@"%@", result);
    return [result objectAtIndex:0];
}

@end
