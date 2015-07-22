//
//  Product+CoreData.h
//  DanRestaurantApp
//
//  Created by Or on 7/19/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "Product.h"

@interface Product (CoreData)

+ (NSMutableArray *) setItemsArray: (NSArray *)json;
+ (Product *) getProductByIndex: (NSNumber *)productIndex;
+ (NSArray *)loadAllProducts;

@end
