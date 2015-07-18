//
//  Authorization.h
//  DanRestaurantApp
//
//  Created by Or on 7/17/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Authorization : NSManagedObject

@property (nonatomic, retain) NSNumber * employee_id;
@property (nonatomic, retain) NSNumber * target_id;

@end
