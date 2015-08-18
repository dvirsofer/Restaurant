//
//  HistoryNetworkManager.h
//  DanRestaurantApp
//
//  Created by Dvir&Or on 8/13/15.
//  Copyright (c) 2015 Dvir&Or. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HistoryNetworkManagerDelegate <NSObject>
@required
- (void) resultsFound:(NSArray *)json;
- (void) ordersFound:(NSArray *)json;
- (void) errorFound:(NSError *)error;
@end

@interface HistoryNetworkManager : NSObject

@property (nonatomic, strong) id<HistoryNetworkManagerDelegate> delegate;
-(void)getHistory:(NSNumber *)employeeId;
-(void)getHistoryByDate:(NSString *)orderDate;

@end
