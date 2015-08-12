//
//  CheckViewNetworkManager.m
//  DanRestaurantApp
//
//  Created by Or on 8/10/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "CheckViewNetworkManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "Order.h"

@implementation CheckViewNetworkManager

static NSString * const GET_AUTH_URL = @"http://webmail.dan.co.il/restaurantservice/RestaurantService.svc/SaveOrders";

- (void)saveOrders:(NSMutableArray *)orders {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSMutableArray *params = [[NSMutableArray alloc] init];
    for (Order *orderObj in orders) {
        NSDictionary *order = @ {@"employee_id" : orderObj.employee_id,
                                 @"item_id" : orderObj.prod_id,
                                 @"price" : orderObj.price,
                                 @"target_id" : orderObj.target_id
        };
        [params addObject:order];
    }
    [manager POST:GET_AUTH_URL parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (self.delegate != nil && [self.delegate respondsToSelector:@selector(finishSaving)]) {
             // Call resultsFound in delegate
             [self.delegate finishSaving];
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
