//
//  CartTableViewCell.m
//  DanRestaurantApp
//
//  Created by Or on 6/28/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "CartTableViewCell.h"

@implementation CartTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+ (NSString *)reuseIdentifier {
    return @"cartTableCell";
}


@end
