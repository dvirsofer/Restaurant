//
//  CustomPopUp.m
//  DanRestaurantApp
//
//  Created by DvirSofer on 7/8/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import "CustomPopUp.h"

@implementation CustomPopUp

NSInteger const maxPerItem = 2; // Set the maximum of quantity per one item

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Create the bounds and background view of the popup
    self.view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:.6];
    self.popUpView.layer.cornerRadius = 5;
    self.popUpView.layer.shadowOpacity = 0.8;
    self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}

/*!
 @brief Shows the popup.
 @discussion This method shows the popup on the view
 */
- (void)showAnimate
{
    self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.view.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.view.alpha = 1;
        self.view.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

/*!
 @brief Increase the quantity per item presented in the popup
 @discussion Updates the self.numOfItems text to the old quantity + 1.
 @param  Button press.
 */
- (IBAction)increasePressed:(id)sender
{
    if([self.numOfItems.text intValue] == maxPerItem)
        return;
    self.numOfItems.text = [NSString stringWithFormat:@"%d",([self.numOfItems.text intValue]+1)];
}

/*!
 @brief Decrease the quantity per item presented in the popup
 @discussion Updates the self.numOfItems text to the old quantity - 1.
 @param  Button press.
 */
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
