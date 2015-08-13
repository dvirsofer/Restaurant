//
//  HistoryViewController.h
//  DanRestaurantApp
//
//  Created by Or on 8/9/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCollapseTableView.h"

@interface HistoryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (strong, nonatomic) IBOutlet STCollapseTableView *tableView;
@property (nonatomic, strong) NSMutableArray* data;
@property (nonatomic, strong) NSMutableArray* headers;


@end
