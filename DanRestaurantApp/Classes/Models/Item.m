//
//  Item.m
//  DanRestaurantApp
//
//  Created by Or on 7/13/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "Item.h"

@implementation Item

@synthesize itemId, description, price, quantity, calories, imageUrl, type;

//- (instancetype) initWithItemId:(NSInteger)iId andDescription:(NSString *)iDescription andPrice:(float)iPrice andQuantity:(NSInteger)iQuantity andType:(NSInteger)iType andCalories:(NSInteger)iCalories andImageUrl:(NSString *)iUrl
//{
//    self = [super init];
//    if (self)
//    {
//        //_itemId = (JSON)
//        self.itemId = iId;
//        self.itemDescription = iDescription;
//        self.price = iPrice;
//        self.quantity = iQuantity;
//        self.type = iType;
//        self.calories = iCalories;
//        self.imageUrl = iUrl;
//    }
//    return self;
//}

// Init the object with information from a dictionary
- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary {
    if(self = [self init]) {
        // Assign all properties with keyed values from the dictionary
        itemId = [jsonDictionary objectForKey:@"item_id"];
        description = [jsonDictionary objectForKey:@"description"];
        price = [jsonDictionary objectForKey:@"price"];
        quantity = [jsonDictionary objectForKey:@"quantity"];
        type = [jsonDictionary objectForKey:@"type"];
        calories = [jsonDictionary objectForKey:@"calories"];
        imageUrl = [jsonDictionary objectForKey:@"img_url"];
    }
    
    return self;
}

@end
