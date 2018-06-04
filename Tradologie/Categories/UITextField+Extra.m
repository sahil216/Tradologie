//
//  UITextField+Extra.m
//  OrderApp
//
//  Created by MMI IOS on 24/02/17.
//  Copyright © 2017 MMI IOS. All rights reserved.
//

#import "UITextField+Extra.h"

@implementation UITextField (Extra)
-(void)setDefaultPreferenceTextfieldStyle:(UIImage *)image WithPlaceHolder:(NSString *)placeholder withTag:(NSInteger)tag
{
    [self setPlaceholder:placeholder];
    [self setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self setFont:UI_DEFAULT_FONT(15)];
    [self setTag:tag];
    [self setTintColor:[UIColor colorWithRed:29.0f/255.0f green:65.0f/255.0f blue:160.0f/255.0f alpha:1.0f]];
    [self.layer setBorderWidth:1.0f];
    [self.layer setCornerRadius:5.0f];
    [self setBackgroundColor:[UIColor whiteColor]];
    [self.layer setBorderColor:[UIColor colorWithRed:29.0f/255.0f green:65.0f/255.0f blue:160.0f/255.0f alpha:1.0f].CGColor];
    [self setKeyboardAppearance:UIKeyboardAppearanceDark];
   
    UIView *userView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    UIImageView *imgPreference =[[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 25, 25)];
    [imgPreference setImage:image];
    [userView addSubview:imgPreference];
    self.leftView = userView;
    self.leftViewMode = UITextFieldViewModeAlways;

}

-(void)setTextfieldStyleWithButton:(UIImage *)image WithPlaceHolder:(NSString *)placeholder withID:(id)targetID withbuttonImage:(UIImage *)btnImage withSelectorAction:(SEL)sector
{
    [self setPlaceholder:placeholder];
    [self setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self setFont:UI_DEFAULT_FONT(15)];
    [self setSecureTextEntry:YES];

    [self setTintColor:[UIColor colorWithRed:29.0f/255.0f green:65.0f/255.0f blue:160.0f/255.0f alpha:1.0f]];
    [self.layer setBorderWidth:1.0f];
    [self.layer setCornerRadius:5.0f];
    [self setBackgroundColor:[UIColor whiteColor]];
    [self.layer setBorderColor:[UIColor colorWithRed:29.0f/255.0f green:65.0f/255.0f blue:160.0f/255.0f alpha:1.0f].CGColor];
    [self setKeyboardAppearance:UIKeyboardAppearanceDark];
    
    UIView *userView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    UIImageView *imgPreference =[[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 25, 25)];
    [imgPreference setImage:image];
    [userView addSubview:imgPreference];
    self.leftView = userView;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *rightView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIButton *btnRight =[[UIButton alloc]initWithFrame:CGRectMake(0, 5, 30, 30)];
    [btnRight setImage:btnImage forState:UIControlStateNormal];
    [btnRight setBackgroundColor:[UIColor clearColor]];
    [btnRight setSelected:NO];
    [btnRight addTarget:targetID action:sector forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:btnRight];
    [self setRightView:rightView];
    [self setRightViewMode:UITextFieldViewModeAlways];
}

