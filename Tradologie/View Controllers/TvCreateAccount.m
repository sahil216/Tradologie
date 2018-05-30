//
//  TvCreateAccount.m
//  Tradologie
//
//  Created by Chandresh Maurya on 05/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "TvCreateAccount.h"
#import "VcPopScreen.h"
#import "CommonUtility.h"
#import "Constant.h"
#import "MBAPIManager.h"
#import "AppConstant.h"
#import "SharedManager.h"
#import "VCMessageScreen.h"
#import "TVCompanyRegister.h"
#import "MBDataBaseHandler.h"


@interface TvCreateAccount ()<PopupViewDelegate>
{
    NSString *strGender;
    NSMutableArray *selectedID;
    NSMutableArray *selecteValues;
    detail *objDetail;
}
@end

@implementation TvCreateAccount

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [txtName setDefaultTextfieldStyleWithPlaceHolder:@"Your Name" withTag:0];
    [txtEmailID setDefaultTextfieldStyleWithPlaceHolder:@"Your Email" withTag:0];
    [txtMobile setDefaultTextfieldStyleWithPlaceHolder:@"Your Mobile Number" withTag:0];
    [txtPassword setDefaultTextfieldStyleWithPlaceHolder:@"Password" withTag:0];
    [txtConfirmPassword setDefaultTextfieldStyleWithPlaceHolder:@"Confirm Password" withTag:0];
    
    [txtCategory setAdditionalInformationTextfieldStyle:@"Select One Category" Withimage:[UIImage imageNamed:@"IconDropDrown"] withID:self withSelectorAction:@selector(btnDropDownClicked:) withTag:0];
    [btnback addTarget:self action:@selector(btnBackTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [lbl_logoname setFont:([SDVersion deviceSize] > Screen4Dot7inch)?UI_DEFAULT_LOGO_FONT_MEDIUM(28):([SDVersion deviceSize] < Screen4Dot7inch)?UI_DEFAULT_LOGO_FONT_MEDIUM(22):UI_DEFAULT_LOGO_FONT_MEDIUM(25)];
    
    UITapGestureRecognizer *recoganize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapHandle:)];
    [recoganize setNumberOfTapsRequired:1];
    [self.tableView addGestureRecognizer:recoganize];
    
    [btnMale addTarget:self action:@selector(btnGenderTapped:) forControlEvents:UIControlEventTouchUpInside];
    [btnFemale addTarget:self action:@selector(btnGenderTapped:) forControlEvents:UIControlEventTouchUpInside];
    [btnAgreeTerms addTarget:self action:@selector(btnAgreeTermsTapped:) forControlEvents:UIControlEventTouchUpInside];
    [btnSubmit addTarget:self action:@selector(btnSubmitUserClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btnSubmit setDefaultButtonStyleWithHighLightEffect];
    [btnSubmit.titleLabel setFont:IS_IPHONE5?UI_DEFAULT_FONT_MEDIUM(18): UI_DEFAULT_FONT_MEDIUM(20)];
    [btnMale setSelected:true];
    strGender = @"2";
    
    selecteValues = [NSMutableArray new];
    selectedID = [NSMutableArray new];
    
    [self getallCategoryList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointMake(0, -15);
    }
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== TABLEVIEW DELEGATE & DATA SOURCE CALLED HERE ===❉===❉
/*****************************************************************************************************************/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return _viewHeader;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 55;
}

/******************************************************************************************************************/
#pragma mark ❉===❉=== BUTTON ACTION EVENT CALLED HERE ===❉===❉
/*****************************************************************************************************************/

