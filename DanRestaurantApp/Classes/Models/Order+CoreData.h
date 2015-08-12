//
//  Order+CoreData.h
//  DanRestaurantApp
//
//  Created by DvirSofer on 7/25/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "Order.h"

@interface Order (CoreData)
+ (void)saveOrder:(NSArray *)json;
+ (NSMutableArray *)loadOrders;
+ (void)deleteAllOrders;
+ (NSArray *)loadOrdersByTarget:(NSNumber *)targetId andDate:(NSString *)orderDate;
+ (void)removeOrder:(Order *)order;
+ (NSNumber *)getTotalPrice;
+ (void)updateOrderPrice: (Order *)order;
+ (NSNumber *)getNumOfProductById:(NSNumber *)prodId;

@end
