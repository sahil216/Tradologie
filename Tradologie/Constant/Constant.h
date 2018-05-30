//
//  Constant.h
//  GonzApp
//
//  Created by Chandresh on 8/2/16.
//  Copyright © 2016 Chandresh. All rights reserved.
//

//=====================================================All Controllers=====================================================//
//#import "Alert.h"
#import "UIButton+Extra.h"
#import "FRHyperLabel.h"
#import "SDVersion.h"
#import "AppDelegate.h"
#import "FTPopOverMenu.h"
#import "NSString+MB.h"

//#import "Reachability.h"
//#import "CommonUtility.h"
//#import "CMTextField.h"
#import "UIView+Extra.h"
//#import "Validation.h"
//#import "NSUserDefaults+Extra.h"
#import "UINavigationBar+Extra.h"
#import "UINavigationItem+Extra.h"

//#import "NSDictionary+CheckNullValue.h"
//#import "viewPopUp.h"
#import "Validation.h"
#import "ISMessages.h"
#import "UITextField+Extra.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
//#import "NSDate+Extra.h"


/****** AppDelegate Instance ******/
/****** --------------------------------------------------------------------------------------------------------------- ******/
#define APP_DELEGATE (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define UNIQUE_IDENTIFIER [[[UIDevice currentDevice] identifierForVendor] UUIDString]
#define DEVICE_OS_VERSION  [[UIDevice currentDevice] systemVersion]
#define DEVICE_OS_MODEL   [[UIDevice currentDevice] model]
#define DEVICE_OS_MANUFACTURE   [[UIDevice currentDevice] name]
#define FIREBASE_TOKEN   @""
#define GOOGLE_CLIENT_ID @"1080526596104-os515qur6isnkv89077vv2scp53f5qad.apps.googleusercontent.com"
#define FACEBOOK_CLIENT_ID @"fb161139811248744"
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]


/****** System Version Constants define here ******/
/****** --------------------------------------------------------------------------------------------------------------- ******/
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDesc

/****** Constant for Check the Devices Resolution and the ScrenSize defined here ******/
/****** --------------------------------------------------------------------------------------------------------------- ******/
#define IS_IPHONE5  CGSizeEqualToSize([[UIScreen mainScreen] preferredMode].size,CGSizeMake(640, 1136))
#define IS_IPHONE6  CGSizeEqualToSize([[UIScreen mainScreen] preferredMode].size,CGSizeMake(750, 1334))
#define IS_IPHONE6PLUS CGSizeEqualToSize([[UIScreen mainScreen] preferredMode].size,CGSizeMake(1242, 2208))
#define IPHONE6 ScreenHeight==667
#define IPHONE6PLUS ScreenHeight==736
#define IS_IPHONE                (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)?YES:NO
#define IS_IPAD                   UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
#define SCREEN_WIDTH             [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT            [UIScreen mainScreen].bounds.size.height
#define IS_IPHONE4          CGSizeEqualToSize([[UIScreen mainScreen] preferredMode].size,CGSizeMake(640, 960))
#define IPHONE5 ScreenHeight==568
#define IPHONE6 ScreenHeight==667
#define IPHONE6PLUS ScreenHeight==736
#define SCREEN_BOUNDS             [[UIScreen mainScreen] bounds]

#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_ZOOMED (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)


#define COLOR_WITH_RGBA(r,g,b,a)       [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define HEADER_COLOR COLOR_WITH_RGBA(87,195, 192,1)

#define DOC_DIR             [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES) objectAtIndex:0]
#define GET_MEDIA_URL(mediaName)              [NSString stringWithFormat:@"%@%@",MEDIA_URL,mediaName]

#define IMAGE(v) [UIImage imageNamed:v]


#define DefaultThemeColor       [UIColor colorWithRed:29.0f/255.0f green:65.0f/255.0f blue:106.0f/255.0f alpha:1.0f]

