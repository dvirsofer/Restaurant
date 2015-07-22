//
//  CustomPopUp.h
//  DanRestaurantApp
//
//  Created by DvirSofer on 7/8/15.
//  Copyright (c) 2015 Or. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopUpViewDelegate.h"

/*@protocol PopUpViewDelegate <NSObject>
@required
- (void) addToCart:(CustomPopUp *) popup;
- (void) errorFound:(NSError *)error;
@end*/


@interface CustomPopUp : UIViewController

@property (weak, nonatomic) IBOutlet UIView *popUpView;
@property (strong, nonatomic) IBOutlet UIButton *plus;
@property (strong, nonatomic) IBOutlet UIButton *minus;
@property (strong, nonatomic) IBOutlet UITextField *numOfItems;
@property (strong, nonatomic) IBOutlet UIPickerView *targetPicker;
@property (strong, nonatomic) NSNumber *productIndex;

@property (strong, nonatomic) NSArray *auths;

@property (weak, nonatomic) id<PopUpViewDelegate> delegate;

- (void)showInView:(UIView *)aView animated:(BOOL)animated withTargets:(NSMutableArray *)targets;

@end
