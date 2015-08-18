//
//  MainViewController.m
//  DanRestaurantApp
//
//  Created by Dvir&Or on 6/29/15.
//  Copyright (c) 2015 Dvir&Or. All rights reserved.
//

#import "MainViewController.h"
#import "CarouselViewController.h"
#import "Employee+CoreData.h"
#import "Authorization+CoreData.h"
#import "HelpFunction.h"

@interface MainViewController ()

@property (strong, nonatomic) IBOutlet UIButton *pastaButton;
@property (strong, nonatomic) IBOutlet UIButton *sandwichButton;

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
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSString *currentDate = [formatter stringFromDate:[NSDate date]];
    self.dateLbl.text = currentDate;
    
    // Get employee information from local db
    self.employeeNameLbl.text = [Employee getSessionName];
    
    // Get the authorized targets from the server's database
    PopupNetworkManager *popupManager = [[PopupNetworkManager alloc] init];
    popupManager.delegate = self;
    [popupManager loadAuthorizations: [Employee getSessionId]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    [self.pastaButton setTitleColor:[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:0.9] forState:UIControlStateNormal];
    [self.sandwichButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self performSegueWithIdentifier: @"PastaSegue" sender: self];
}

#pragma mark - Actions
-(void)historyButtonAction:(id)sender {
    // When clicked history button
    [self performSegueWithIdentifier: @"historySegue" sender: self];
}

-(void)cartButtonAction:(id)sender {
    // When clicked cart button
    [self performSegueWithIdentifier: @"cartSegue" sender: self];
}

- (IBAction)logoutButtonAction:(id)sender {
    // Clean localDB
    [Employee deleteAllEmployees];
    [Authorization deleteAllAuth];
    // Go back to Login page
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)pressedPastaButton:(id)sender {
    // Set pasta button bolded (blue)
    [self.pastaButton setTitleColor:[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:0.9] forState:UIControlStateNormal];
    // Set pasta button unbolded (white)
    [self.sandwichButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    // Perform the segue (show the pastas in carousel)
    [self performSegueWithIdentifier: @"PastaSegue" sender: self];
}

- (IBAction)pressedSandwichButton:(id)sender {
    // Set sandwich button bolded (blue)
    [self.sandwichButton setTitleColor:[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:0.9] forState:UIControlStateNormal];
    // Set pasta button unbolded (white)
    [self.pastaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    // Perform the segue (show the sandwiches in carousel)
    [self performSegueWithIdentifier: @"SandwichSegue" sender: self];
}

#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PastaSegue"]) {
        CarouselViewController *carouselController = (CarouselViewController *) segue.destinationViewController;
        // Set the item option 1 - Pastas
        carouselController.customItemsOption = [NSNumber numberWithInt:1];
    } else if ([segue.identifier isEqualToString:@"SandwichSegue"]) {
        CarouselViewController *carouselController = (CarouselViewController *) segue.destinationViewController;
        // Set the item option 2 - Sandwiches
        carouselController.customItemsOption = [NSNumber numberWithInt:2];
    }
}

#pragma mark - PopupNetworkManagerDelegate
- (void) resultsFound:(NSArray *)json {
    // Save authorized targets info in local db
    [Authorization saveAuth: json];
}

- (void) errorFound:(NSError *) error{
    // Show error messege.
    [HelpFunction showAlert:@"שגיאה" andMessage:error.localizedDescription];
}

#pragma mark - alert view
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch(buttonIndex) {
        case 0: //"No" pressed - do nothing.
            break;
        case 1: //"Yes" pressed
            // Move to cart view (save the order there)
            [self performSegueWithIdentifier:@"checkViewSegue" sender: self];
            break;
    }
}


@end
