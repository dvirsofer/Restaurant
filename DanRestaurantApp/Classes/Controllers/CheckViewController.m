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


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
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
    
    // Configure the cell...
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

    
    return cell;
}


@end
