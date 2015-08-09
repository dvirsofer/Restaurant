//
//  CartViewController.m
//  DanRestaurantApp
//
//  Created by Or on 6/28/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "CartViewController.h"
#import "CartTableViewCell.h"
#import "Order+CoreData.h"

@interface CartViewController ()

@property (strong, nonatomic) NSMutableArray *orders;
@property (assign, nonatomic, getter=isClicked) BOOL clicked;
@property (strong, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet CartTableViewCell *cartCell;
@property (weak, nonatomic) IBOutlet UITableView *cartTableView;

-(IBAction)editButtonClicked:(id)sender;

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
    self.priceLbl.text = [@"₪" stringByAppendingString:[[Order getTotalPrice] stringValue]];
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
        cell = self.cartCell;
        self.cartCell = nil;
    }
    
    if (cell == nil) {
        cell = [[CartTableViewCell alloc]
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
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        Order *orderToDelete = [self.orders objectAtIndex:indexPath.row];
        // Check if it's low price item
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *order_date = [formatter stringFromDate:orderToDelete.order_date];
        NSArray *arrayOfOrders = [Order loadOrdersByTarget:orderToDelete.target_id andDate:order_date];
        if([arrayOfOrders objectAtIndex:0] == orderToDelete && [arrayOfOrders count] > 1) {
            [Order updateOrderPrice:[arrayOfOrders objectAtIndex:1]];
        }
        // Remove order from local db
        [Order removeOrder: orderToDelete];
        // Remove order from orders array - orders which displayed in cart
        self.orders = [Order loadOrders];
        //[self.orders removeObjectAtIndex:indexPath.row];
        // Remove order from the cart table view
        [self.cartTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];
        // Update the new sum after deletion
        // Make fade animation on update price
        [UIView animateWithDuration:0.4 animations:^{
            self.priceLbl.alpha = 0;
        } completion:^(BOOL finished) {
            self.priceLbl.text = [@"₪" stringByAppendingString:[[Order getTotalPrice] stringValue]];
            [UIView animateWithDuration:0.4 animations:^{
                self.priceLbl.alpha = 1;
            }];
        }];
        [self.cartTableView reloadData];
    }
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

- (IBAction)finishOrder:(id)sender {
    // Show "are you sure?" alert
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"הזמן"
                                                    message:@"האם אתה בטוח שברצונך לסיים את ההזמנה?"
                                                   delegate:self
                                          cancelButtonTitle:@"לא"
                                          otherButtonTitles:@"כן", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch(buttonIndex) {
        case 0: //"No" pressed
            break;
        case 1: //"Yes" pressed
            // Save in database
            
            // Move to check view
            [self performSegueWithIdentifier:@"checkSegue" sender: self];
            break;
    }
}


@end
