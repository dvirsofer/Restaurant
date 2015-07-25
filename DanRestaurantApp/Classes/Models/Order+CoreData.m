//
//  Order+CoreData.m
//  DanRestaurantApp
//
//  Created by DvirSofer on 7/25/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "Order+CoreData.h"
#import "AppDelegate.h"

@implementation Order (CoreData)

/*!
 @discussion Save order in local database from json
 @param  NSArray json contains order information
 */
+ (void)saveOrder:(NSArray *)json {
    
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appdelegate managedObjectContext];
    
    // Set date formatter in order to convert from String to Date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    for (NSDictionary *obj in json) {
        Order *order = (Order *)[NSEntityDescription insertNewObjectForEntityForName:@"Order" inManagedObjectContext:context];
        order.target_id = [obj valueForKey:@"target_id"];
        order.target_name = [obj valueForKey:@"target_name"];
        order.employee_id = [obj valueForKey:@"employee_id"];
        order.prod_id = [obj valueForKey:@"prod_id"];
        order.price = [obj valueForKey:@"price"];
        order.order_date = [dateFormatter dateFromString:[obj valueForKey:@"order_date"]];
        order.img_url = [obj valueForKey:@"img_url"];
        order.prod_name = [obj valueForKey:@"prod_name"];
    }
    
    // save coredata context here. cderror should include the operation error,if occured
    NSError *cderror;
    
    if (![context save:&cderror]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", cderror, [cderror userInfo]);
        abort();  // Abort save operation if failed
    }
}

/*!
 @discussion Load all orders from local database
 @return Array of all orders
 */
+ (NSMutableArray *)loadOrders {
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Create and configure a fetch request with the Book entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Order" inManagedObjectContext:[appdelegate managedObjectContext]];
    [fetchRequest setEntity:entity];
    
    // Create the sort descriptors array.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"target_name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Create and initialize the fetch results controller.
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:appdelegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    NSError *error;
    
    if (![aFetchedResultsController performFetch:&error]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    // Get a mutable array from local data
    NSMutableArray *orders = [NSMutableArray arrayWithArray:[aFetchedResultsController fetchedObjects]];
    return orders;
}

/*!
 @discussion Delete all orders from local database
 */
+ (void)deleteAllOrders{
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appdelegate.managedObjectContext;
    
    NSMutableArray *orders = [self loadOrders];
    
    for (int i = 0; i < [orders count]; i++) {
        // Get order in index i
        Order *order = [orders objectAtIndex:i];
        // Remove it from context
        [context deleteObject:order];
    }
    
    // save coredata context here. cderror should include the operation error,if occured
    NSError *cderror;
    
    if (![context save:&cderror]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", cderror, [cderror userInfo]);
        abort();  // Abort save operation if failed
    }
}

/*!
 @discussion Load all orders from same target on the order date inserted
 @param  targetId- targeted employee.
 orderDate- input of the date the order has created
 @return Array of orders
 */
+ (NSArray *)loadOrdersByTarget:(NSNumber *)targetId andDate:(NSString *)orderDate {
    NSMutableArray *orders = [self loadOrders];
    int len = (int)[orders count] - 1;
    for (int i = len; i > 0; i--) {
        // Get order in index i
        Order *order = [orders objectAtIndex:i];
        // Convert NSDate to NSString
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/mm/yyyy"];
        NSString *stringDate = [formatter stringFromDate:order.order_date];
        // Check if this is not the target id or not the order date in order to remove
        // it from the array
        if((order.target_id != targetId) || (![stringDate isEqualToString:orderDate])){
            [orders removeObjectAtIndex:i];
        }
    }
    return orders;
}

@end