#define DefaultButtonColor       [UIColor colorWithRed:12/255.0f green:91/255.0f blue:174/255.0f alpha:1.0f]

/********************************************** Shared Object Defined *************************************************/
#define SharedObject [SharedManager sharedInstance]
#define SHOULD_PRINT_LOG YES
#define PRINT_LOG(var...) if(SHOULD_PRINT_LOG) NSLog(var)


/****** Alert Messages is being defined here for Failure of UI ( User Input ) ******/
/****** --------------------------------------------------------------------------------------------------------------- ******/
#pragma mark- Prompting Message for Failure/Validate.......

#define kValueNotImportant @"Not Important"
#define kCodeNotImportant @"N/A"
#define kLegalTypeDefault @"Select Legal Type"
#define kMessageNoInternet       @"Internet is not Available. Try again later!"
#define kMessageNoDataFound      @"Failed to Fetch Data From Server..!"


/****** API URL & APIDOMAIN CALLED HERE ******/

#define SAVE_USER_DEFAULTS(VALUE,KEY) [[NSUserDefaults standardUserDefaults] setObject:VALUE forKey:KEY]; [[NSUserDefaults standardUserDefaults] synchronize]
#define GET_USER_DEFAULTS(KEY) [[NSUserDefaults standardUserDefaults] objectForKey:KEY]

#define RUN_AFTER(time,block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), block)

#define MAINTASK(block) dispatch_async(dispatch_get_main_queue(),block)


/****** --------------------------------------------------------------------------------------------------------------- ******/


#define SEARCH_USER_API(SearchText,Corporate_Id) [NSString stringWithFormat:@"http://182.71.127.244/api/api.php/CorporteUsers/?transform=1&filter[]=cor_user_name,cs,%@&filter[]=corp_id,eq,%@",SearchText,Corporate_Id]

//=================================================EXCEPTION======================================================//

#pragma mark EXCEPTION...
#define LOG_EXCEPTION(exception)           NSLog(@"%s %d => %@",__FUNCTION__,__LINE__,[exception debugDescription])

//=====================================================Fonts======================================================//
#define UI_DEFAULT_FONT(_size)        [UIFont fontWithName:@"HelveticaNeue" size:_size]
#define UI_DEFAULT_FONT_BOLD(_size)   [UIFont fontWithName:@"HelveticaNeue-Bold" size:_size]
#define UI_DEFAULT_FONT_LIGHT(_size)  [UIFont fontWithName:@"Roboto-Light" size:_size]
#define UI_DEFAULT_FONT_MEDIUM(_size) [UIFont fontWithName:@"HelveticaNeue-Medium" size:_size]
#define UI_DEFAULT_FONT_THIN(_size)   [UIFont fontWithName:@"Roboto-Thin" size:_size]
#define UI_DEFAULT_LOGO_FONT(_size)   [UIFont fontWithName:@"Neuropol-Regular" size:_size]
#define UI_DEFAULT_LOGO_FONT_BOLD(_size)   [UIFont fontWithName:@"NeuropolBold" size:_size]
#define UI_DEFAULT_LOGO_FONT_MEDIUM(_size)   [UIFont fontWithName:@"NeuropolMedium" size:_size]


#define GET_COLOR_WITH_RGB(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define DEFAULT_COLOR               [UIColor colorWithRed:29.0f/255.0f green:65.0f/255.0f blue:160.0f/255.0f alpha:1.0f]
#define SHOW_ALERT(Message,Delegate)    [[[UIAlertView alloc] initWithTitle:APP_NAME message:Message delegate:Delegate cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
#define ALERT(Message,Delegate,FirstTitle,SecondTitle)  [[UIAlertView alloc] initWithTitle:APP_NAME message:Message delegate:Delegate cancelButtonTitle:FirstTitle otherButtonTitles:SecondTitle, nil];


#define GET_VIEW_CONTROLLER(viewController)     [self.storyboard instantiateViewControllerWithIdentifier:viewController]



