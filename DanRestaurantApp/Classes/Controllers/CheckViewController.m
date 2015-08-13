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
#import "Employee+CoreData.h"
#import "HelpFunction.h"

@interface CheckViewController ()

@property (strong, nonatomic) NSMutableArray *orders;
@property (strong, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet CheckTableViewCell *checkCell;
@property (weak, nonatomic) IBOutlet UITableView *checkTableView;
@property (strong, nonatomic) CheckViewNetworkManager *checkManager; // Network manager

@end

@implementation CheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Get the employee id
    NSNumber *employee_id = [Employee getSessionId];
    // Get order from local database
    self.orders = [Order loadOrders:employee_id];
    // Save order in server database
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
    //[self.navigationController.navigationController popViewControllerAnimated:YES]; // from Cart
    [self.navigationController popToRootViewControllerAnimated:YES]; // From
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

#pragma mark - CheckViewNetworkManagerDelegate
- (void) finishSaving {
    [HelpFunction showAlert:@"ההזמנה בוצעה" andMessage:@"הפריטים נשמרו בהצלחה"];
    // Delete all orders from localDB
    [Order deleteAllOrders:[Employee getSessionId]];
}
- (void) errorFound:(NSError *)error {
    [HelpFunction showAlert:@"שגיאה" andMessage:[error localizedDescription]];
}


@end
