//
//  CheckTableViewController.m
//  DanRestaurantApp
//
//  Created by Or on 6/27/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "CheckTableViewController.h"

@interface CheckTableViewController ()

@end

@implementation CheckTableViewController

@synthesize foodImages = _foodImages;
@synthesize foodNames = _foodNames;
@synthesize foodPrices = _foodPrices;
@synthesize foodTargets = _foodTargets;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.foodNames = [[NSArray alloc]
                      initWithObjects:@"Tuna",
                      @"BMW",
                      @"Toyota",
                      @"Volvo",
                      @"Smart", nil];
    
    self.foodPrices = [[NSArray alloc]
                       initWithObjects:@"1.50",
                       @"1.60",
                       @"10.80",
                       @"5.80",
                       @"9.60", nil];
    
    self.foodTargets = [[NSArray alloc]
                        initWithObjects:@"Me",
                        @"Itzik",
                        @"Avi",
                        @"Me",
                        @"Avi", nil];
    
    self.foodImages = [[NSArray alloc]
                       initWithObjects:@"dan_logo_x1.png",
                       @"dan_logo_x1.png",
                       @"dan_logo_x1.png",
                       @"dan_logo_x1.png",
                       @"dan_logo_x1.png", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.foodNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"checkTableCell";
    
    CheckTableViewCell *cell = [tableView
                                dequeueReusableCellWithIdentifier:CellIdentifier];
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
}

@end
