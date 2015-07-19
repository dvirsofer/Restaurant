//
//  Product.h
//  DanRestaurantApp
//
//  Created by DvirSofer on 7/18/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Product : NSManagedObject

@property (nonatomic, retain) NSString * prod_desc;
@property (nonatomic, retain) NSNumber * calories;
@property (nonatomic, retain) NSString * img_url;
@property (nonatomic, retain) NSNumber * prod_id;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSNumber * quantity;
@property (nonatomic, retain) NSNumber * type;

//+ (NSMutableArray *) setItemsArray: (NSArray *)json;
//- (instancetype) initWithItemId:(NSNumber *)iId andDescription:(NSString *)iDescription andPrice:(NSNumber *)iPrice andQuantity:(NSNumber *)iQuantity andType:(NSNumber *)iType andCalories:(NSNumber *)iCalories andImageUrl:(NSString *)iUrl;

@end
