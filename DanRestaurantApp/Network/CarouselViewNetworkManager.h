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
-(void) itemsFound:(NSNumber *)numOfItemsFromServer;
- (void) errorFound:(NSError *)error;
@end

@interface CarouselViewNetworkManager : NSObject

@property (nonatomic, strong) id<CarouselViewNetworkManagerDelegate> delegate;

- (void) getAllParams:(NSNumber *)option;
- (void) getGetItemsByTarget:(NSNumber *)targetId;

@end
