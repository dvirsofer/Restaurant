//
//  HistoryViewController.m
//  DanRestaurantApp
//
//  Created by Dvir&Or on 8/9/15.
//  Copyright (c) 2015 Dvir&Or. All rights reserved.
//

#import "HistoryViewController.h"
#import "Employee+CoreData.h"
#import "MBProgressHUD.h"
#import "HelpFunction.h"
#import "TableViewCell.h"
#import "Order+CoreData.h"

@interface HistoryViewController ()

@property (nonatomic, strong) NSMutableArray* data;
@property (nonatomic, strong) NSMutableArray* headers;

@property (strong, nonatomic) HistoryNetworkManager *historyManager; // Network manager
@property (strong, nonatomic) MBProgressHUD *hud;
@property (strong, nonatomic) IBOutlet UILabel *totalPrice;
@property NSString *selectedDate;

@end

@implementation HistoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self setupViewController];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setupViewController];
    }
    return self;
}

- (void)setupViewController
{
    // setup the network manager
    self.historyManager = [[HistoryNetworkManager alloc] init];
    self.historyManager.delegate = self;
    // get the session id
    NSNumber *employeeId = [Employee getSessionId];
    // get the history data
    [self.historyManager getHistory:employeeId];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do not display empty cells
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // Set table background color
    [self.tableView setBackgroundColor:[UIColor colorWithRed:17/255.0 green:59/255.0 blue:87/255.0 alpha:0.8]];
    // Refresh data
    [self.tableView reloadData];
    // Set exclusive sections
    [self.tableView setExclusiveSections:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // return the number of sections (dates)
    return [self.headers count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [TableViewCell reuseIdentifier];
    
    TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    // Get all the data to show
    NSArray* description = [[[self.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] valueForKey:@"description"];
    NSArray* imgUrl = [[[self.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] valueForKey:@"imgUrl"];
    NSArray* price = [[[self.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] valueForKey:@"price"];
    NSArray* targetName = [[[self.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] valueForKey:@"targetName"];

    // Configure the cell
    cell.backgroundColor = [UIColor colorWithRed:24/255.0 green:86/255.0 blue:120/255.0 alpha:0.88];
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    [fmt setPositiveFormat:@"0.##"];
    cell.foodPrice.text = [@"₪" stringByAppendingString:[fmt stringFromNumber:[price objectAtIndex:0]]];
    cell.foodName.text = [description objectAtIndex:0];
    cell.foodTarget.text = [targetName objectAtIndex:0];
    UIImage *foodPhoto = [UIImage imageNamed:@"loading.gif"];
    cell.foodImage.image = foodPhoto;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        UIImage *foodPhoto = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[imgUrl objectAtIndex:0]]]];
        // Now the image will have been loaded and decoded and is ready to rock for the main thread
        dispatch_sync(dispatch_get_main_queue(), ^{
            [cell.foodImage setImage:foodPhoto];
        });
    });
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Get the selectedDate
    self.selectedDate = ((UILabel *)[((UIView *)[self.headers objectAtIndex:section]).subviews objectAtIndex:0]).text;
    // Update the price after clicked a section
    float price = 0;
    int rows = (int)[[self.data objectAtIndex:section] count];
    for(int i=0; i<rows; i++)
    {
        price += [[[[[self.data objectAtIndex:section] objectAtIndex:i] valueForKey:@"price"] objectAtIndex:0] floatValue];
    }
    // Make fade animation on update price
    [UIView animateWithDuration:0.4 animations:^{
        self.totalPrice.alpha = 0;
    } completion:^(BOOL finished) {
        self.totalPrice.text = [@"₪" stringByAppendingString:[NSString stringWithFormat:@"%.2f", price]];
        [UIView animateWithDuration:0.4 animations:^{
            self.totalPrice.alpha = 1;
        }];
    }];
    return rows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self.headers objectAtIndex:section];
}

#pragma mark - HistoryNetworkManagerDelegate
- (void) resultsFound:(NSArray *)json {
    self.headers = [[NSMutableArray alloc] init];
    self.data = [[NSMutableArray alloc] init];
    int datesSize = (int)[json count];
    for (int i = 0; i < datesSize; i++)
    {
        // set the date header in index [i]
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 40)];
        UILabel *dateText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 40)];
        [dateText setTextColor:[UIColor blackColor]];
        [dateText setBackgroundColor:[UIColor clearColor]];
        [dateText setFont:[UIFont fontWithName: @"Trebuchet MS" size: 17.0f]];
        [dateText setText:[[json objectAtIndex:i] valueForKey:@"Key"]];
        [dateText setTextAlignment:NSTextAlignmentCenter];
        [dateText setCenter:header.center];
        [header addSubview:dateText];
        if(i % 2) {
            [header setBackgroundColor:[UIColor colorWithRed:255/255.0 green:215/255.0 blue:0/255.0 alpha:1]];
        } else {
            [header setBackgroundColor:[UIColor colorWithRed:238/255.0 green:221/255.0 blue:130/255.0 alpha:1]];
        }
        [self.headers addObject:header];
        int ordersSize = (int)[[[json objectAtIndex:i] valueForKey:@"Value"] count];
        NSMutableArray *ordersArray = [[NSMutableArray alloc] initWithCapacity:ordersSize];
        for (int j = 0; j < ordersSize; j++)
        {
            NSMutableArray *order = [[NSMutableArray alloc] init];
            // set the order in index [i][j] in the returned json
            [order addObject:[[[json objectAtIndex:i] valueForKey:@"Value"] objectAtIndex:j]];
            [ordersArray addObject:order];
        }
        [self.data addObject:ordersArray];
    }
    // Refresh table
    [self.tableView reloadData];
}

- (void) ordersFound:(NSArray *)json {
    // Save order in localDB
    [Order saveOrder:json];
    // Move to check view controller
    [self performSegueWithIdentifier:@"checkSegue" sender: self];
}

- (void) errorFound:(NSError *) error {
    //show error messege.
    [HelpFunction showAlert:@"שגיאה" andMessage:error.localizedDescription];
}

#pragma mark - Buttons Actions
- (IBAction)makeOrder:(id)sender {
    if([self.totalPrice.text isEqualToString:@"₪0"])
    {
        // No items
        [[[UIAlertView alloc] initWithTitle:@"שגיאה"
                                    message:@"בחר בתאריך להזמנה"
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
            // Get orders json from server by the selected date
            [self.historyManager getHistoryByDate:self.selectedDate];
            break;
    }
}



@end
