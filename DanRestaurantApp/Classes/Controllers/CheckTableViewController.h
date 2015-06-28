//
//  CheckTableViewController.h
//  DanRestaurantApp
//
//  Created by Or on 6/27/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckTableViewCell.h"

@interface CheckTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *foodImages;
@property (nonatomic, strong) NSArray *foodNames;
@property (nonatomic, strong) NSArray *foodPrices;
@property (nonatomic, strong) NSArray *foodTargets;

@end
