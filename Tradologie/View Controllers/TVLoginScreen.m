//
//  TVLoginScreen.m
//  DemoApp
//
//  Created by Chandresh Maurya on 03/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "TVLoginScreen.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <linkedin-sdk/LISDK.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import "TvAlreadyUserScreen.h"
#import "TvCreateAccount.h"
#import "Constant.h"
#import "CommonUtility.h"
#import "MBAPIManager.h"
#import "SharedManager.h"
#import "AppConstant.h"
#import "MBDataBaseHandler.h"
#import "TVCompanyRegister.h"
#import <linkedin-sdk/LISDKPermission.h>


@interface TVLoginScreen ()<GIDSignInDelegate, GIDSignInUIDelegate>

@end

@implementation TVLoginScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:YES];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    
    [_btnAlreadyLogin addTarget:self action:@selector(btnAlreadyLoginClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_btnGooglePlus addTarget:self action:@selector(btnGogglePlusSignIn:) forControlEvents:UIControlEventTouchUpInside];
    
    [_btnCreateAccount addTarget:self action:@selector(btnCreateAccountClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_btnFaceBook addTarget:self action:@selector(btnFaceBookClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_btnLinkedIn addTarget:self action:@selector(btnLinkedInClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
    [btnOr.layer setBorderWidth:1.0f];
    [btnOr.layer setBorderColor:UIColor.lightGrayColor.CGColor];
    [btnOr.layer setCornerRadius:btnOr.frame.size.height/2];
    
    [_btnAlreadyLogin setDefaultButtonStyleWithHighLightEffect];
    [_btnCreateAccount setDefaultButtonStyleWithHighLightEffect];
    [_btnFaceBook setDefaultButtonStyleWithHighLightEffect];
    [_btnGooglePlus setDefaultButtonStyleWithHighLightEffect];
    [_btnLinkedIn setDefaultButtonStyleWithHighLightEffect];
    
    if ([SDVersion deviceSize] > Screen4inch)
    {
        [lblCopyRight setFont:UI_DEFAULT_FONT_MEDIUM(15)];
    }
    else
    {
        [lblCopyRight setFont:UI_DEFAULT_FONT_MEDIUM(12)];
        [_btnCreateAccount.titleLabel setNumberOfLines:2];
        [_btnCreateAccount.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [_btnCreateAccount.titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset =  ([SDVersion deviceSize] > Screen5Dot5inch) ? CGPointMake(0, -45): CGPointMake(0, -15);
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/******************************************************************************************************************/
#pragma mark ❉===❉=== TABLEVIEW DELEGATE & DATA SOURCE CALLED HERE ===❉===❉
/*****************************************************************************************************************/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return _viewHeader;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return _viewFooter;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return ([SDVersion deviceSize] > Screen4Dot7inch) ? 50:78;
    
}
/******************************************************************************************************************/
#pragma mark ❉===❉===  BUTTON ACTION EVENT CALLED ===❉===❉
/*****************************************************************************************************************/

-(IBAction)btnAlreadyLoginClicked:(id)sender{
    TvAlreadyUserScreen *alreadyUser = [self.storyboard instantiateViewControllerWithIdentifier:@"TvAlreadyUserScreen"];
    [self.navigationController pushViewController:alreadyUser animated:YES];
}
-(IBAction)btnCreateAccountClicked:(id)sender{
    TvCreateAccount *objCreateScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"TvCreateAccount"];
    [self.navigationController pushViewController:objCreateScreen animated:YES];
}
-(IBAction)btnFaceBookClicked:(UIButton *)sender
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions: @[@"public_profile",@"email"]
                 fromViewController:self
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
     {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             [CommonUtility ShowAlertwithTittle:@"You have denied to SignUp with Facebook..!" withID:self];
         } else {
             NSLog(@"Logged in");
             if ([FBSDKAccessToken currentAccessToken])
             {
                 
                 FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                               initWithGraphPath:@"me"
                                               parameters:@{@"fields":@"id,first_name,name,last_name,email,picture,gender"}
                                               HTTPMethod:@"GET"];
                 [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                                       id result,
                                                       NSError *error)
                  {
                      if (!error)
                      {
                          NSLog(@"result %@", result);
                          
                          NSMutableDictionary *dicResult = [[NSMutableDictionary alloc]init];
                          dicResult = [result mutableCopy];
                          
                          NSMutableDictionary *dicParams = [[NSMutableDictionary alloc]init];
                          [dicParams setValue:API_DEFAULT_TOKEN forKey:@"Token"];
                          [dicParams setValue:[dicResult valueForKey:@"email"] forKey:@"EmailID"];
                          [dicParams setValue:[dicResult valueForKey:@"name"] forKey:@"Name"];
                          [dicParams setValue:@"Facebook" forKey:@"ServiceType"];
                          [dicParams setValue:@"" forKey:@"Gender"];
                          [dicParams setValue:FACEBOOK_CLIENT_ID forKey:@"UserAppID"];
                          [dicParams setValue:DEVICE_OS_MANUFACTURE forKey:@"Manufacturer"];
                          [dicParams setValue:DEVICE_OS_MODEL forKey:@"Model"];
                          [dicParams setValue:DEVICE_OS_VERSION forKey:@"OsVersionRelease"];
                          [dicParams setValue:APP_VERSION forKey:@"AppVersion"];
                          [dicParams setValue:FIREBASE_TOKEN forKey:@"FcmToken"];
                          [dicParams setValue:@"IOS" forKey:@"OsType"];
                          [dicParams setValue:UNIQUE_IDENTIFIER forKey:@"DeviceId"];
                          
                          [self getRegistrationWithSocialMEdia:dicParams];
                      }
                      else{
                          dispatch_async(dispatch_get_main_queue(), ^{
                          });
                      }
                  }];
             }
             
         }
     }];
    
}
-(IBAction)btnLinkedInClicked:(UIButton *)sender
{
    if (! [LISDKSessionManager hasValidSession] )
    {
        [LISDKSessionManager createSessionWithAuth:[NSArray arrayWithObjects:LISDK_FULL_PROFILE_PERMISSION, LISDK_EMAILADDRESS_PERMISSION, nil]state:@"some state"
                            showGoToAppStoreDialog:YES
                                      successBlock:^(NSString *returnState)
         {
             NSLog(@"%s","success called!");
             LISDKSession *session = [[LISDKSessionManager sharedInstance] session];
             NSLog(@"value=%@ isvalid=%@",[session value],[session isValid] ? @"YES" : @"NO");
             NSMutableString *text = [[NSMutableString alloc] initWithString:[session.accessToken description]];
             [text appendString:[NSString stringWithFormat:@",state=\"%@\"",returnState]];
             NSLog(@"Response label text %@",text);
             
         }
                                        errorBlock:^(NSError *error)
         {
             NSLog(@"%s %@","error called! ", [error description]);
             [CommonUtility ShowAlertwithTittle:@"You need to download the LinkedIn App in order to connect with LinkedIn" withID:self];
         }];
    }
    else
    {
        
    }
//    [[LISDKAPIHelper sharedInstance] getRequest:@"https://api.linkedin.com/v1/people/~"
//                                        success:^(LISDKAPIResponse *response)
//     {
//         NSData* data = [response.data dataUsingEncoding:NSUTF8StringEncoding];
//         NSDictionary *dictResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//         NSLog(@"Authenticated user name : %@ %@", [dictResponse valueForKey: @"firstName"], [dictResponse valueForKey: @"lastName"]);
//     } error:^(LISDKAPIError *apiError)
//     {
//         NSLog(@"Error : %@", apiError);
//     }];
//    NSLog(@"%s","sync pressed3");
    
}
/******************************************************************************************************************/
#pragma mark ❉===❉===  BUTTON GOOGLE ACTION EVENT CALLED ===❉===❉
/*****************************************************************************************************************/
-(IBAction)btnGogglePlusSignIn:(UIButton *)sender
{
    [GIDSignIn sharedInstance].uiDelegate = self;
    [GIDSignIn sharedInstance].delegate = self;
    [[GIDSignIn sharedInstance] signIn];
    
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== GOOGLE SIGNIN DELEGATE CALLED ===❉===❉
/*****************************************************************************************************************/
- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error
{
    if (error)
    {
        [CommonUtility ShowAlertwithTittle:error.localizedDescription withID:self];
        return;
    }
    else
    {
        if([GIDSignIn sharedInstance].currentUser.profile.hasImage)
        {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setValue:API_DEFAULT_TOKEN forKey:@"Token"];
            [dic setValue:user.profile.email forKey:@"EmailID"];
            [dic setValue:user.profile.name forKey:@"Name"];
            [dic setValue:@"Google Plus" forKey:@"ServiceType"];
            [dic setValue:@"" forKey:@"Gender"];
            [dic setValue:GOOGLE_CLIENT_ID forKey:@"UserAppID"];
            [dic setValue:DEVICE_OS_MANUFACTURE forKey:@"Manufacturer"];
            [dic setValue:DEVICE_OS_MODEL forKey:@"Model"];
            [dic setValue:DEVICE_OS_VERSION forKey:@"OsVersionRelease"];
            [dic setValue:APP_VERSION forKey:@"AppVersion"];
            [dic setValue:FIREBASE_TOKEN forKey:@"FcmToken"];
            [dic setValue:@"IOS" forKey:@"OsType"];
            [dic setValue:UNIQUE_IDENTIFIER forKey:@"DeviceId"];
            
            [self getRegistrationWithSocialMEdia:dic];
            //SAVE_USER_DEFAULTS(txtEmailID.text, @"emailID"); //
        }
        else
        {
        }
        
    }
    [self reportAuthStatus];
}

- (void)signIn:(GIDSignIn *)signIn didDisconnectWithUser:(GIDGoogleUser *)user withError:(NSError *)error
{
    if (error) {
        // _signInAuthStatus.text = [NSString stringWithFormat:@"Status: Failed to disconnect: %@", error];
    } else {
        //_signInAuthStatus.text = [NSString stringWithFormat:@"Status: Disconnected"];
    }
    [self reportAuthStatus];
}

- (void)reportAuthStatus
{
    GIDGoogleUser *googleUser = [[GIDSignIn sharedInstance] currentUser];
    if (googleUser.authentication) {
        NSLog(@"Status: Authenticated");
    } else {
        // To authenticate, use Google+ sign-in button.
        NSLog(@"Status: Not authenticated");
    }
}

/******************************************************************************************************************/
#pragma mark ❉===❉===  REGISTERATION API WITH SOCIAL MEDIA CALLED ===❉===❉
/*****************************************************************************************************************/
-(void)getRegistrationWithSocialMEdia:(NSMutableDictionary *)dicParameter
{
    if (SharedObject.isNetAvailable)
    {
        [CommonUtility showProgressWithMessage:@"Please Wait.."];
        
        MBCall_RegisterUserWithSocailMedia(dicParameter, nil, ^(id response, NSString *error, BOOL status)
                                           {
                                               NSError* Error;
                                               if (status && ![[response valueForKey:@"success"]isEqual:@0])
                                               {
                                                   NSLog(@"response == >%@",response);
                                                   [CommonUtility HideProgress];
                                                   
                                                   NSMutableDictionary *dicUserDetail = [[NSMutableDictionary alloc]init];
                                                   dicUserDetail = [[response valueForKey:@"detail"] mutableCopy];
                                                   
                                                   BuyerUserDetail *detail =[[BuyerUserDetail alloc]initWithDictionary:response error:&Error];
                                                   [MBDataBaseHandler saveCommonDataDetail:detail];
                                                   
                                                   if ([[dicUserDetail valueForKey:@"IsComplete"] isEqualToString:@"N"] && [[dicUserDetail valueForKey:@"VerificationStatus"]isEqual:@1])
                                                   {
                                                       TVCompanyRegister *objCompanyScreen = GET_VIEW_CONTROLLER(@"TVCompanyRegister");
                                                       [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
                                                       [self.navigationController.navigationBar setHidden:NO];
                                                       [self.navigationController pushViewController:objCompanyScreen animated:YES];
                                                       
                                                   }
                                                   else
                                                   {
                                                       NSLog(@"response == >%@",response);
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           RootViewController * rootVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RootViewController"];
                                                           AppDelegate *delegateClass = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                                                           [delegateClass setRootViewController:rootVC];
                                                       });
                                                   }
                                               }
                                               else
                                               {
                                                   [CommonUtility HideProgress];
                                                   [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:[response valueForKey:@"message"]];
                                                   
                                               }
                                               
                                           });
    }
    else
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Internet Not Available Please Try Again..!"];
    }
}

@end
