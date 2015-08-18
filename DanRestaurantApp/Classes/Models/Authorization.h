//
//  Authorization.h
//  DanRestaurantApp
//
//  Created by Dvir&Or on 7/22/15.
//  Copyright (c) 2015 Dvir&Or. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Authorization : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * target_id;

@end
