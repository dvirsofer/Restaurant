//
//  CustomPopUp.h
//  DanRestaurantApp
//
//  Created by Dvir&Or on 7/8/15.
//  Copyright (c) 2015 Dvir & Or. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopUpViewDelegate.h"

@interface CustomPopUp : UIViewController

extern NSInteger const MAX_PER_EMPLOYEE; // Set the maximum of quantity per one item
@property (weak, nonatomic) IBOutlet UIView *popUpView;
@property (strong, nonatomic) IBOutlet UIButton *plus;
@property (strong, nonatomic) IBOutlet UIButton *minus;
@property (strong, nonatomic) IBOutlet UITextField *numOfItems;
@property (strong, nonatomic) IBOutlet UIPickerView *targetPicker;

@property (strong, nonatomic) NSNumber *productIndex;
@property (strong, nonatomic) NSArray *auths;

@property (weak, nonatomic) id<PopUpViewDelegate> delegate;

-(void)removeAnimate;
-(void)showInView:(UIView *)aView animated:(BOOL)animated withTargets:(NSMutableArray *)targets;

@end
