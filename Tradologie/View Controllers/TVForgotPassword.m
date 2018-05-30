//
//  TVForgotPassword.m
//  Tradologie
//
//  Created by Chandresh Maurya on 07/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "TVForgotPassword.h"
#import "CommonUtility.h"
#import "Constant.h"

@interface TVForgotPassword ()

@end

@implementation TVForgotPassword

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [txtEmailID setDefaultPreferenceTextfieldStyle:[UIImage imageNamed:@"IconUser"] WithPlaceHolder:@"Email Address" withTag:0];
    [btnback addTarget:self action:@selector(btnBackfired:) forControlEvents:UIControlEventTouchUpInside];
     [btnSubmit addTarget:self action:@selector(btnSubmitPasswordClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btnSubmit setDefaultButtonStyleWithHighLightEffect];
    [btnSubmit.titleLabel setFont:IS_IPHONE5?UI_DEFAULT_FONT_MEDIUM(18): UI_DEFAULT_FONT_MEDIUM(20)];
     [lbl_logoname setFont:([SDVersion deviceSize] > Screen4Dot7inch)?UI_DEFAULT_LOGO_FONT_MEDIUM(28):([SDVersion deviceSize] < Screen4Dot7inch)?UI_DEFAULT_LOGO_FONT_MEDIUM(22):UI_DEFAULT_LOGO_FONT_MEDIUM(25)];
   // [lbl_logoname setFont:IS_IPHONE5?UI_DEFAULT_LOGO_FONT_MEDIUM(22): UI_DEFAULT_LOGO_FONT_MEDIUM(26)];

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
    return 3;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return _viewHeader;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== BUTTON ACTION EVENT CALLED ===❉===❉
/*****************************************************************************************************************/

-(IBAction)btnBackfired:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)btnSubmitPasswordClicked:(UIButton *)sender
{
    [self.view endEditing:YES];
    
    BOOL isValidate=TRUE;
    
    if ([Validation validateTextField:txtEmailID])
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Enter your Email Address..!"];
        return;
    }
    else if (![Validation validateEmail:txtEmailID.text])
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Enter a valid Email Id..!"];
        return;
    }
   
    
    if (isValidate)
    {
        [CommonUtility showProgressWithMessage:@"Please Wait.."];
        [CommonUtility HideProgress];
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
@end
