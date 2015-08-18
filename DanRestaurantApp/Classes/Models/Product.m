//
//  Product.m
//  DanRestaurantApp
//
//  Created by Dvir&Or on 7/18/15.
//  Copyright (c) 2015 Dvir&Or. All rights reserved.
//

#import "Product.h"


@implementation Product

@dynamic prod_desc;
@dynamic calories;
@dynamic img_url;
@dynamic prod_id;
@dynamic price;
@dynamic quantity;
@dynamic type;

/*+ (NSMutableArray *) setItemsArray: (NSArray *)json {
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:[json count]];
    for (id object in json)
    {
        Product *prod = [[Product alloc] init];
        
        prod.prod_id = [object valueForKey:@"item_id"];
        prod.prod_desc = [object valueForKey:@"description"];
        prod.price = [object valueForKey:@"price"];
        prod.quantity = [object valueForKey:@"quantity"];
        prod.type = [object valueForKey:@"type"];
        prod.calories = [object valueForKey:@"calories"];
        prod.img_url = [object valueForKey:@"img_url"];

        
        NSNumber *item_id = [object valueForKey:@"item_id"];
        NSString *description = [object valueForKey:@"description"];
        NSNumber *price = [object valueForKey:@"price"];
        NSNumber *quantity = [object valueForKey:@"quantity"];
        NSNumber *type = [object valueForKey:@"type"];
        NSNumber *calories = [object valueForKey:@"calories"];
        NSString *img_url = [object valueForKey:@"img_url"];
        
        //Product *prod = [[Product alloc] initWithItemId:item_id andDescription:description andPrice:price andQuantity:quantity andType:type andCalories:calories andImageUrl:img_url];
        
        [items addObject:prod];
    }
    return items;
}*/

/*- (instancetype) initWithItemId:(NSNumber *)iId andDescription:(NSString *)iDescription andPrice:(NSNumber *)iPrice andQuantity:(NSNumber *)iQuantity andType:(NSNumber *)iType andCalories:(NSNumber *)iCalories andImageUrl:(NSString *)iUrl {
    self = [super init];
    if (self)
    {
        NSLog(@"%@", iId);
        NSLog(@"%@", self.prod_id);
        
        self.prod_id = iId;
        self.prod_desc = iDescription;
        self.price = iPrice;
        self.quantity = iQuantity;
        self.type = iType;
        self.calories = iCalories;
        self.img_url = iUrl;
    }
    return self;
}*/


@end
