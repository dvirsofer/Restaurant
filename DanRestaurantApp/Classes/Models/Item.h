//
//  Item.h
//  DanRestaurantApp
//
//  Created by Or on 7/13/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (nonatomic) NSInteger itemId;
@property (nonatomic) NSString *itemDescription;
@property (nonatomic) float price;
@property (nonatomic) NSInteger quantity;
@property (nonatomic) NSInteger type;
@property (nonatomic) NSInteger calories;
@property (nonatomic) NSString *imageUrl;

@end
