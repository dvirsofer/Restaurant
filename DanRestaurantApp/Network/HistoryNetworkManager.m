//
//  HistoryNetworkManager.m
//  DanRestaurantApp
//
//  Created by Dvir&Or on 8/13/15.
//  Copyright (c) 2015 Dvir&Or. All rights reserved.
//

#import "HistoryNetworkManager.h"
#import "AFHTTPRequestOperationManager.h"

@implementation HistoryNetworkManager

static NSString * const GET_HISTORY_URL = @"http://webmail.dan.co.il/restaurantservice/RestaurantService.svc/GetHistory";
static NSString * const GET_HISTORY_BY_DATE_URL = @"http://webmail.dan.co.il/restaurantservice/RestaurantService.svc/GetHistoryByDate";

-(void)getHistory:(NSNumber *)employeeId {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *employeeIdValue = [employeeId stringValue];
    NSDictionary *params = @ {@"id" : employeeIdValue};
    
    [manager POST:GET_HISTORY_URL parameters:params
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

-(void)getHistoryByDate:(NSString *)orderDate {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *params = @ {@"orderDate" : orderDate};
    
    [manager POST:GET_HISTORY_BY_DATE_URL parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *response = [operation responseString];
         NSData *objectData = [response dataUsingEncoding:NSUTF8StringEncoding];
         NSArray *json = [NSJSONSerialization JSONObjectWithData:objectData options:NSJSONReadingMutableContainers error:nil];
         if (self.delegate != nil && [self.delegate respondsToSelector:@selector(resultsFound:)]) {
             // Call resultsFound in delegate
             [self.delegate ordersFound:json];
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
