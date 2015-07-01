//
//  MainViewController.m
//  DanRestaurantApp
//
//  Created by DvirSofer on 6/29/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "MainViewController.h"
#import "CarouselViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize placeholderView, currentViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *historyButton = [[UIBarButtonItem alloc] initWithTitle:@"היסטוריה" style:UIBarButtonItemStylePlain target:self action:@selector(historyButtonAction:)];
    UIBarButtonItem *cartButton = [[UIBarButtonItem alloc] initWithTitle:@"עגלה" style:UIBarButtonItemStylePlain target:self action:@selector(cartButtonAction:)];
    
    
    NSArray *navButtonArray = [[NSArray alloc] initWithObjects:historyButton, cartButton, nil];
    self.navigationItem.rightBarButtonItems = navButtonArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)exitButtonAction:(id)sender {
    // When clicked exit
    NSLog(@"Exit clicked");
}

-(void)historyButtonAction:(id)sender {
    // When clicked history
    NSLog(@"History clicked");
}

-(void)cartButtonAction:(id)sender {
    // When clicked cart
    NSLog(@"Cart clicked");
    //CartViewController *carViewController = [[CartViewController alloc] init];
    //[self.navigationController pushViewController:carViewController animated:YES];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"cartTableView"];
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)pastaButtonAction:(id)sender {
    // When clicked pasta
    NSLog(@"pasta clicked");
}

-(void)sandwichButtonAction:(id)sender {
    // When clicked sandwich
    NSLog(@"Sandwich clicked");
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue: %@", segue.identifier);
    
    if ([segue.identifier isEqualToString:@"PastaSegue"]) {
        [segue.destinationViewController setCustomImages:0];
    } else if ([segue.identifier isEqualToString:@"SandwichSegue"]) {
        [segue.destinationViewController setCustomImages:1];
    }
}

@end