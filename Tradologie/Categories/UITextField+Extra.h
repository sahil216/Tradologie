//
//  UITextField+Extra.h
//  OrderApp
//
//  Created by MMI IOS on 24/02/17.
//  Copyright © 2017 MMI IOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface UITextField (Extra)
-(void)setDefaultPreferenceTextfieldStyle:(UIImage *)image WithPlaceHolder:(NSString *)placeholder
                                  withTag:(NSInteger)tag;
-(void)setTextfieldStyleWithButton:(UIImage *)image WithPlaceHolder:(NSString *)placeholder withID:(id)targetID withbuttonImage:(UIImage *)btnImage withSelectorAction:(SEL)sector;

-(void)setDefaultTextfieldStyleWithPlaceHolder:(NSString *)placeholder withTag:(NSInteger)tag;

-(void)setAdditionalInformationTextfieldStyle:(NSString *)placeholder Withimage:(UIImage *)image withID:(id)targetID withSelectorAction:(SEL)sector withTag:(NSInteger)tag;

-(void)setRightViewTextfieldStyle:(NSString *)placeholder Withimage:(NSString *)imageName withTag:(NSInteger)tag;

@end
