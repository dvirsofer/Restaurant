//
//  MainViewController.m
//  DanRestaurantApp
//
//  Created by DvirSofer on 6/29/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "MainViewController.h"
#import "CarouselViewController.h"
#import "Employee+CoreData.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Add bar buttons - History & Cart
    UIBarButtonItem *historyButton = [[UIBarButtonItem alloc] initWithTitle:@"היסטוריה" style:UIBarButtonItemStylePlain target:self action:@selector(historyButtonAction:)];
    UIBarButtonItem *cartButton = [[UIBarButtonItem alloc] initWithTitle:@"עגלה" style:UIBarButtonItemStylePlain target:self action:@selector(cartButtonAction:)];
    NSArray *navButtonArray = [[NSArray alloc] initWithObjects:historyButton, cartButton, nil];
    self.navigationItem.rightBarButtonItems = navButtonArray;

    // Set current date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"d/M/yyyy"];
    NSString *currentDate = [formatter stringFromDate:[NSDate date]];
    self.dateLbl.text = currentDate;
    
    // Get employee information from local db
    //self.employeeNameLbl.text = [Employee getEmployee].name;
    self.employeeNameLbl.text = [Employee getSessionName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    [self performSegueWithIdentifier: @"PastaSegue" sender: self];
}

-(void)exitButtonAction:(id)sender {
    // When clicked exit
    NSLog(@"Exit clicked");
    /*UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"loginViewController"];
    [self presentViewController:vc animated:YES completion:nil];*/
    //[self performSegueWithIdentifier: @"cartSegue" sender: self];
}

-(void)historyButtonAction:(id)sender {
    // When clicked history
    NSLog(@"History clicked");
}

-(void)cartButtonAction:(id)sender {
    // When clicked cart
    NSLog(@"Cart clicked");
    [self performSegueWithIdentifier: @"cartSegue" sender: self];
}


- (IBAction)pressedPastaButton:(id)sender {
    [self performSegueWithIdentifier: @"PastaSegue" sender: self];
}

- (IBAction)pressedSandwichButton:(id)sender {
    [self performSegueWithIdentifier: @"SandwichSegue" sender: self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue: %@", segue.identifier);
    CarouselViewController *carouselController = (CarouselViewController *) segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"PastaSegue"]) {
        carouselController.customItemsOption = [NSNumber numberWithInt:1];
    } else if ([segue.identifier isEqualToString:@"SandwichSegue"]) {
        carouselController.customItemsOption = [NSNumber numberWithInt:2];
    }
}

-(void) buttonIsPressed:(UIButton *)sender
{
    //get item index for button
    NSInteger index = [sender tag];
    self.popup = [[CustomPopUp alloc] initWithNibName:@"PopupView" bundle:nil];
    [self.popup showInView:self.view animated:YES];
    self.popup.popupTitle.text = [NSString stringWithFormat:@"Index: %li", (long)index];
}

- (IBAction)makeOrder:(id)sender {
    [self.popup closePopup:sender];
}

@end
