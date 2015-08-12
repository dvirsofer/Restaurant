//
//  CheckViewNetworkManager.h
//  DanRestaurantApp
//
//  Created by Or on 8/10/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CheckViewNetworkManagerDelegate <NSObject>
@required
- (void) finishSaving;
- (void) errorFound:(NSError *)error;
@end

@interface CheckViewNetworkManager : NSObject

@property (nonatomic, strong) id<CheckViewNetworkManagerDelegate> delegate;

- (void) saveOrders:(NSMutableArray *) orders;

@end
