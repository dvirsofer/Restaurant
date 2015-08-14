//
//  HistoryViewController.m
//  DanRestaurantApp
//
//  Created by Or on 8/9/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "HistoryViewController.h"
#import "Employee+CoreData.h"
#import "MBProgressHUD.h"
#import "HelpFunction.h"

@interface HistoryViewController ()

@property (strong, nonatomic) HistoryNetworkManager *historyManager; // Network manager
@property (strong, nonatomic) MBProgressHUD *hud;

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
    
    //setup spinner
    /*self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hud];
    self.hud.labelText = @"מתחבר אנא המתן";*/
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Refresh data
    [self.tableView reloadData];
    // Set exclusive sections
    [self.tableView setExclusiveSections:YES];
    [self.tableView openSection:0 animated:NO];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.headers count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    NSString* text = [[[self.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] valueForKey:@"description"];
    cell.textLabel.text = text;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.data objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
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
        UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        UILabel *dateText = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 20)];
        [dateText setTextColor:[UIColor blackColor]];
        [dateText setBackgroundColor:[UIColor clearColor]];
        [dateText setFont:[UIFont fontWithName: @"Trebuchet MS" size: 14.0f]];
        [dateText setText:[[json objectAtIndex:i] valueForKey:@"Key"]];
        [header addSubview:dateText];
        if(i % 2) {
            [header setBackgroundColor:[UIColor blueColor]];
        } else {
            [header setBackgroundColor:[UIColor grayColor]];
        }
        [self.headers addObject:header];
        //[self.headers addObject:[[json objectAtIndex:i] valueForKey:@"Key"]];
        int ordersSize = (int)[[[json objectAtIndex:i] valueForKey:@"Value"] count];
        //NSMutableArray *order = [[NSMutableArray alloc] initWithCapacity:ordersSize];
        for (int j = 0; j < ordersSize; j++)
        {
            NSMutableArray *order = [[NSMutableArray alloc] init];
            // set the order in index [i][j] in the returned json
            [order addObject:[[[json objectAtIndex:i] valueForKey:@"Value"] objectAtIndex:j]];
            [self.data addObject:order];
        }
    }
    [self.tableView reloadData];
    NSLog(@"HEADERS: %lu, DATA: %lu", (unsigned long)[self.headers count], (unsigned long)[[self.data objectAtIndex:1] count]);
    // Stop the loading indicator
    //[self.hud hide:YES];
}

- (void) errorFound:(NSError *) error{
    // Stop the loading indicator
    //[self.hud hide:YES];
    //show error messege.
    [HelpFunction showAlert:@"שגיאה" andMessage:error.localizedDescription];
}


@end
