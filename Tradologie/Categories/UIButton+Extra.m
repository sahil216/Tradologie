//
//  UIButton+Extra.m
//  OrderApp
//
//  Created by MMI IOS on 21/02/17.
//  Copyright © 2017 MMI IOS. All rights reserved.
//

#import "UIButton+Extra.h"

@implementation UIButton (Extra)
-(void)setDefaultButtonStyle
{
    [self.layer setCornerRadius:5.0f];
    self.layer.shadowColor = DefaultThemeColor.CGColor;
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowRadius = 1.0;
    self.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    [self setBackgroundColor:DefaultThemeColor];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.titleLabel setFont:IS_IPHONE5? UI_DEFAULT_FONT_MEDIUM(12):UI_DEFAULT_FONT_MEDIUM(16)];
    [self setTintColor:[UIColor clearColor]];
}
-(void)setDefaultButtonShadowStyle:(UIColor *)color//GET_COLOR_WITH_RGB(0, 145, 147, 1)
{
    [self.layer setCornerRadius:5.0f];
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowRadius = 1.0;
    self.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    [self setBackgroundColor:color];
    [self setShowsTouchWhenHighlighted: YES];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.titleLabel setFont:IS_IPHONE5? UI_DEFAULT_FONT_MEDIUM(12):UI_DEFAULT_FONT_MEDIUM(15)];
    [self setTintColor:[UIColor clearColor]];
}
-(void)setDefaultButtonStyleWithHighLightEffect{
    [self.layer setCornerRadius:5.0f];
    [self setShowsTouchWhenHighlighted: YES];
    [self.titleLabel setFont:IS_IPHONE5?UI_DEFAULT_FONT_MEDIUM(12): UI_DEFAULT_FONT_MEDIUM(15)];
}
@end
