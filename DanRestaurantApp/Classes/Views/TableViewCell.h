//
//  TableViewCell.h
//  DanRestaurantApp
//
//  Created by Dvir&Or on 8/17/15.
//  Copyright (c) 2015 Dvir&Or. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *foodImage;
@property (nonatomic, strong) IBOutlet UILabel *foodName;
@property (nonatomic, strong) IBOutlet UILabel *foodPrice;
@property (nonatomic, strong) IBOutlet UILabel *foodTarget;

+ (NSString *)reuseIdentifier;

@end
