//
//  LoginViewController.m
//  DanRestaurantApp
//
//  Created by Or on 6/27/15.
//  Copyright (c) 2015 Or. All rights reserved.
//  

#import "LoginViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "Employee+CoreData.h"
#import "MBProgressHUD.h"
#import "HelpFunction.h"
#import "Product+CoreData.h"

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UITextField *personal_number; // Personal number text field
@property (strong, nonatomic) IBOutlet UITextField *password; // Employee id text field
@property (strong, nonatomic) LoginNetworkManager *loginManager; // Network manager
@property (strong, nonatomic) MBProgressHUD *hud; // Loading Spinner

@end

@implementation LoginViewController
@synthesize personal_number, password;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Clean localDB
    [Employee deleteAllEmployees];
    
    // setup the network manager
    self.loginManager = [[LoginNetworkManager alloc] init];
    self.loginManager.delegate = self;
    
    //setup spinner
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hud];
    
    // Set the hud to display with a color
    self.hud.color = [UIColor colorWithRed:0.23 green:0.50 blue:0.82 alpha:0.90];
    self.hud.labelText = @"מתחבר אנא המתן";
}

- (void)viewWillAppear:(BOOL)animated {
    // Clear text views
    self.personal_number.text = @"";
    self.password.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)Login:(id)sender {
    [self checkLogin:sender];
}

- (void)checkLogin:(id)sender {
    // Basic check if any of the text fields is empty
    if([personal_number.text isEqualToString:@""] || [password.text isEqualToString:@""]) {
        [HelpFunction showAlert:@"שגיאה" andMessage:@"הכנס את כל השדות"];
        return;
    }
    else {
        // Start the loading indicator
        [self.hud show:YES];
        
        // Check login in server - call resultsFound if success or errorFound if not
        [self.loginManager asyncLogin:personal_number.text withPass:password.text];
    }
}

#pragma mark - LoginNetworkManagerDelegate
- (void) resultFound:(NSArray *)json {
    //save in local data and move to MainViewController.
    // Save emplyoee in local data
    [Employee saveEmployee:json];
    // Stop the loading indicator
    [self.hud hide:YES];
    // Move to main view
    [self performSegueWithIdentifier:@"mainViewSegue" sender: self];
}

- (void) errorFound:(NSError *) error{
    // Stop the loading indicator
    [self.hud hide:YES];
    //show error messege.
    [HelpFunction showAlert:@"שגיאה" andMessage:@"מספר אישי או תעודת זהות שגויים"];
}


@end
