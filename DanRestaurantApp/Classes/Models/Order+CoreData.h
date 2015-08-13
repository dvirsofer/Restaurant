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
+ (NSMutableArray *)loadOrders:(NSNumber *)employee_id;
+ (void)deleteAllOrders:(NSNumber *)employee_id;
+ (NSArray *)loadOrdersByTarget:(NSNumber *)targetId andDate:(NSString *)orderDate andEmployeeId:(NSNumber *)employee_id;
+ (void)removeOrder:(Order *)order;
+ (NSNumber *)getTotalPrice:(NSNumber *)employee_id;
+ (void)updateOrderPrice: (Order *)order andEmployeeId:(NSNumber *)employee_id;
+ (NSNumber *)getNumOfProductById:(NSNumber *)prodId andEmployeeId:(NSNumber *)employee_id;

@end
