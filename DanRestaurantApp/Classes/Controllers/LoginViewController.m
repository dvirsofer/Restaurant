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

@interface LoginViewController ()

@property (strong, nonatomic) NSString *employeeInfo;

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
    if([personal_number.text isEqualToString:@""] || [password.text isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:@"Error"
                            message:[NSString stringWithFormat:@"Enter all fields"]
                            delegate:nil
                            cancelButtonTitle:@"OK"
                            otherButtonTitles:nil] show];
        return;
    }
    else {
        LoginNetworkManager *loginManager = [[LoginNetworkManager alloc] init];
        loginManager.delegate = self;
        [loginManager asyncLogin:personal_number.text withPass:password.text];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"mainView"])
    {
        if ([segue.destinationViewController isKindOfClass:[UINavigationController class]])
        {
            UINavigationController *navController = self.vc;
            MainViewController *vc1 = [navController.viewControllers objectAtIndex:0];
            [vc1 setEmployeeName: self.employeeInfo];
        }
    }
}

#pragma mark - LoginNetworkManagerDelegate

- (void) resultFound:(NSArray *)json {
    //save in local data and move to MainViewController.
    // Save emplyoee in local data
    [Employee saveEmployee:json];
    
    Employee *test = [Employee getEmployee];
    NSLog(@"Name: %@, Id: %@, PNum: %@", test.name, test.employee_id, test.personal_number);
    
    [self performSegueWithIdentifier:@"mainViewSegue" sender: self];
    
}

- (void) errorFound:(NSError *) error{
    //show error messege.
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"alert" message:@"Wrong ID or Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}


@end
