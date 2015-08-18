//
//  CartViewController.m
//  DanRestaurantApp
//
//  Created by Dvir&Or on 6/28/15.
//  Copyright (c) 2015 Dvir&Or. All rights reserved.
//

#import "CartViewController.h"
#import "TableViewCell.h"
#import "Order+CoreData.h"
#import "Employee+CoreData.h"

@interface CartViewController ()

@property (strong, nonatomic) NSMutableArray *orders;
@property (assign, nonatomic, getter=isClicked) BOOL clicked;
@property (strong, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet TableViewCell *cartCell;
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
    // Not editable table
    self.clicked = NO;
    // Get the employee id
    NSNumber *employee_id = [Employee getSessionId];
    // Get all orders from localDB
    self.orders = [Order loadOrders: employee_id];
    // Set the total price
    self.priceLbl.text = [@"₪" stringByAppendingString:[[Order getTotalPrice:employee_id] stringValue]];
    // Refresh the table
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
    // Get the identifier of the cell
    NSString *cellIdentifier = [TableViewCell reuseIdentifier];
    TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell
    cell.backgroundColor = [UIColor colorWithRed:24/255.0 green:86/255.0 blue:120/255.0 alpha:0.88];
    cell.foodPrice.text = [@"₪" stringByAppendingString:[((Order *)[self.orders objectAtIndex:[indexPath row]]).price stringValue]];
    cell.foodName.text = ((Order *)[self.orders
                          objectAtIndex:[indexPath row]]).prod_name;
    cell.foodTarget.text = ((Order *)[self.orders
                            objectAtIndex:[indexPath row]]).target_name;
    UIImage *foodPhoto = [UIImage imageNamed:@"loading.gif"];
    cell.foodImage.image = foodPhoto;
    // Load the images in async task
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        UIImage *foodPhoto = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:((Order *)[self.orders objectAtIndex: [indexPath row]]).img_url]]];
        // Now the image will have been loaded and decoded and is ready to rock for the main thread
        dispatch_sync(dispatch_get_main_queue(), ^{
            [cell.foodImage setImage:foodPhoto];
        });
    });
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Get the order in the selected index - that we want to delete
        Order *orderToDelete = [self.orders objectAtIndex:indexPath.row];
        // Get the employee id
        NSNumber *employee_id = [Employee getSessionId];
        // Remove order from local db
        [Order removeOrder: orderToDelete];
        // Remove order from orders array - orders which displayed in cart
        self.orders = [Order loadOrders:employee_id];
        // Remove order from the cart table view
        [self.cartTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];
        // Update the new sum after deletion
        // Make fade animation on update price
        [UIView animateWithDuration:0.4 animations:^{
            self.priceLbl.alpha = 0;
        } completion:^(BOOL finished) {
            self.priceLbl.text = [@"₪" stringByAppendingString:[[Order getTotalPrice:employee_id] stringValue]];
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
    if([self.priceLbl.text isEqualToString:@"₪0"])
    {
        // No items
        [[[UIAlertView alloc] initWithTitle:@"שגיאה"
                                    message:@"יש להוסיף מוצרים לעגלה"
                                   delegate:nil
                          cancelButtonTitle:@"אישור"
                          otherButtonTitles:nil] show];
        return;
    }
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
            // Move to check view
            [self performSegueWithIdentifier:@"checkSegue" sender: self];
            break;
    }
}


@end
