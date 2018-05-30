//
//  CommonUtility.h
//  SetlrApp
//
//  Created by Chandresh on 8/9/16.
//  Copyright © 2016 Chandresh. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "Constant.h"
#import <UIKit/UIKit.h>

@interface CommonUtility : NSObject
{
    
}
//-(void)ErrorWithString:(NSString*)strError WithID:(id)TargetId;
-(void)show_ErrorAlertWithTitle:(NSString*)title withMessage:(NSString*)message;
-(void)show_SuccessAlertWithTitle:(NSString*)title withMessage:(NSString*)message;

+(NSMutableArray *) removeDuplicateFromList:(NSArray *)  groups withKey: (NSString *)key;
+(NSInteger)getCurrentYear;
+(void) setMaxAndMinDateForAppInPickerView : (UIDatePicker *)datePicker;
+(UIImage *) changeImage : (UIImage *)image color:(UIColor *)color;
+(void)showProgressWithMessage:(NSString *)message;
+(void)HideProgress;
+(void)setTooBarOnTextfield:(UITextField *)txtField withTargetId:(id)targetID withActionEvent:(SEL)ActionEvent;
+(void)ShowAlertwithTittle:(NSString *)strMessage withID:(id)Controller;
@end
