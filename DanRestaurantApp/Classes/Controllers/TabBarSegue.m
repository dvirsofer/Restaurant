//
//  TabBarSegue.m
//  DanRestaurantApp
//
//  Created by Or on 6/29/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "TabBarSegue.h"
#import "MainViewController.h"

@implementation TabBarSegue

- (void) perform {
    MainViewController *src = (MainViewController *)self.sourceViewController;
    UIViewController *dst = (UIViewController *) self.destinationViewController;
    
    for(UIView *view in src.placeholderView.subviews){
        [view removeFromSuperview];
    }
    
    src.currentViewController = dst;
    [src.placeholderView addSubview:dst.view];
}

@end
