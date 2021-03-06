//
//  HistoryViewController.h
//  DanRestaurantApp
//
//  Created by Dvir&Or on 8/9/15.
//  Copyright (c) 2015 Dvir&Or. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCollapseTableView.h"
#import "HistoryNetworkManager.h"

@interface HistoryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, HistoryNetworkManagerDelegate>

@property (strong, nonatomic) IBOutlet STCollapseTableView *tableView;

@end
