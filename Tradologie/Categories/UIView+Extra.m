//
//  UIView+Extra.m
//  OrderApp
//
//  Created by MMI IOS on 16/02/17.
//  Copyright © 2017 MMI IOS. All rights reserved.
//

#import "UIView+Extra.h"

@implementation UIView (Extra)
-(void)SetDefaultTextfieldBackGroundView
{
    [self.layer setBorderWidth:1.0f];
    [self.layer setCornerRadius:5.0f];
    [self.layer setBorderColor:[UIColor colorWithRed:156.0f/255.0f green:156.0f/255.0f blue:156.0f/255.0f alpha:1.0f].CGColor];
    self.layer.shadowColor =GET_COLOR_WITH_RGB(120, 51, 16, 1).CGColor;
    self.layer.shadowOpacity = .80;
    self.layer.shadowRadius = 1.0;
    self.layer.shadowOffset = CGSizeMake(4.0f, 4.0f);
    [self.layer setBorderWidth:2.0f];
}

-(void)SetDefaultBackGroundView
{
    [self.layer setCornerRadius:5.0f];
    [self.layer setBorderColor:[UIColor colorWithRed:156.0f/255.0f green:156.0f/255.0f blue:156.0f/255.0f alpha:1.0f].CGColor];
    self.layer.shadowColor =[UIColor grayColor].CGColor;
    self.layer.shadowOpacity = .60;
    self.layer.shadowRadius = 1.0;
    self.layer.shadowOffset = CGSizeMake(2.50f, 2.50f);
    [self.layer setBorderWidth:1.0f];
}
-(void)SetDefaultShadowBackGround
{
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.masksToBounds = NO;
    [self.layer setCornerRadius:5.0f];
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.layer.shadowOpacity = 1.5f;
    self.layer.shadowPath = shadowPath.CGPath;
}

@end
