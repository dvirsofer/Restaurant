//
//  LoginNetworkManager.m
//  DanRestaurantApp
//
//  Created by Dvir&Or on 7/18/15.
//  Copyright (c) 2015 Dvir&Or. All rights reserved.
//

#import "LoginNetworkManager.h"
#import "AFHTTPRequestOperationManager.h"

static NSString * const LOGIN_URL = @"http://webmail.dan.co.il/restaurantservice/RestaurantService.svc/Login";

@implementation LoginNetworkManager

/*!
 @discussion Get the employee info from server call resultFound if success and errorFound if not.
 @param 2 Strings - Personal number and password
 */
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
         
         if([json count] == 0 || json == nil)
         {
             // Invalid Information (Wrong id/pass)
             if (self.delegate != nil && [self.delegate respondsToSelector:@selector(errorFound:)]) {
                 NSError *error;
                 // dictionary for error details
                 NSMutableDictionary* errorDetails = [NSMutableDictionary dictionary];
                 [errorDetails setValue:@"Wrong" forKey:NSLocalizedDescriptionKey];
                 // create the error
                 error = [NSError errorWithDomain:@"login" code:200 userInfo:errorDetails];
                 [self.delegate errorFound: error];
                 return;
             }
         }
         // Success login - create new employee and send it to delegate
         // Send the new employee to delegate
         if (self.delegate != nil && [self.delegate respondsToSelector:@selector(resultFound:)]) {
             // Call resultFound in delegate
             [self.delegate resultFound:json];
         }
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         if (self.delegate != nil && [self.delegate respondsToSelector:@selector(errorFound:)]) {
             [self.delegate errorFound: error];
         }
     }];
}

@end
