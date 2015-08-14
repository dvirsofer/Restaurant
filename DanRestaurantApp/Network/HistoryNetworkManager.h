//
//  HistoryNetworkManager.h
//  DanRestaurantApp
//
//  Created by Or on 8/13/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HistoryNetworkManagerDelegate <NSObject>
@required
- (void) resultsFound:(NSArray *)json;
- (void) errorFound:(NSError *)error;
@end

@interface HistoryNetworkManager : NSObject

@property (nonatomic, strong) id<HistoryNetworkManagerDelegate> delegate;
-(void)getHistory:(NSNumber *)employeeId;

@end
