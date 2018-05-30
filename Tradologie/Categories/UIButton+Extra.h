//
//  UIButton+Extra.h
//  OrderApp
//
//  Created by MMI IOS on 21/02/17.
//  Copyright © 2017 MMI IOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CTStringAttributes.h>
#import "Constant.h"

@interface UIButton (Extra)
-(void)setDefaultButtonStyle;
-(void)setDefaultButtonShadowStyle:(UIColor *)color;
-(void)setDefaultButtonStyleWithHighLightEffect;
@end
