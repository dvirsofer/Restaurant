//
//  Product+CoreData.m
//  DanRestaurantApp
//
//  Created by Or on 7/19/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "Product+CoreData.h"
#import "AppDelegate.h"

@implementation Product (CoreData)

+ (NSMutableArray *) setItemsArray: (NSArray *)json {
    // Create new NSMutableArray in order to add the items in the json to the local db
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:[json count]];
    // Create AppDelegate and NSManagedObjectContext instances
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appdelegate managedObjectContext];
    
    // Insert all items in json
    for (id object in json)
    {
        // Create new Product instance
        Product *prod = (Product*)[NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:context];
        prod.prod_id = [object valueForKey:@"item_id"];
        prod.prod_desc = [object valueForKey:@"description"];
        prod.price = [object valueForKey:@"price"];
        prod.quantity = [object valueForKey:@"quantity"];
        prod.type = [object valueForKey:@"type"];
        prod.calories = [object valueForKey:@"calories"];
        prod.img_url = [object valueForKey:@"img_url"];
        // Insert to items mutable array
        [items addObject:prod];
    }
    // Return the items array
    return items;
}

// Get all products in local db
+ (NSArray *)loadAllProducts {
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Create and configure a fetch request with the Book entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:[appdelegate managedObjectContext]];
    [fetchRequest setEntity:entity];
    
    // Create the sort descriptors array.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"prod_id" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Create and initialize the fetch results controller.
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:appdelegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    NSError *error;
    
    if (![aFetchedResultsController performFetch:&error]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    NSArray *products = [aFetchedResultsController fetchedObjects];
    
    return products;
}

+ (Product *) getProductByIndex:(NSNumber *)productIndex {
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appdelegate managedObjectContext];

    NSArray *products = [Product loadAllProducts];
    /*// Safety
    if([products count] >= [productIndex intValue]) {
        return nil;
    }*/
    Product *prod = (Product*)[NSEntityDescription entityForName:@"Product" inManagedObjectContext:context];
    prod = (Product*)([products objectAtIndex:[productIndex intValue]]);
    return prod;
}

/*!
 @discussion Delete all products from local database
 */
+ (void)deleteAllProducts {
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appdelegate.managedObjectContext;
    
    NSArray *products = [self loadAllProducts];
    
    for (int i = 0; i < [products count]; i++) {
        // Get order in index i
        Product *product = [products objectAtIndex:i];
        // Remove it from context
        [context deleteObject:product];
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
