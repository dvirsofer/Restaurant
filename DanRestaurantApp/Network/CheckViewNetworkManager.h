//
//  CheckViewNetworkManager.h
//  DanRestaurantApp
//
//  Created by Dvir&Or on 8/10/15.
//  Copyright (c) 2015 Dvir&Or. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CheckViewNetworkManagerDelegate <NSObject>
@required
- (void) finishSaving;
- (void) errorFound:(NSError *)error;
@end

@interface CheckViewNetworkManager : NSObject

@property (nonatomic, weak) id<CheckViewNetworkManagerDelegate> delegate;

- (void) saveOrders:(NSMutableArray *) orders;

@end
