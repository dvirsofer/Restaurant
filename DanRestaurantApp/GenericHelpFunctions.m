//
//  GenericHelpFunctions.m
//  DanRestaurantApp
//
//  Created by Or on 7/16/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "GenericHelpFunctions.h"

@implementation GenericHelpFunctions

/*!
 @discussion Get the employee info from server.
 @param 2 Strings - Personal number and password
 @return Employee with details inside if success validation or nil if not.
 */
-(Employee*)GetUserInfo:(NSString *)personal_number andPassword:(NSString *)password
{
    NSString *url = @"http://webmail.dan.co.il/restaurantservice/RestaurantService.svc/Login";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *params = @ {@"personal_number" : personal_number, @"id" : password};
    
    Employee *employee;
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
         // Success login - move to MainViewController
         // Remove the " " before and after the name
         response = [response substringFromIndex:1];
         response = [response substringToIndex:[response length] - 1];
         
         //employee = [[Employee alloc] initWithEmployeeId:response[@"id"] andPersonalNumber:response[@"personal_number"] andEmployeeName:response[@"name"]];
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
     }];
    
    return employee;
}

@end
