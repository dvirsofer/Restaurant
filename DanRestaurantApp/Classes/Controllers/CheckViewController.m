//
//  CheckViewController.m
//  DanRestaurantApp
//
//  Created by Or on 6/27/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "CheckViewController.h"
#import "CheckTableViewCell.h"
#import "Order+CoreData.h"

@interface CheckViewController ()

@property (strong, nonatomic) NSMutableArray *orders;
@property (strong, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet CheckTableViewCell *checkCell;
@property (weak, nonatomic) IBOutlet UITableView *checkTableView;

@end

@implementation CheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.orders = [Order loadOrders];
    self.priceLbl.text = [@"₪" stringByAppendingString:[[Order getTotalPrice] stringValue]];
    [self.checkTableView reloadData];
    self.navigationItem.hidesBackButton = YES; // Disable back button
}

- (IBAction)goBack:(id)sender {
    [[self presentingViewController] dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.orders count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"checkTableCell";
    
    CheckTableViewCell *cell = (CheckTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"CheckTableViewCell" owner:self options:nil];
        cell = self.checkCell;
        self.checkCell = nil;
    }
    
    if (cell == nil) {
        cell = [[CheckTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    cell.backgroundColor = [UIColor colorWithRed:24/255.0 green:86/255.0 blue:120/255.0 alpha:0.88];
    cell.foodPrice.text = [@"₪" stringByAppendingString:[((Order *)[self.orders objectAtIndex:[indexPath row]]).price stringValue]];
    cell.foodName.text = ((Order *)[self.orders
                                    objectAtIndex:[indexPath row]]).prod_name;
    cell.foodTarget.text = ((Order *)[self.orders
                                      objectAtIndex:[indexPath row]]).target_name;
    /*UIImage *foodPhoto = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:
     ((Order *)[self.orders objectAtIndex: [indexPath row]]).img_url]]];*/
    UIImage *foodPhoto = [UIImage imageNamed:@"loading.gif"];
    cell.foodImage.image = foodPhoto;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        UIImage *foodPhoto = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:((Order *)[self.orders objectAtIndex: [indexPath row]]).img_url]]];
        // Now the image will have been loaded and decoded and is ready to rock for the main thread
        dispatch_sync(dispatch_get_main_queue(), ^{
            [cell.foodImage setImage:foodPhoto];
        });
    });
    //cell.foodImage.image = foodPhoto;
    [cell setUserInteractionEnabled:NO];
    return cell;
}


@end
