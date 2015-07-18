//
//  LoginNetworkManager.m
//  DanRestaurantApp
//
//  Created by Or on 7/18/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "LoginNetworkManager.h"
#import "AFHTTPRequestOperationManager.h"

static NSString * const LOGIN_URL = @"http://webmail.dan.co.il/restaurantservice/RestaurantService.svc/Login";

@implementation LoginNetworkManager

-(void) asyncLogin:(NSString *)employee_id withPass:(NSString *)personal_number
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *params = @ {@"personal_number" : personal_number, @"id" : employee_id};
    
    [manager POST:LOGIN_URL parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *response = [operation responseString];
         
         NSData *objectData = [response dataUsingEncoding:NSUTF8StringEncoding];
         
         NSArray *json = [NSJSONSerialization JSONObjectWithData:objectData options:NSJSONReadingMutableContainers error:nil];
         
         if([json count] == 0)
         {
             // Invalid Information (Wrong id/pass)
             if (self.delegate != nil && [self.delegate respondsToSelector:@selector(errorFound)]) {
                 [self.delegate errorFound];
             }
         }
         // Success login - create new employee and send it to delegate
         
         // Get the employee name
         NSString *new_name = json[0][@"employee_name"];
         // Remove the " " before and after the name
         new_name = [new_name substringFromIndex:1];
         new_name = [new_name substringToIndex:[new_name length] - 1];
         
         // Formatter in order to get number from string
         NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
         format.numberStyle = NSNumberFormatterDecimalStyle;
         
         // Get the employee id and personal number
         NSNumber *new_employee_id = [format numberFromString:json[0][@"employee_id"]];
         NSNumber *new_personal_number = [format numberFromString:json[0][@"personal_number"]];
         
         // Create new employee
         Employee *employee = [[Employee alloc] init];
         employee.name = new_name;
         employee.employee_id = new_employee_id;
         employee.personal_number = new_personal_number;

         // Send the new employee to delegate
         if (self.delegate != nil && [self.delegate respondsToSelector:@selector(resultFound:)]) {
             [self.delegate resultFound:employee];
         }
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         if (self.delegate != nil && [self.delegate respondsToSelector:@selector(errorFound)]) {
             [self.delegate errorFound];
         }
     }];
}

@end
