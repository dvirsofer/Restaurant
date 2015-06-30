//
//  MainViewController.h
//  DanRestaurantApp
//
//  Created by DvirSofer on 6/29/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartViewController.h"
//#import "HistoryViewController.h"

@interface MainViewController : UIViewController

-(IBAction)exitButtonAction:(id)sender;
-(IBAction)historyButtonAction:(id)sender;
-(IBAction)cartButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *placeholderView;
@property (weak, nonatomic) UIViewController *currentViewController;

@end
