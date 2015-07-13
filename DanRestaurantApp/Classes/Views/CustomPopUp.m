//
//  CustomPopUp.m
//  DanRestaurantApp
//
//  Created by DvirSofer on 7/8/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "CustomPopUp.h"

@implementation CustomPopUp

NSInteger const maxPerItem = 2;

- (void)viewDidLoad
{
    self.view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:.6];
    self.popUpView.layer.cornerRadius = 5;
    self.popUpView.layer.shadowOpacity = 0.8;
    self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)showAnimate
{
    self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.view.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.view.alpha = 1;
        self.view.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (IBAction)increasePressed:(id)sender
{
    if([self.numOfItems.text intValue] == maxPerItem)
        return;
    self.numOfItems.text = [NSString stringWithFormat:@"%d",([self.numOfItems.text intValue]+1)];
}

- (IBAction)decreasePressed:(id)sender
{
    if([self.numOfItems.text intValue] == 0)
        return;
    self.numOfItems.text = [NSString stringWithFormat:@"%d",([self.numOfItems.text intValue]-1)];
}

- (void)removeAnimate
{
    [UIView animateWithDuration:.25 animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.view removeFromSuperview];
        }
    }];
}

- (IBAction)closePopup:(id)sender {
    [self removeAnimate];
}

- (void)showInView:(UIView *)aView animated:(BOOL)animated
{
    [aView addSubview:self.view];
    if (animated) {
        [self showAnimate];
    }
}

@end
