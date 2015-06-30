//
//  CartViewController.h
//  DanRestaurantApp
//
//  Created by Or on 6/28/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartTableViewCell.h"

@interface CartViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (assign, nonatomic, getter=isClicked) BOOL clicked;
-(IBAction)editButtonClicked:(id)sender;
-(IBAction)returnButtonClicked:(id)sender;

@property (weak, nonatomic) IBOutlet CartTableViewCell *cartCell;
@property (weak, nonatomic) IBOutlet UITableView *cartTableView;

@property (nonatomic, strong) NSMutableArray *foodImages;
@property (nonatomic, strong) NSMutableArray *foodNames;
@property (nonatomic, strong) NSMutableArray *foodPrices;
@property (nonatomic, strong) NSMutableArray *foodTargets;

@end
