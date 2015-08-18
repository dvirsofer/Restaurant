//
//  PopupNetworkManager.m
//  DanRestaurantApp
//
//  Created by Dvir&Or on 7/21/15.
//  Copyright (c) 2015 Dvir&Or. All rights reserved.
//

#import "PopupNetworkManager.h"
#import "AFHTTPRequestOperationManager.h"

@implementation PopupNetworkManager

static NSString * const GET_AUTH_URL = @"http://webmail.dan.co.il/restaurantservice/RestaurantService.svc/GetAuth";

- (void)loadAuthorizations:(NSNumber *)employee_id {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *params = @ {@"id" : employee_id};
    
    [manager POST:GET_AUTH_URL parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *response = [operation responseString];
         NSData *objectData = [response dataUsingEncoding:NSUTF8StringEncoding];
         NSArray *json = [NSJSONSerialization JSONObjectWithData:objectData options:NSJSONReadingMutableContainers error:nil];
         if (self.delegate != nil && [self.delegate respondsToSelector:@selector(resultsFound:)]) {
             // Call resultsFound in delegate
             [self.delegate resultsFound:json];
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
