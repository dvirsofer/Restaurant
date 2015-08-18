//
//  CustomPopUp.m
//  DanRestaurantApp
//
//  Created by Dvir&Or on 7/8/15.
//  Copyright (c) 2015 Dvir&Or. All rights reserved.
//

#import "CustomPopUp.h"

@implementation CustomPopUp

NSInteger const MAX_PER_EMPLOYEE = 2;

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
    if([self.numOfItems.text intValue] == MAX_PER_EMPLOYEE)
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

/*!
 @brief Remove the popup.
 @discussion Remove from the view.
 */
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

/*!
 @brief Show the popup in view
 @discussion if animated is on - show with animate
 @param  Popup's view and Animated-Y/N.
 */
- (void)showInView:(UIView *)aView animated:(BOOL)animated
{
    [aView addSubview:self.view];
    if (animated) {
        [self showAnimate];
    }
}

#pragma mark - UIPickerViewDataSource
// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

/*!
 @brief set the height of each object in the picker view
 */
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30.0f;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.delegate getCount];
}

// The data to return for the row and component (column)
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.delegate getAuthName:row];
}

#pragma mark - buttons methods
/*!
 @brief Close the popup
 @discussion Close the popup
 @param  Button press.
 */
- (IBAction)closePopup:(id)sender {
    //[self.delegate removeTargets];
    [self removeAnimate];
}

/*!
 @brief "Add To Cart" button pressed
 @discussion Make delegate to insert the item to cart
 @param  "Add To Cart" Button press.
 */
- (IBAction)addToCart:(id)sender {
    [self.delegate addToCart:self];
}

/*!
 @brief "Finish Order" button pressed
 @discussion Make delegate to finish the order
 @param  "Finish Order" Button press.
 */
- (IBAction)endOrder:(id)sender {
    [self.delegate endOrder:self];
}

@end
