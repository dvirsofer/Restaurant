//
//  CustomPopUp.h
//  DanRestaurantApp
//
//  Created by DvirSofer on 7/8/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPopUp : UIViewController

@property (weak, nonatomic) IBOutlet UIView *popUpView;
@property (strong, nonatomic) IBOutlet UIButton *plus;
@property (strong, nonatomic) IBOutlet UIButton *minus;
@property (strong, nonatomic) IBOutlet UITextField *numOfItems;
@property (strong, nonatomic) IBOutlet UILabel *popupTitle;

- (IBAction)closePopup:(id)sender;
- (void)showInView:(UIView *)aView animated:(BOOL)animated;

@end
