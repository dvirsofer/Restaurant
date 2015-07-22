//
//  Authorization+CoreData.m
//  DanRestaurantApp
//
//  Created by Or on 7/22/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "Authorization+CoreData.h"
#import "AppDelegate.h"

@implementation Authorization (CoreData)

+ (void)saveAuth:(NSArray *)json {
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appdelegate managedObjectContext];
    
    /*Authorization *target = (Authorization*)[NSEntityDescription insertNewObjectForEntityForName:@"Authorization" inManagedObjectContext:context];
    // Get the json information
    target.target_id = [json[0] valueForKey:@"target_id"];
    target.name = [json[0] valueForKey:@"name"];*/
    for (id object in json)
    {
        Authorization *target = (Authorization*)[NSEntityDescription insertNewObjectForEntityForName:@"Authorization" inManagedObjectContext:context];
        target.target_id = [object valueForKey:@"target_id"];
        target.name = [object valueForKey:@"name"];
    }
    
    // save coredata context here. cderror should include the operation error,if occured
    NSError *cderror;
    
    if (![context save:&cderror]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", cderror, [cderror userInfo]);
        abort();  // Abort save operation if failed
    }
}

+ (NSMutableArray *)loadAuth {
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Create and configure a fetch request with the Book entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Authorization" inManagedObjectContext:[appdelegate managedObjectContext]];
    [fetchRequest setEntity:entity];
    
    // Create the sort descriptors array.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"target_id" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Create and initialize the fetch results controller.
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:appdelegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    NSError *error;
    
    if (![aFetchedResultsController performFetch:&error]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    // Get a mutable array from local data (to insert "My self" in the future
    NSMutableArray *auths = [NSMutableArray arrayWithArray:[aFetchedResultsController fetchedObjects]];
    return auths;
}

+ (void)deleteAllAuth {
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appdelegate.managedObjectContext;
    
    NSArray *auths = [self loadAuth];
    
    for (int i = 0; i < [auths count]; i++) {
        // Get authorization in index i
        Authorization *auth = [auths objectAtIndex:i];
        // Remove it from context
        [context deleteObject:auth];
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
