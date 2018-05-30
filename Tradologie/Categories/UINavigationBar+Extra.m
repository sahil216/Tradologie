//
//  UINavigationBar+Extra.m
//  OrderApp
//
//  Created by MMI IOS on 21/02/17.
//  Copyright © 2017 MMI IOS. All rights reserved.
//

#import "UINavigationBar+Extra.h"

@implementation UINavigationBar (Extra)
-(void)setNaviagtionStyleWithStatusbar:(UIColor *)colorbar
{
//    [self setBackgroundImage:[UIImage new]forBarMetrics:UIBarMetricsDefault];
//    self.shadowImage = [UIImage new];
    self.translucent = false;
    UIColor *color = [UIColor whiteColor];
    self.backgroundColor = [color colorWithAlphaComponent:1.0f];
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)])
    {
        statusBar.backgroundColor =colorbar;
    }
    [self setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                    NSFontAttributeName:UI_DEFAULT_FONT_BOLD(20)}];
    

}
-(void)SetBackButtonWithID:(id)targetID withSelectorAction:(SEL)sector{
    
}
@end
