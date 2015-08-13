//
//  HistoryViewController.m
//  DanRestaurantApp
//
//  Created by Or on 8/9/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "HistoryViewController.h"

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
    NSArray* dates = @[@"10/08/2015",
                       @"11/08/2015",
                       @"12/08/2015",
                       @"13/08/2015",
                       @"14/08/2015",
                       @"15/08/2015"];
    
    self.data = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < [dates count] ; i++)
    {
        NSMutableArray* section = [[NSMutableArray alloc] init];
        for (int j = 0 ; j < 3 ; j++)
        {
            [section addObject:[NSString stringWithFormat:@"Cell n°%i", j]];
        }
        [self.data addObject:section];
    }
    
    self.headers = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < [dates count] ; i++)
    {
        UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        
        UILabel *yourLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 20)];
        [yourLabel setTextColor:[UIColor blackColor]];
        [yourLabel setBackgroundColor:[UIColor clearColor]];
        [yourLabel setFont:[UIFont fontWithName: @"Trebuchet MS" size: 14.0f]];
        [yourLabel setText:[dates objectAtIndex:i]];
        [header addSubview:yourLabel];
        if(i % 2) {
            [header setBackgroundColor:[UIColor blueColor]];
        } else {
            [header setBackgroundColor:[UIColor grayColor]];
        }
        
        [self.headers addObject:header];
    }
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
    return [self.data count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    NSString* text = [[self.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = text;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.data objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self.headers objectAtIndex:section];
}


@end
