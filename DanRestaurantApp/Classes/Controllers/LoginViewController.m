//
//  LoginViewController.m
//  DanRestaurantApp
//
//  Created by Or on 6/27/15.
//  Copyright (c) 2015 Or. All rights reserved.
//  

#import "LoginViewController.h"
#import "AFHTTPRequestOperationManager.h"

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

-(void) checkLogin:(id)sender {
    if([personal_number.text isEqualToString:@""] || [password.text isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:@"Error"
                            message:[NSString stringWithFormat:@"Enter all fields"]
                            delegate:nil
                            cancelButtonTitle:@"OK"
                            otherButtonTitles:nil] show];
        return;
    } else {
        
        NSString *url = @"http://webmail.dan.co.il/restaurantservice/RestaurantService.svc/Login";
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSDictionary *params = @ {@"personal_number" : personal_number.text, @"id" : password.text};
        
        
        [manager POST:url parameters:params
              success:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            if([response isEqualToString:@"\"Wrong\""])
            {
                // Invalid Information (Wrong id/pass)
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"alert" message:@"Invalid Information" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
            // Success login - move to MainViewController //
            
            self.employeeInfo = response;
            
            // Remove the " " before and after the name
            self.employeeInfo = [self.employeeInfo substringFromIndex:1];
            self.employeeInfo = [self.employeeInfo substringToIndex:[self.employeeInfo length] - 1];
            
            NSLog(@"EmployeeInfo= %@", self.employeeInfo);
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            self.vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"mainViewController"];
            [self presentViewController:self.vc animated:YES completion:nil];
            
            [self performSegueWithIdentifier:@"mainView" sender:sender];
        }
              failure:
         ^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
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


@end
