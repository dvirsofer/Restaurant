//
//  CarouselView.m
//  DanRestaurantApp
//
//  Created by DvirSofer on 7/18/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "CarouselView.h"

@implementation CarouselView

-(instancetype)initWithItem: (Item *) item {
    NSString *ImageURL = item.imageUrl;
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
    UIImage *image = [UIImage imageWithData:imageData];
    self = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setBackgroundImage:image forState:UIControlStateNormal];
    [self setBackgroundColor:[UIColor redColor]];
    [self setFrame:CGRectMake(0, 0, 200, 200)];
    
    self.imageView.contentMode = UIViewContentModeCenter;
    
    //Create Label
    UILabel *description = [[UILabel alloc]initWithFrame:CGRectMake(0, 160, 200, 100)];
    [description setFont:[UIFont fontWithName:@"Arial-BoldMT" size:13]];
    [description setText:item.itemDescription];
    description.font = [UIFont boldSystemFontOfSize:16];
    description.textAlignment = NSTextAlignmentCenter;
    [description setTextColor:[UIColor darkGrayColor]];
    [description setBackgroundColor:[UIColor clearColor]];
    [self addSubview:description];
    
    UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(0, 180, 200, 100)];
    [price setFont:[UIFont fontWithName:@"Arial-BoldMT" size:13]];
    [price setText: [[NSString stringWithFormat:@"%.2f", item.price] stringByAppendingString:@"  ש״ח"]];
    price.font = [UIFont boldSystemFontOfSize:16];
    price.textAlignment = NSTextAlignmentCenter;
    [price setTextColor:[UIColor darkGrayColor]];
    [price setBackgroundColor:[UIColor clearColor]];
    [self addSubview:price];
    
    UILabel *calories = [[UILabel alloc]initWithFrame:CGRectMake(0, 200, 200, 100)];
    [calories setFont:[UIFont fontWithName:@"Arial-BoldMT" size:13]];
    [calories setText:[[NSString stringWithFormat:@"%ld", (long)item.calories] stringByAppendingString:@"קלוריות"]];
    
    calories.font = [UIFont boldSystemFontOfSize:16];
    calories.textAlignment = NSTextAlignmentCenter;
    [calories setTextColor:[UIColor darkGrayColor]];
    [calories setBackgroundColor:[UIColor clearColor]];
    [self addSubview:calories];
    
    UILabel *quantity = [[UILabel alloc]initWithFrame:CGRectMake(0, 220, 200, 100)];
    [quantity setFont:[UIFont fontWithName:@"Arial-BoldMT" size:13]];
    [quantity setText: [[NSString stringWithFormat:@"%ld", (long)item.quantity] stringByAppendingString:@"במלאי"]];
    quantity.font = [UIFont boldSystemFontOfSize:16];
    quantity.textAlignment = NSTextAlignmentCenter;
    [quantity setTextColor:[UIColor darkGrayColor]];
    [quantity setBackgroundColor:[UIColor clearColor]];
    [self addSubview:quantity];

    return self;
}

@end
