//
//  CheckViewController.h
//  DanRestaurantApp
//
//  Created by Or on 6/27/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckTableViewCell.h"

@interface CheckViewController : UIViewController

@property (weak, nonatomic) IBOutlet CheckTableViewCell *checkCell;
@property (strong, nonatomic) IBOutlet UITableView *checkTableView;

@end