-(void)setDefaultTextfieldStyleWithPlaceHolder:(NSString *)placeholder withTag:(NSInteger)tag
{
    [self setPlaceholder:placeholder];
    [self setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self setFont:UI_DEFAULT_FONT(15)];
    [self setTag:tag];
    [self setTintColor:[UIColor colorWithRed:29.0f/255.0f green:65.0f/255.0f blue:160.0f/255.0f alpha:1.0f]];
    [self.layer setBorderWidth:1.0f];
    [self.layer setCornerRadius:5.0f];
    [self.layer setBorderColor:[UIColor colorWithRed:29.0f/255.0f green:65.0f/255.0f blue:160.0f/255.0f alpha:1.0f].CGColor];
    [self setKeyboardAppearance:UIKeyboardAppearanceDark];
    [self setBackgroundColor:[UIColor whiteColor]];
    UIView *userView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 45)];
    self.leftView = userView;
    self.leftViewMode = UITextFieldViewModeAlways;
    
}
-(void)setAdditionalInformationTextfieldStyle:(NSString *)placeholder Withimage:(UIImage *)image withID:(id)targetID withSelectorAction:(SEL)sector withTag:(NSInteger)tag
{
    [self setPlaceholder:placeholder];
    [self setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self setFont:UI_DEFAULT_FONT(15)];
    [self setTintColor:[UIColor colorWithRed:29.0f/255.0f green:65.0f/255.0f blue:160.0f/255.0f alpha:1.0f]];
    [self.layer setBorderWidth:1.0f];
    [self.layer setCornerRadius:5.0f];
    [self setTag:tag];
    [self.layer setBorderColor:[UIColor colorWithRed:29.0f/255.0f green:65.0f/255.0f blue:160.0f/255.0f alpha:1.0f].CGColor];
    [self setKeyboardAppearance:UIKeyboardAppearanceDark];
    [self setBackgroundColor:[UIColor whiteColor]];

    UIView *userView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 45)];
    self.leftView = userView;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *rightView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    UIButton *btnRight =[[UIButton alloc]initWithFrame:CGRectMake(10, 10, 15, 20)];
    [btnRight setImage:image forState:UIControlStateNormal];
    [btnRight setBackgroundColor:[UIColor clearColor]];
    [btnRight setSelected:NO];
    [btnRight setTag:tag];
    [btnRight addTarget:targetID action:sector forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:btnRight];
    [self setRightView:rightView];
    [self setRightViewMode:UITextFieldViewModeAlways];//
}
-(void)setRightViewTextfieldStyle:(NSString *)placeholder Withimage:(NSString *)imageName withTag:(NSInteger)tag
{
    [self setPlaceholder:placeholder];
    [self setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self setFont:UI_DEFAULT_FONT(15)];
    [self setTintColor:[UIColor colorWithRed:29.0f/255.0f green:65.0f/255.0f blue:160.0f/255.0f alpha:1.0f]];
    [self.layer setBorderWidth:1.0f];
    [self.layer setCornerRadius:5.0f];
    [self.layer setBorderColor:[UIColor colorWithRed:29.0f/255.0f green:65.0f/255.0f blue:160.0f/255.0f alpha:1.0f].CGColor];
    [self setKeyboardAppearance:UIKeyboardAppearanceDark];
    [self setBackgroundColor:[UIColor whiteColor]];
    
    UIView *userView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 45)];
    self.leftView = userView;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *viewRight=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [viewRight setClipsToBounds:YES];
    UIImageView *rightView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 15, 20)];
    [rightView setImage:IMAGE(imageName)];
    [viewRight addSubview:rightView];
    [self setRightView:viewRight];
    [self setRightViewMode:UITextFieldViewModeAlways];
}
-(void)setRightViewTextfieldStyleWithCalender:(NSString *)placeholder Withimage:(NSString *)imageName withTag:(NSInteger)tag
{
    [self setPlaceholder:placeholder];
    [self setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self setFont:UI_DEFAULT_FONT(15)];
    [self setTintColor:[UIColor colorWithRed:29.0f/255.0f green:65.0f/255.0f blue:160.0f/255.0f alpha:1.0f]];
    [self.layer setBorderWidth:1.0f];
    [self.layer setCornerRadius:5.0f];
    [self.layer setBorderColor:[UIColor colorWithRed:29.0f/255.0f green:65.0f/255.0f blue:160.0f/255.0f alpha:1.0f].CGColor];
    [self setKeyboardAppearance:UIKeyboardAppearanceDark];
    [self setBackgroundColor:[UIColor whiteColor]];
    
    UIView *userView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 45)];
    self.leftView = userView;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *viewRight=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [viewRight setClipsToBounds:YES];
    UIImageView *rightView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
    [rightView setImage:IMAGE(imageName)];
    [viewRight addSubview:rightView];
    [self setRightView:viewRight];
    [self setRightViewMode:UITextFieldViewModeAlways];
}
@end
