//
//  CarouselView.m
//  DanRestaurantApp
//
//  Created by Dvir&Or on 7/18/15.
//  Copyright (c) 2015 Dvir&Or. All rights reserved.
//

#import "CarouselView.h"

@implementation CarouselView

-(instancetype)initWithItem: (Product *) product {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // iPad
        //Create the photo to display on carousel
        NSString *ImageURL = product.img_url;
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
        UIImage *image = [UIImage imageWithData:imageData];
        self = [UIButton buttonWithType:UIButtonTypeCustom];
        [self setBackgroundImage:image forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setFrame:CGRectMake(0, 0, 300, 300)];
        self.imageView.contentMode = UIViewContentModeCenter;
        
        //Create Description label
        UILabel *description = [[UILabel alloc]initWithFrame:CGRectMake(0, 260, 300, 150)];
        [description setFont:[UIFont fontWithName:@"Times New Roman" size:13]];
        [description setText:product.prod_desc];
        description.font = [UIFont boldSystemFontOfSize:16];
        [description setTextAlignment:NSTextAlignmentCenter];
        [description setTextColor:[UIColor colorWithRed:224/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
        [description setBackgroundColor:[UIColor clearColor]];
        [self addSubview:description];
        
        //Create Price label
        UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(0, 280, 300, 150)];
        [price setFont:[UIFont fontWithName:@"Times New Roman" size:13]];
        [price setText: [[NSString stringWithFormat:@"%.2f", [product.price floatValue]] stringByAppendingString:@" ש״ח"]];
        price.font = [UIFont boldSystemFontOfSize:16];
        [price setTextAlignment:NSTextAlignmentCenter];
        [price setTextColor:[UIColor colorWithRed:224/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
        [price setBackgroundColor:[UIColor clearColor]];
        [self addSubview:price];
        
        //Create Calories label
        UILabel *calories = [[UILabel alloc]initWithFrame:CGRectMake(0, 300, 300, 150)];
        [calories setFont:[UIFont fontWithName:@"Times New Roman" size:13]];
        [calories setText:[[NSString stringWithFormat:@"%@", product.calories] stringByAppendingString:@" קלוריות"]];
        calories.font = [UIFont boldSystemFontOfSize:16];
        [calories setTextAlignment:NSTextAlignmentCenter];
        [calories setTextColor:[UIColor colorWithRed:224/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
        [calories setBackgroundColor:[UIColor clearColor]];
        [self addSubview:calories];
        
        //Create Quantity label
        UILabel *quantity = [[UILabel alloc]initWithFrame:CGRectMake(0, 320, 300, 150)];
        [quantity setFont:[UIFont boldSystemFontOfSize:16]];
        [quantity setText: [[NSString stringWithFormat:@"%@", product.quantity] stringByAppendingString:@" במלאי"]];
        [quantity setTextAlignment:NSTextAlignmentCenter];
        [quantity setTextColor:[UIColor colorWithRed:224/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
        [quantity setBackgroundColor:[UIColor clearColor]];
        [self addSubview:quantity];
        
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
        return self;
    } else {
        if ([UIScreen mainScreen].bounds.size.width > 320) {
            if ([UIScreen mainScreen].scale == 3) {
                // iPhone6Plus - 5.5" - 414x736
                //Create the photo to display on carousel
                NSString *ImageURL = product.img_url;
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
                UIImage *image = [UIImage imageWithData:imageData];
                self = [UIButton buttonWithType:UIButtonTypeCustom];
                [self setBackgroundImage:image forState:UIControlStateNormal];
                [self setBackgroundColor:[UIColor clearColor]];
                [self setFrame:CGRectMake(0, 0, 300, 300)];
                self.imageView.contentMode = UIViewContentModeCenter;
                
                //Create Description label
                UILabel *description = [[UILabel alloc]initWithFrame:CGRectMake(0, 260, 300, 150)];
                [description setFont:[UIFont fontWithName:@"Times New Roman" size:13]];
                [description setText:product.prod_desc];
                description.font = [UIFont boldSystemFontOfSize:16];
                [description setTextAlignment:NSTextAlignmentCenter];
                [description setTextColor:[UIColor colorWithRed:224/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
                [description setBackgroundColor:[UIColor clearColor]];
                [self addSubview:description];
                
                //Create Price label
                UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(0, 280, 300, 150)];
                [price setFont:[UIFont fontWithName:@"Times New Roman" size:13]];
                [price setText: [[NSString stringWithFormat:@"%.2f", [product.price floatValue]] stringByAppendingString:@" ש״ח"]];
                price.font = [UIFont boldSystemFontOfSize:16];
                [price setTextAlignment:NSTextAlignmentCenter];
                [price setTextColor:[UIColor colorWithRed:224/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
                [price setBackgroundColor:[UIColor clearColor]];
                [self addSubview:price];
                
                //Create Calories label
                UILabel *calories = [[UILabel alloc]initWithFrame:CGRectMake(0, 300, 300, 150)];
                [calories setFont:[UIFont fontWithName:@"Times New Roman" size:13]];
                [calories setText:[[NSString stringWithFormat:@"%@", product.calories] stringByAppendingString:@" קלוריות"]];
                calories.font = [UIFont boldSystemFontOfSize:16];
                [calories setTextAlignment:NSTextAlignmentCenter];
                [calories setTextColor:[UIColor colorWithRed:224/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
                [calories setBackgroundColor:[UIColor clearColor]];
                [self addSubview:calories];
                
                //Create Quantity label
                UILabel *quantity = [[UILabel alloc]initWithFrame:CGRectMake(0, 320, 300, 150)];
                [quantity setFont:[UIFont boldSystemFontOfSize:16]];
                [quantity setText: [[NSString stringWithFormat:@"%@", product.quantity] stringByAppendingString:@" במלאי"]];
                [quantity setTextAlignment:NSTextAlignmentCenter];
                [quantity setTextColor:[UIColor colorWithRed:224/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
                [quantity setBackgroundColor:[UIColor clearColor]];
                [self addSubview:quantity];
                
                self.layer.cornerRadius = 5;
                self.layer.masksToBounds = YES;
                
                return self;
            } else {
                // iPhone6 - 4.7" - 375x667
                //Create the photo to display on carousel
                NSString *ImageURL = product.img_url;
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
                UIImage *image = [UIImage imageWithData:imageData];
                self = [UIButton buttonWithType:UIButtonTypeCustom];
                [self setBackgroundImage:image forState:UIControlStateNormal];
                [self setBackgroundColor:[UIColor clearColor]];
                [self setFrame:CGRectMake(0, 0, 300, 300)];
                self.imageView.contentMode = UIViewContentModeCenter;
                
                //Create Description label
                UILabel *description = [[UILabel alloc]initWithFrame:CGRectMake(0, 260, 300, 150)];
                [description setFont:[UIFont boldSystemFontOfSize:16]];
                [description setText:product.prod_desc];
                [description setTextAlignment:NSTextAlignmentCenter];
                [description setTextColor:[UIColor colorWithRed:224/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
                [description setBackgroundColor:[UIColor clearColor]];
                [self addSubview:description];
                
                //Create Price label
                UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(0, 280, 300, 150)];
                [price setFont:[UIFont boldSystemFontOfSize:16]];
                [price setText: [[NSString stringWithFormat:@"%.2f", [product.price floatValue]] stringByAppendingString:@" ש״ח"]];
                [price setTextAlignment:NSTextAlignmentCenter];
                [price setTextColor:[UIColor colorWithRed:224/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
                [price setBackgroundColor:[UIColor clearColor]];
                [self addSubview:price];
                
                //Create Calories label
                UILabel *calories = [[UILabel alloc]initWithFrame:CGRectMake(0, 300, 300, 150)];
                [calories setFont:[UIFont boldSystemFontOfSize:16]];
                [calories setText:[[NSString stringWithFormat:@"%@", product.calories] stringByAppendingString:@" קלוריות"]];
                [calories setTextAlignment:NSTextAlignmentCenter];
                [calories setTextColor:[UIColor colorWithRed:224/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
                [calories setBackgroundColor:[UIColor clearColor]];
                [self addSubview:calories];
                
                //Create Quantity label
                UILabel *quantity = [[UILabel alloc]initWithFrame:CGRectMake(0, 320, 300, 150)];
                [quantity setFont:[UIFont boldSystemFontOfSize:16]];
                [quantity setText: [[NSString stringWithFormat:@"%@", product.quantity] stringByAppendingString:@" במלאי"]];
                [quantity setTextAlignment:NSTextAlignmentCenter];
                [quantity setTextColor:[UIColor colorWithRed:224/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
                [quantity setBackgroundColor:[UIColor clearColor]];
                [self addSubview:quantity];
                
                self.layer.cornerRadius = 5;
                self.layer.masksToBounds = YES;
    
                return self;
            }
        } else {
            if([UIScreen mainScreen].bounds.size.height > 480) {
                // iPhone 5/5s - 4"
                //Create the photo to display on carousel
                NSString *ImageURL = product.img_url;
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
                UIImage *image = [UIImage imageWithData:imageData];
                self = [UIButton buttonWithType:UIButtonTypeCustom];
                [self setBackgroundImage:image forState:UIControlStateNormal];
                [self setBackgroundColor:[UIColor clearColor]];
                [self setFrame:CGRectMake(0, 0, 250, 250)];
                self.imageView.contentMode = UIViewContentModeCenter;
                
                //Create Description label
                UILabel *description = [[UILabel alloc]initWithFrame:CGRectMake(0, 195, 250, 125)];
                [description setFont:[UIFont boldSystemFontOfSize:18]];
                [description setText:product.prod_desc];
                [description setTextAlignment:NSTextAlignmentCenter];
                [description setTextColor:[UIColor colorWithRed:224/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
                [description setBackgroundColor:[UIColor clearColor]];
                [self addSubview:description];
                
                //Create Price label
                UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(0, 210, 250, 125)];
                [price setFont:[UIFont boldSystemFontOfSize:15]];
                [price setText: [[NSString stringWithFormat:@"%.2f", [product.price floatValue]] stringByAppendingString:@" ש״ח"]];
                [price setTextAlignment:NSTextAlignmentCenter];
                [price setTextColor:[UIColor colorWithRed:224/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
                [price setBackgroundColor:[UIColor clearColor]];
                [self addSubview:price];
                
                //Create Calories label
                UILabel *calories = [[UILabel alloc]initWithFrame:CGRectMake(0, 225, 250, 125)];
                [calories setFont:[UIFont boldSystemFontOfSize:15]];
                [calories setText:[[NSString stringWithFormat:@"%@", product.calories] stringByAppendingString:@" קלוריות"]];
                [calories setTextAlignment:NSTextAlignmentCenter];
                [calories setTextColor:[UIColor colorWithRed:224/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
                [calories setBackgroundColor:[UIColor clearColor]];
                [self addSubview:calories];
                
                //Create Quantity label
                UILabel *quantity = [[UILabel alloc]initWithFrame:CGRectMake(0, 240, 250, 125)];
                [quantity setFont:[UIFont boldSystemFontOfSize:15]];
                [quantity setText: [[NSString stringWithFormat:@"%@", product.quantity] stringByAppendingString:@" במלאי"]];
                [quantity setTextAlignment:NSTextAlignmentCenter];
                [quantity setTextColor:[UIColor colorWithRed:224/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
                [quantity setBackgroundColor:[UIColor clearColor]];
                [self addSubview:quantity];
                
                return self;
            } else {
                // iPhone 4s and earlier - 3.5"
                //Create the photo to display on carousel
                NSString *ImageURL = product.img_url;
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
                UIImage *image = [UIImage imageWithData:imageData];
                self = [UIButton buttonWithType:UIButtonTypeCustom];
                [self setBackgroundImage:image forState:UIControlStateNormal];
                [self setBackgroundColor:[UIColor clearColor]];
                [self setFrame:CGRectMake(0, 0, 180, 180)];
                self.imageView.contentMode = UIViewContentModeCenter;
                
                //Create Description label
                UILabel *description = [[UILabel alloc]initWithFrame:CGRectMake(0, 140, 180, 90)];
                [description setFont:[UIFont boldSystemFontOfSize:15]];
                [description setText:product.prod_desc];
                [description setTextAlignment:NSTextAlignmentCenter];
                [description setTextColor:[UIColor colorWithRed:224/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
                [description setBackgroundColor:[UIColor clearColor]];
                [self addSubview:description];
                
                //Create Price label
                UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(0, 155, 180, 90)];
                [price setFont:[UIFont boldSystemFontOfSize:12]];
                [price setText: [[NSString stringWithFormat:@"%.2f", [product.price floatValue]] stringByAppendingString:@" ש״ח"]];
                [price setTextAlignment:NSTextAlignmentCenter];
                [price setTextColor:[UIColor colorWithRed:224/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
                [price setBackgroundColor:[UIColor clearColor]];
                [self addSubview:price];
                
                //Create Calories label
                UILabel *calories = [[UILabel alloc]initWithFrame:CGRectMake(0, 165, 180, 90)];
                [calories setFont:[UIFont boldSystemFontOfSize:12]];
                [calories setText:[[NSString stringWithFormat:@"%@", product.calories] stringByAppendingString:@" קלוריות"]];
                calories.textAlignment = NSTextAlignmentCenter;
                [calories setTextColor:[UIColor colorWithRed:224/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
                [calories setBackgroundColor:[UIColor clearColor]];
                [self addSubview:calories];
                
                //Create Quantity label
                UILabel *quantity = [[UILabel alloc]initWithFrame:CGRectMake(0, 175, 180, 90)];
                [quantity setFont:[UIFont boldSystemFontOfSize:12]];
                [quantity setText: [[NSString stringWithFormat:@"%@", product.quantity] stringByAppendingString:@" במלאי"]];
                [quantity setTextAlignment:NSTextAlignmentCenter];
                [quantity setTextColor:[UIColor colorWithRed:224/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
                [quantity setBackgroundColor:[UIColor clearColor]];
                [self addSubview:quantity];
                
                return self;
            }
        }
    }
}

@end
