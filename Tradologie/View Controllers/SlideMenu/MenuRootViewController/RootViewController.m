//
//  RootViewController.m
//  CherryPop
//
//  Created by Shiv Kumar on 21/12/16.
//  Copyright © 2016 Shiv Kumar. All rights reserved.
//

#import "RootViewController.h"
#import "Constant.h"

@interface RootViewController ()

@end

@implementation RootViewController


- (void)awakeFromNib
{
    self.menuPreferredStatusBarStyle = UIStatusBarStyleDefault;
    self.contentViewShadowColor = [UIColor whiteColor];
    self.contentViewShadowOffset = CGSizeMake(0, 0);
    self.contentViewShadowOpacity = 1.0;
    self.contentViewShadowRadius = 0;
    self.contentViewShadowEnabled = YES;

    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentViewController"];
    self.leftMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
   
    self.delegate = self;
    [super awakeFromNib];
}

#pragma mark -
#pragma mark RESideMenu Delegate

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
    //STATUS_BAR_White(true);
    //NSLog(@"willShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
    //NSLog(@"didShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{
    //NSLog(@"willHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
    //NSLog(@"didHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
//    STATUS_BAR_Black(true);
}

@end
