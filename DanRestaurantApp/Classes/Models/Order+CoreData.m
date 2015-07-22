//
//  Order+CoreData.m
//  DanRestaurantApp
//
//  Created by DvirSofer on 7/22/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "Order+CoreData.h"
#import "AppDelegate.h"

@implementation Order (CoreData)

+ (void)saveOrder:(NSArray *)json {
    
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appdelegate managedObjectContext];
    
    Order *order = (Order *)[NSEntityDescription insertNewObjectForEntityForName:@"Order" inManagedObjectContext:context];
    order.target_id = [json valueForKey:@"target_id"];
    order.target_name = [json valueForKey:@"target_name"];
    order.employee_id = [json valueForKey:@"employee_id"];
    order.prod_id = [json valueForKey:@"prod_id"];
    order.price = [json valueForKey:@"price"];
    order.order_date = [json valueForKey:@"order_date"];
    
    // save coredata context here. cderror should include the operation error,if occured
    NSError *cderror;
    
    if (![context save:&cderror]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", cderror, [cderror userInfo]);
        abort();  // Abort save operation if failed
    }
}

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

@end
