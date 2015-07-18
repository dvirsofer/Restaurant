//
//  CartViewController.m
//  DanRestaurantApp
//
//  Created by Or on 6/28/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "CartViewController.h"

@interface CartViewController ()

@end

@implementation CartViewController

@synthesize cartCell = _cartCell;
@synthesize cartTableView = _cartTableView;

@synthesize foodImages = _foodImages;
@synthesize foodNames = _foodNames;
@synthesize foodPrices = _foodPrices;
@synthesize foodTargets = _foodTargets;

#pragma mark Properties
- (BOOL)isClicked
{
    return _clicked;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clicked = NO; // Not editable
    self.foodNames = [[NSMutableArray alloc]
                      initWithObjects:@"טונה",
                      @"גבינה",
                      @"בולונז",
                      @"טונה",
                      @"בולונז", nil];
    
    self.foodPrices = [[NSMutableArray alloc]
                       initWithObjects:@"1.50",
                       @"1.60",
                       @"10.80",
                       @"5.80",
                       @"9.60", nil];
    
    self.foodTargets = [[NSMutableArray alloc]
                        initWithObjects:@"עבורי",
                        @"עבורי",
                        @"משה",
                        @"משה",
                        @"איציק", nil];
    
    self.foodImages = [[NSMutableArray alloc]
                       initWithObjects:@"dan_logo_x1.png",
                       @"dan_logo_x1.png",
                       @"dan_logo_x1.png",
                       @"dan_logo_x1.png",
                       @"dan_logo_x1.png", nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.foodNames count];
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

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.foodNames removeObjectAtIndex:indexPath.row];
        [self.cartTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationAutomatic	];
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
