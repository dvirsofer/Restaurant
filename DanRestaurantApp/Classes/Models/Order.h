//
//  Order.h
//  DanRestaurantApp
//
//  Created by DvirSofer on 7/22/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Order : NSManagedObject

@property (nonatomic, retain) NSNumber * employee_id;
@property (nonatomic, retain) NSNumber * prod_id;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSNumber * target_id;
@property (nonatomic, retain) NSDate * order_date;
@property (nonatomic, retain) NSString * target_name;

@end
