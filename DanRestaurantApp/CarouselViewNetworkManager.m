//
//  CarouselViewNetworkManager.m
//  DanRestaurantApp
//
//  Created by Or on 7/16/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "CarouselViewNetworkManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "Item.h"

@implementation CarouselViewNetworkManager

static NSString * const GET_ITEMS_URL = @"http://webmail.dan.co.il/restaurantservice/RestaurantService.svc/GetItems";

-(void) getAllParams:(NSNumber *)option
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *params = @ {@"type" : option};
    
    [manager POST:GET_ITEMS_URL parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *response = [operation responseString];
         NSData *objectData = [response dataUsingEncoding:NSUTF8StringEncoding];
         NSArray *json = [NSJSONSerialization JSONObjectWithData:objectData options:NSJSONReadingMutableContainers error:nil];
         if (self.delegate != nil && [self.delegate respondsToSelector:@selector(resultsFound:)]) {
             // Call resultFound in delegate
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
