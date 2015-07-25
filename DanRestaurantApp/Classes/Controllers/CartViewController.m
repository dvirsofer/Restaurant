//
//  CartViewController.m
//  DanRestaurantApp
//
//  Created by Or on 6/28/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "CartViewController.h"
#import "Order+CoreData.h"

@interface CartViewController ()

@property (strong, nonatomic) NSMutableArray *orders;
@end

@implementation CartViewController

#pragma mark Properties
- (BOOL)isClicked
{
    return _clicked;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clicked = NO; // Not editable
    self.orders = [Order loadOrders];
    [self.cartTableView reloadData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.orders count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"cartTableCell";
    
    CartTableViewCell *cell = (CartTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"CartTableViewCell" owner:self options:nil];
        cell = _cartCell;
        _cartCell = nil;
    }
    
    if (cell == nil) {
        cell = [[CartTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    cell.foodPrice.text = [((Order *)[self.orders
                           objectAtIndex: [indexPath row]]).price stringValue];
    cell.foodName.text = ((Order *)[self.orders
                          objectAtIndex:[indexPath row]]).prod_name;
    cell.foodTarget.text = ((Order *)[self.orders
                            objectAtIndex:[indexPath row]]).target_name;
    UIImage *foodPhoto = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:
                          ((Order *)[self.orders objectAtIndex: [indexPath row]]).img_url]]];
    cell.foodImage.image = foodPhoto;
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
#warning add delete order
        [self.orders removeObjectAtIndex:indexPath.row];
        [self.cartTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    //**************************** TODO ****************************//
    // Remove from database + update the Sum here //
    
    [self.cartTableView endUpdates];
}

-(IBAction)editButtonClicked:(id)sender
{
    if(self.clicked == NO)
    {
        [self.cartTableView setEditing:YES animated:YES];
        self.clicked = YES;
    }
    else
    {
        [self.cartTableView setEditing:NO animated:YES];
        self.clicked = NO;
    }
    
}

-(IBAction)returnButtonClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
