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
@property (strong, nonatomic) MBProgressHUD *hud;

@end

@implementation LoginViewController
@synthesize personal_number, password;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginManager = [[LoginNetworkManager alloc] init];
    self.loginManager.delegate = self;
    
    //setup spinner
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hud];
    self.hud.labelText = @"מתחבר אנא המתן";
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
        [[[HelpFunction alloc] init] showAlert:@"הכנס את כל השדות"];
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
    [[[HelpFunction alloc] init] showAlert:@"מספר אישי או תעודת זהות שגויים"];
}


@end
