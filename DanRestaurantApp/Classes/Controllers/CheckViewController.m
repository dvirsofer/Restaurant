//
//  CheckViewController.m
//  DanRestaurantApp
//
//  Created by Dvir&Or on 6/27/15.
//  Copyright (c) 2015 Dvir&Or. All rights reserved.
//

#import "CheckViewController.h"
#import "TableViewCell.h"
#import "Order+CoreData.h"
#import "Employee+CoreData.h"
#import "HelpFunction.h"
#import "MBProgressHUD.h"

@interface CheckViewController ()

@property (strong, nonatomic) NSMutableArray *orders;
@property (strong, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet TableViewCell *checkCell;
@property (weak, nonatomic) IBOutlet UITableView *checkTableView;
@property (strong, nonatomic) CheckViewNetworkManager *checkManager; // Network manager
@property (strong, nonatomic) MBProgressHUD *hud; // Loading Spinner

@end

@implementation CheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Get the employee id
    NSNumber *employee_id = [Employee getSessionId];
    // Get order from local database
    self.orders = [Order loadOrders:employee_id];
    // Check if there are orders to save
    if([self.orders count] == 0) {
        // No orders - Go back to main screen
        [HelpFunction showAlert:@"ההזמנה בוטלה" andMessage:@"אין מוצרים בעגלה"];
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    
    //setup spinner
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hud];
    // Set the hud to display with a color
    self.hud.color = [UIColor colorWithRed:0.23 green:0.50 blue:0.82 alpha:0.90];
    // Set the hud text
    self.hud.labelText = @"אנא המתן";
    // Start spinner
    [self.hud show:YES];

    
    // Save order in server's database
    self.checkManager = [[CheckViewNetworkManager alloc] init];
    self.checkManager.delegate = self;
    [self.checkManager saveOrders: self.orders];
    
    // Set the price label
    self.priceLbl.text = [@"₪" stringByAppendingString:[[Order getTotalPrice:employee_id] stringValue]];
    // Refresh the table
    [self.checkTableView reloadData];
    // Disable back button
    self.navigationItem.hidesBackButton = YES;
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        UIImage *foodPhoto = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:((Order *)[self.orders objectAtIndex: [indexPath row]]).img_url]]];
        // Now the image will have been loaded and decoded and is ready to rock for the main thread
        dispatch_sync(dispatch_get_main_queue(), ^{
            [cell.foodImage setImage:foodPhoto];
        });
    });
    [cell setUserInteractionEnabled:NO];
    return cell;
}

#pragma mark - CheckViewNetworkManagerDelegate
- (void) finishSaving {
    // Stop spinner
    [self.hud hide:YES];
    
    [HelpFunction showAlert:@"ההזמנה בוצעה" andMessage:@"Bon Appetit!בתאבון"];
    // Delete all orders from localDB
    [Order deleteAllOrders:[Employee getSessionId]];
}
- (void) errorFound:(NSError *)error {
    [HelpFunction showAlert:@"שגיאה" andMessage:[error localizedDescription]];
}


@end
