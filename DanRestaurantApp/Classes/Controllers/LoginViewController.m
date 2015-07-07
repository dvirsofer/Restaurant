//
//  LoginViewController.m
//  DanRestaurantApp
//
//  Created by Or on 6/27/15.
//  Copyright (c) 2015 Or. All rights reserved.
//  

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "MainViewController.h"

@interface LoginViewController ()

@property (strong, nonatomic) NSString *employeeInfo;

@end

@implementation LoginViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)Login:(id)sender {
    [self checkLogin:sender];
}

-(void) checkLogin:(id)sender {
    if([self.personal_number.text isEqualToString:@""] || [self.password.text isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:@"Error"
                            message:[NSString stringWithFormat:@"Enter all fields"]
                            delegate:nil
                            cancelButtonTitle:@"OK"
                            otherButtonTitles:nil] show];
        return;
    } else {
        
        
        // create string contains url address for php file, the file name is phpFile.php, it receives parameter :name
        NSString *strURL = [NSString stringWithFormat:@"http://dan-restaurant.net76.net/login.php/?employee_id=%@&personal_number=%@",self.personal_number.text, self.password.text];
        
        // to execute php code
        NSData *dataURL = [NSData dataWithContentsOfURL:[NSURL URLWithString:strURL]];
        
        // to receive the returend value
        NSString *strResult = [[NSString alloc] initWithData:dataURL encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@", strResult);
        
        self.employeeInfo = strResult ;
        
        if([strResult containsString:@"0 results"]) {
            // invalid information
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"alert" message:@"Invalide Information" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        } else {
            // Success login - move to MainViewController
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"mainViewController"];
            [self presentViewController:vc animated:YES completion:nil];
            
            [self performSegueWithIdentifier:@"mainView" sender:sender];
        }
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MainViewController *mainViewController = segue.destinationViewController;
    NSLog(@"Employee Name:%@", self.employeeInfo);
    NSLog(@"%@", mainViewController.employee_name);
    mainViewController.employee_name = self.employeeInfo;
    [segue.destinationViewController setEmployeeName:self.employeeInfo];
}


@end
