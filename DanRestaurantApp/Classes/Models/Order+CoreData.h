//
//  Order+CoreData.h
//  DanRestaurantApp
//
//  Created by DvirSofer on 7/22/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "Order.h"

@interface Order (CoreData)

+ (void)saveOrder:(NSArray *)json;
+ (NSMutableArray *)loadOrders;
+ (void)deleteAllOrders;

@end
