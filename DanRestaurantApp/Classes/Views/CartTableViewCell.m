//
//  CartTableViewCell.m
//  DanRestaurantApp
//
//  Created by Or on 6/28/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "CartTableViewCell.h"

@implementation CartTableViewCell

@synthesize foodImage = _foodImage;
@synthesize foodName = _foodName;
@synthesize foodPrice = _foodPrice;
@synthesize foodTarget = _foodTarget;
@synthesize deleteItemButton = _deleteItemButton;

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
    
    // Configure the view for the selected state
}

+ (NSString *)reuseIdentifier {
    return @"cartTableCell";
}


@end
