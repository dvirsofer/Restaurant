//
//  CarouselView.h
//  DanRestaurantApp
//
//  Created by Dvir&Or on 7/18/15.
//  Copyright (c) 2015 Dvir&Or. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface CarouselView : UIButton

-(instancetype)initWithItem: (Product *) product;

@end
