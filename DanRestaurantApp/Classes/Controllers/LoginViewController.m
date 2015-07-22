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
#import "Authorization+CoreData.h"

@interface LoginViewController ()

//@property (strong, nonatomic) NSString *employeeInfo;

@end

@implementation LoginViewController
@synthesize personal_number, password;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)Login:(id)sender {
    [self checkLogin:sender];
}

- (void) checkLogin:(id)sender {
    // Basic check if any of the text fields is empty
    if([personal_number.text isEqualToString:@""] || [password.text isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:@"Error"
                            message:[NSString stringWithFormat:@"Enter all fields"]
                            delegate:nil
                            cancelButtonTitle:@"OK"
                            otherButtonTitles:nil] show];
        return;
    }
    else {
        // Check login in server - call resultsFound if success or errorFound if not
        LoginNetworkManager *loginManager = [[LoginNetworkManager alloc] init];
        loginManager.delegate = self;
        [loginManager asyncLogin:personal_number.text withPass:password.text];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue: %@", segue.identifier);
    //MainViewController *carouselController = (CarouselViewController *) segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"mainViewSegue"]) {
        
    }
}

#pragma mark - LoginNetworkManagerDelegate

- (void) resultFound:(NSArray *)json {
    //save in local data and move to MainViewController.
    // Save emplyoee in local data
    [Employee saveEmployee:json];
    // Move to main view
    [self performSegueWithIdentifier:@"mainViewSegue" sender: self];
}

- (void) errorFound:(NSError *) error{
    //show error messege.
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Information" message:@"Wrong ID or Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}


@end