-(IBAction)btnBackTapped:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)didTapHandle:(UITapGestureRecognizer *)recoganise
{
    [self.view endEditing:YES];
}
-(IBAction)btnGenderTapped:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender == btnMale)
    {
        [btnMale setSelected:YES];
        [btnMale setUserInteractionEnabled:NO];
        [btnFemale setUserInteractionEnabled:YES];
        strGender = @"2";
        [btnFemale setSelected:NO];
    }
    else{
        [btnMale setSelected:NO];
        strGender = @"1";
        [btnMale setUserInteractionEnabled:YES];
        [btnFemale setUserInteractionEnabled:NO];
        [btnFemale setSelected:YES];
    }
}
-(IBAction)btnAgreeTermsTapped:(UIButton *)sender
{
    sender.selected = !sender.selected;
}
-(IBAction)btnDropDownClicked:(UIButton *)sender
{
    [self ShowCategoryPopUp];
}

-(IBAction)btnSubmitUserClicked:(UIButton *)sender
{
    [self.view endEditing:YES];
    BOOL isValidate=TRUE;
    
    if ([Validation validateTextField:txtName])
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Enter your Full Name..!"];
        return;
    }
    else if ([Validation validateTextField:txtEmailID])
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Enter your Email Address..!"];
        return;
    }
    else if (![Validation validateEmail:txtEmailID.text])
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Enter a valid Email Id..!"];
        return;
    }
    else if ([Validation validateTextField:txtMobile])
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Enter your Mobile Number..!"];
        return;
    }
    else if (![Validation validatePhoneNumber:txtMobile.text])
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Enter a valid Mobile Number with Country Code..!"];
        return;
    }
    else if ([Validation validateTextField:txtPassword])
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Enter your Password..!"];
        return;
    }
    else if (![Validation isAlphaNumericAndContainsAtLeastSixDigit:txtPassword.text])
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Enter your Password between 4 to 10 Digits Alpha Numeric..!"];
        return;
    }
    else if ([Validation validateTextField:txtConfirmPassword])
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Enter Your Confirm Password..!"];
        return;
    }
    else if (![Validation validatePassword:txtPassword ConfirmPassword:txtConfirmPassword])
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Opps Your Password Did Not Match..!"];
        return;
    }
    else if ([Validation validateTextField:txtCategory])
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Select atleast One Category..!"];
        return;
    }
    else if(!btnAgreeTerms.isSelected)
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Agree the Term's & Privacy Policy..!"];
        return;
    }
    if (isValidate)
    {
        if (SharedObject.isNetAvailable)
        {
            [CommonUtility showProgressWithMessage:@"Please Wait.."];
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setValue:API_DEFAULT_TOKEN forKey:@"Token"];
            [dic setValue:txtName.text forKey:@"UserName"];
            [dic setValue:txtEmailID.text forKey:@"EmailID"];
            [dic setValue:txtMobile.text forKey:@"MobileNo"];
            [dic setValue:txtPassword.text forKey:@"Password"];
            [dic setValue:strGender forKey:@"GenderID"];
            [dic setValue:TYPE_OF_ACCOUNT_ID forKey:@"TypeOfAccountID"];
            NSString *strID = [selectedID componentsJoinedByString:@","];
            [dic setValue:strID forKey:@"GroupIDs"];
            
            
            MBCall_RegisterUserWithPostData(dic, nil, ^(id response, NSString *error, BOOL status)
            {
                if (status && ![[response valueForKey:@"success"]isEqual:@0])
                {
                    NSLog(@"response == >%@",response);
                    [CommonUtility HideProgress];
                    [self getLoginServiceCalles];
                    
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
    
}
-(void)getLoginServiceCalles
{
    if (SharedObject.isNetAvailable)
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:txtEmailID.text forKey:@"UserID"];
        [dic setValue:txtPassword.text forKey:@"Password"];
        [dic setValue:DEVICE_OS_MANUFACTURE forKey:@"Manufacturer"];
        [dic setValue:DEVICE_OS_MODEL forKey:@"Model"];
        [dic setValue:DEVICE_OS_VERSION forKey:@"OsVersionRelease"];
        [dic setValue:APP_VERSION forKey:@"AppVersion"];
        [dic setValue:FIREBASE_TOKEN forKey:@"FcmToken"];
        [dic setValue:@"IOS" forKey:@"OsType"];
        [dic setValue:UNIQUE_IDENTIFIER forKey:@"DeviceId"];
        SAVE_USER_DEFAULTS(txtEmailID.text, @"emailID"); // For Use of popup Message to Resend emails
        
        MBCall_LoginUserUsing(dic, ^(id response, NSString *error, BOOL status)
        {
            if (status && [[response valueForKey:@"success"]  isEqual: @1])
            {
                NSLog(@"response == >%@",response);
                
                NSMutableDictionary *dicUserDetail = [[NSMutableDictionary alloc]init];
                dicUserDetail = [[response valueForKey:@"detail"] mutableCopy];
                
                if ([[dicUserDetail valueForKey:@"IsComplete"] isEqualToString:@"N"] && [[dicUserDetail valueForKey:@"VerificationStatus"]isEqual:@0])
                {
                    VCMessageScreen * vcpopUp = [self.storyboard instantiateViewControllerWithIdentifier:@"VCMessageScreen"];
                    [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
                    [self.navigationController.navigationBar setHidden:NO];
                    [self.navigationController pushViewController:vcpopUp animated:YES];
                    
                }
                else  if ([[dicUserDetail valueForKey:@"IsComplete"] isEqualToString:@"N"] && [[dicUserDetail valueForKey:@"VerificationStatus"]isEqual:@1])
                {
                    NSError* Error;
                    BuyerUserDetail *detail =[[BuyerUserDetail alloc]initWithDictionary:response error:&Error];
                    [MBDataBaseHandler saveCommonDataDetail:detail];
                    
                    TVCompanyRegister *objCompanyScreen = GET_VIEW_CONTROLLER(@"TVCompanyRegister");
//                    [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
                    [self.navigationController pushViewController:objCompanyScreen animated:YES];
                }
            }
            else{
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
/******************************************************************************************************************/
#pragma mark ❉===❉=== TEXTFIELD DELEGATE CALLED HERE ===❉===❉
/******************************************************************************************************************/
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField ==  txtCategory)
    {
        [txtCategory resignFirstResponder];
        [self ShowCategoryPopUp];
        return NO;
    }
    return YES;
}
//************************************************************************************************
#pragma mark ❉===❉=== SHOW CATEGORY POPUP ===❉===❉
//************************************************************************************************
-(void)ShowCategoryPopUp
{
    VcPopScreen * vcpopUp = [self.storyboard instantiateViewControllerWithIdentifier:@"VcPopScreen"];
    [vcpopUp.view setBackgroundColor:[GET_COLOR_WITH_RGB(49, 85, 126, 1) colorWithAlphaComponent:0.90f]];
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    vcpopUp.delegate = self;
    vcpopUp.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:vcpopUp animated:YES completion:^{
        //animations
    }];
}
/******************************************************************************************************************/
#pragma mark ❉===❉===  POPUP DELEGATE METHOD CALLED HERE ===❉===❉
/******************************************************************************************************************/
- (void)popupViewSelectedData:(NSMutableArray *)array
{
    [selecteValues removeAllObjects];
    [selectedID removeAllObjects];
    for (detail *objDetail in array)
    {
        [selecteValues addObject:objDetail.GroupName];
        [selectedID addObject:objDetail.GroupID];
    }
    NSString *strText = [selecteValues componentsJoinedByString:@","];
    [txtCategory setText:strText];
}

/******************************************************************************************************************/
#pragma mark ❉===❉===  GET ALL CATEGORY API HERE ===❉===❉
/******************************************************************************************************************/

-(void)getallCategoryList
{
    if (SharedObject.isNetAvailable)
    {
        MBCall_GetAllCategories(^(id response, NSString *error, BOOL status)
        {
            if (status)
            {
                NSError* Error;
                
                if (response != (NSDictionary *)[NSNull null])
                {
                    ProductCategory *objProduct = [[ProductCategory alloc]initWithDictionary:response error:&Error];
                    [MBDataBaseHandler saveProductCategoryDetail:objProduct];
                }
            }
            else
            {
            }
        });
    }
    else
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Internet Not Available Please Try Again..!"];
    }
}


@end
