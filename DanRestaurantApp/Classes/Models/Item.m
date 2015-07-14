//
//  Item.m
//  DanRestaurantApp
//
//  Created by Or on 7/13/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "Item.h"

@implementation Item

- (instancetype) initWithItemId:(NSInteger)iId andDescription:(NSString *)iDescription andPrice:(float)iPrice andQuantity:(NSInteger)iQuantity andType:(NSInteger)iType andCalories:(NSInteger)iCalories andImageUrl:(NSString *)iUrl
{
    self = [super init];
    if (self)
    {
        self.itemId = iId;
        self.itemDescription = iDescription;
        self.price = iPrice;
        self.quantity = iQuantity;
        self.type = iType;
        self.calories = iCalories;
        self.imageUrl = iUrl;
    }
    return self;
}

@end
