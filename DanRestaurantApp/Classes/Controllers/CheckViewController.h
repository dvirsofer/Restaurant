//
//  CheckViewController.h
//  DanRestaurantApp
//
//  Created by Or on 6/27/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckTableViewController.h"

@interface CheckViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>


@property (weak,nonatomic) IBOutlet UITableView *tableView;

@end
