//
//  UINavigationItem+Extra.m
//  Tradologie
//
//  Created by Chandresh Maurya on 09/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "UINavigationItem+Extra.h"
#import "Constant.h"


@implementation UINavigationItem (Extra)
-(void)setNavigationTittleWithLogo:(NSString *)strTittle
{
    UIImage *image = [UIImage imageNamed:@"Icon Logo"];
    UIView *vvBG= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 250, 60)];
    [vvBG setBackgroundColor:[UIColor clearColor]];
    UIImageView *imgLogo = [[UIImageView alloc]initWithFrame:CGRectMake(5, -2, 45, 45)];
    [imgLogo setImage:image];
    [vvBG addSubview:imgLogo];
    
    UILabel* titleNav = [[UILabel alloc]initWithFrame:CGRectMake((IS_IPHONE_6P)?imgLogo.frame.size.width+15:imgLogo.frame.size.width+10, -8,vvBG.frame.size.width, vvBG.frame.size.height)];
    [titleNav setText:strTittle];
    [titleNav setNumberOfLines:0];
    [titleNav setLineBreakMode:NSLineBreakByWordWrapping];
    [titleNav setTextColor:[UIColor orangeColor]];
    [titleNav setFont:([SDVersion deviceSize] > Screen4Dot7inch)?UI_DEFAULT_LOGO_FONT_MEDIUM(24):([SDVersion deviceSize] < Screen4Dot7inch)?UI_DEFAULT_LOGO_FONT_MEDIUM(20):UI_DEFAULT_LOGO_FONT_MEDIUM(22)];
    [vvBG addSubview:titleNav];
    [self setTitleView:vvBG];
}
-(void)SetBackButtonWithID:(id)targetID withSelectorAction:(SEL)sector
{
    UIButton *btnback = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btnback setImage:IMAGE(@"IconBack") forState:UIControlStateNormal];
    [btnback addTarget:targetID action:sector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnback];
    self.leftBarButtonItem = backBarButtonItem;
}
-(void)SetRightButtonWithID:(id)targetID withSelectorAction:(SEL)sector
{
    UIButton *btnback = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btnback setImage:IMAGE(@"IconAddNegotiation") forState:UIControlStateNormal];
    [btnback addTarget:targetID action:sector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnback];
    self.rightBarButtonItem = backBarButtonItem;
}
-(void)setNavigationTittleWithLogoforLanscapeMode:(NSString *)strTittle
{
    UIImage *image = [UIImage imageNamed:@"Icon Logo"];
    UIView *vvBG= [[UIView alloc]initWithFrame:CGRectMake(40, -30, SCREEN_WIDTH-80, 34)];
    [vvBG setBackgroundColor:[UIColor clearColor]];
    UIImageView *imgLogo = [[UIImageView alloc]initWithFrame:CGRectMake(5, -2, 34, 34)];
    [imgLogo setImage:image];
    [vvBG addSubview:imgLogo];
    
    UILabel* titleNav = [[UILabel alloc]initWithFrame:CGRectMake((IS_IPHONE_6P)?imgLogo.frame.size.width+15:imgLogo.frame.size.width+10, 0,vvBG.frame.size.width, vvBG.frame.size.height)];
    [titleNav setText:strTittle];
    [titleNav setNumberOfLines:0];
    [titleNav setLineBreakMode:NSLineBreakByWordWrapping];
    [titleNav setTextColor:[UIColor orangeColor]];
    [titleNav setFont:([SDVersion deviceSize] > Screen4Dot7inch)?UI_DEFAULT_LOGO_FONT_MEDIUM(24):([SDVersion deviceSize] < Screen4Dot7inch)?UI_DEFAULT_LOGO_FONT_MEDIUM(20):UI_DEFAULT_LOGO_FONT_MEDIUM(22)];
    [vvBG addSubview:titleNav];
    [self setTitleView:vvBG];
}
@end
