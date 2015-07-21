//
//  CartTableViewCell.h
//  DanRestaurantApp
//
//  Created by Or on 6/28/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *foodImage;
@property (nonatomic, strong) IBOutlet UILabel *foodName;
@property (nonatomic, strong) IBOutlet UILabel *foodPrice;
@property (nonatomic, strong) IBOutlet UILabel *foodTarget;


@end
