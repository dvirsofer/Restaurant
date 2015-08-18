//
//  PopUpViewDelegate.h
//  DanRestaurantApp
//
//  Created by Dvir&Or on 7/22/15.
//  Copyright (c) 2015 Dvir&Or. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PopUpViewDelegate <NSObject>

-(void) addToCart:(id) popup;
-(void) endOrder:(id) popup;
-(NSString *) getAuthName:(NSInteger) row;
-(NSInteger) getCount;

@end
