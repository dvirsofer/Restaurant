//
//  CarouselViewNetworkManager.h
//  DanRestaurantApp
//
//  Created by Or on 7/16/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CarouselViewNetworkManagerDelegate <NSObject>
@required
- (void) resultsFound:(NSArray *)items;
- (void) errorFound:(NSError *)error;
@end

@interface CarouselViewNetworkManager : NSObject

@property (nonatomic, weak) id<CarouselViewNetworkManagerDelegate>	delegate;

@end
