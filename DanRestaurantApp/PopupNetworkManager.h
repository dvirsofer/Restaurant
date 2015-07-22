//
//  PopupNetworkManager.h
//  DanRestaurantApp
//
//  Created by Or on 7/21/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PopupNetworkManagerDelegate <NSObject>
@required
- (void) resultsFound:(NSArray *)json;
- (void) errorFound:(NSError *) error;
@end

@interface PopupNetworkManager : NSObject

@property (nonatomic, weak) id<PopupNetworkManagerDelegate>	delegate;

- (void)loadAuthorizations:(NSNumber *)employee_id;

@end
