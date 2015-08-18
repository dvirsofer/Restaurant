//
//  TableViewCell.m
//  DanRestaurantApp
//
//  Created by Dvir&Or on 8/17/15.
//  Copyright (c) 2015 Dvir&Or. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

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
    return @"tableCell";
}


@end
