//
//  CheckViewController.m
//  DanRestaurantApp
//
//  Created by Or on 6/27/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "CheckViewController.h"

@interface CheckViewController ()

@end

@implementation CheckViewController

@synthesize checkCell = _checkCell;
@synthesize checkTableView = _checkTableView;

@synthesize foodImages = _foodImages;
@synthesize foodNames = _foodNames;
@synthesize foodPrices = _foodPrices;
@synthesize foodTargets = _foodTargets;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.foodNames count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"checkTableCell";
    
    CheckTableViewCell *cell = (CheckTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"CheckTableViewCell" owner:self options:nil];
        cell = _checkCell;
        _checkCell = nil;
    }
    
    if (cell == nil) {
        cell = [[CheckTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    cell.foodPrice.text = [self.foodPrices
                           objectAtIndex: [indexPath row]];
    
    cell.foodName.text = [self.foodNames
                          objectAtIndex:[indexPath row]];
    
    cell.foodTarget.text = [self.foodTargets
                            objectAtIndex:[indexPath row]];
    
    UIImage *foodPhoto = [UIImage imageNamed:
                          [self.foodImages objectAtIndex: [indexPath row]]];
    
    cell.foodImage.image = foodPhoto;
    
    return cell;
}


@end
