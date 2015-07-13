//
//  Item.h
//  DanRestaurantApp
//
//  Created by Or on 7/13/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

- (id)initWithJSONDictionary:(NSDictionary *)jsonDictionary;

@property (nonatomic) NSNumber *itemId;
@property (nonatomic) NSString *itemDescription;
@property (nonatomic) NSNumber *price;
@property (nonatomic) NSNumber *quantity;
@property (nonatomic) NSNumber *type;
@property (nonatomic) NSNumber *calories;
@property (nonatomic) NSString *imageUrl;

@end
