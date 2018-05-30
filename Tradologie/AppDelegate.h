//
//  AppDelegate.h
//  Tradologie
//
//  Created by Chandresh Maurya on 04/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "RootViewController.h"

typedef NS_ENUM(NSUInteger, RootController) {
    kLoginVC,
    kMenuVC,
};
@interface AppDelegate : UIResponder <UIApplicationDelegate>
+(AppDelegate *)sharedAppDelegateClass;

@property (strong, nonatomic) UIWindow *window;
@property (assign, nonatomic) RootController rootController;
//@property (assign, nonatomic) BOOL shouldRotate;
@property (nonatomic, assign) UIInterfaceOrientationMask orientation;


- (void)setRootViewController:(UIViewController *)controller;





@end

