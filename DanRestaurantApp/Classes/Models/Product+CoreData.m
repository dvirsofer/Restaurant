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
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:[json count]];
    
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appdelegate managedObjectContext];
    for (id object in json)
    {
        Product *prod = (Product*)[NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:context];
        prod.prod_id = [object valueForKey:@"item_id"];
        prod.prod_desc = [object valueForKey:@"description"];
        prod.price = [object valueForKey:@"price"];
        prod.quantity = [object valueForKey:@"quantity"];
        prod.type = [object valueForKey:@"type"];
        prod.calories = [object valueForKey:@"calories"];
        prod.img_url = [object valueForKey:@"img_url"];
        
        [items addObject:prod];
    }
    return items;
}


@end
