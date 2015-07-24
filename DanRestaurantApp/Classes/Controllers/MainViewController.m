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
#import "Authorization+CoreData.h"
#import "MBProgressHUD.h"

@interface MainViewController ()

@property (strong, nonatomic) IBOutlet UIButton *pastaButton;
@property (strong, nonatomic) IBOutlet UIButton *sandwichButton;
@property (strong, nonatomic) MBProgressHUD *hud;


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
    [self performSegueWithIdentifier: @"PastaSegue" sender: self];
}

#pragma mark - Actions
-(void)historyButtonAction:(id)sender {
    // When clicked history
    NSLog(@"History clicked");
}

-(void)cartButtonAction:(id)sender {
    // When clicked cart
    NSLog(@"Cart clicked");
    [self performSegueWithIdentifier: @"cartSegue" sender: self];
}

- (IBAction)logoutButtonAction:(id)sender {
    // Delete all coredata
    
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)pressedPastaButton:(id)sender {
    [self.pastaButton setTitleColor:[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:0.9] forState:UIControlStateNormal];
    [self.sandwichButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self performSegueWithIdentifier: @"PastaSegue" sender: self];
}

- (IBAction)pressedSandwichButton:(id)sender {
    [self.sandwichButton setTitleColor:[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:0.9] forState:UIControlStateNormal];
    [self.pastaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self performSegueWithIdentifier: @"SandwichSegue" sender: self];
}

#pragma mark - Navigation
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

/*-(void) buttonIsPressed:(UIButton *)sender
{
    //get item index for button
    //NSInteger index = [sender tag];
    self.popup = [[CustomPopUp alloc] initWithNibName:@"PopupView" bundle:nil];
    [self.popup showInView:self.view animated:YES];
}*/

/*- (IBAction)makeOrder:(id)sender {
    [self.popup closePopup:sender];
}*/

#pragma mark - PopupNetworkManagerDelegate
- (void) resultsFound:(NSArray *)json {
#warning// TODO: Remove it !!!!!!!!!!!!!!!!!!!!
    [Authorization deleteAllAuth];
    // Save authorized targets info in local db
    [Authorization saveAuth: json];
}

- (void) errorFound:(NSError *) error{
    // Show error messege.
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"alert" message:@"Wrong ID or Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

@end
