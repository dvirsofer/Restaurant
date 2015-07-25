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
#import "MBProgressHUD.h"

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UITextField *personal_number;
@property (strong, nonatomic) IBOutlet UITextField *password;

@property (strong, nonatomic) LoginNetworkManager *loginManager;
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
    self.hud.labelText = @"אנא המתן מתחבר...";
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
        [[[UIAlertView alloc] initWithTitle:@"שגיאה"
                                    message:[NSString stringWithFormat:@"הכנס את כל השדות"]
                                   delegate:nil
                          cancelButtonTitle:@"אישור"
                          otherButtonTitles:nil] show];
        return;
    }
    else {
        // Start the loading indicator
        [self.hud show:YES];
        
        // Check login in server - call resultsFound if success or errorFound if not
        [self.loginManager asyncLogin:personal_number.text withPass:password.text];
    }
}

#warning Remove this!!!
/*-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue: %@", segue.identifier);
    //MainViewController *carouselController = (CarouselViewController *) segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"mainViewSegue"]) {
        
    }
}*/

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
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"שגיאה" message:@"מספר אישי או תעודת זהות שגויים" delegate:self cancelButtonTitle:@"אישור" otherButtonTitles:nil, nil];
    [alert show];
}


@end
