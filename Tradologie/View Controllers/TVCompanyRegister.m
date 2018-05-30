//
//  TVCompanyRegister.m
//  Tradologie
//
//  Created by Chandresh Maurya on 15/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "TVCompanyRegister.h"
#import "Constant.h"
#import "CommonUtility.h"
#import "AppConstant.h"
#import "MBDataBaseHandler.h"
#import "SharedManager.h"
#import "MBAPIManager.h"
#import "RootViewController.h"



@interface TVCompanyRegister ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSMutableArray *arrTimeZone;
    NSMutableArray *arrCountry;
    NSMutableArray *arrStateList;
    NSMutableArray *arrTimeZoneID;
    NSMutableArray *arrInterestedID;
    NSMutableArray *arrCityList;
    NSMutableArray *arrInterestedIn;
    
    NSString *timeZoneID,*InterestedID;
   
}
@end

@implementation TVCompanyRegister

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     [lbl_logoname setFont:([SDVersion deviceSize] > Screen4Dot7inch)?UI_DEFAULT_LOGO_FONT_MEDIUM(28):([SDVersion deviceSize] < Screen4Dot7inch)?UI_DEFAULT_LOGO_FONT_MEDIUM(22):UI_DEFAULT_LOGO_FONT_MEDIUM(25)];
    [btnback addTarget:self action:@selector(btnBackItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self SetInitialSetUp];
    [self getallCommonDataAPI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointMake(0, -15);
    }
}
-(void)SetInitialSetUp
{
    [txtCompanyName setDefaultTextfieldStyleWithPlaceHolder:@"Your Company Name" withTag:0];
    [txtPANNo setDefaultTextfieldStyleWithPlaceHolder:@"Your PAN No." withTag:0];
    [txtGSTIN setDefaultTextfieldStyleWithPlaceHolder:@"Your Company Registeration No./ GSTIN" withTag:0];
    [txtTimeZone setRightViewTextfieldStyle:@"--- Select Time Zone ---" Withimage:@"IconDropDrown" withTag:0];
    [txtCountry setRightViewTextfieldStyle:@"--- Select Country ---"Withimage:@"IconDropDrown" withTag:0];
    [txtStateProvince setRightViewTextfieldStyle:@"--- Select State / Province Name ---" Withimage:@"IconDropDrown" withTag:0];
    [txtCity setRightViewTextfieldStyle:@"--- Select City ---" Withimage:@"IconDropDrown" withTag:0];
    [txtInterestedIn setRightViewTextfieldStyle:@"--- Select Interested ---" Withimage:@"IconDropDrown" withTag:0];

    [btnSubmit setDefaultButtonStyleWithHighLightEffect];
    [btnSubmit addTarget:self action:@selector(btnUpdateCompulsoryTaped:) forControlEvents:UIControlEventTouchUpInside];
    [btnAgreeTerms addTarget:self action:@selector(btnAgreeTermsTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self SetPickerViewWithToolBar];
}
//************************************************************************************************
#pragma mark ❉===❉=== Tabel View DataSource ===❉===❉
//************************************************************************************************
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 11;
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

//************************************************************************************************
#pragma mark ❉===❉=== PICKERVIEW DELEGATE & DATASOURCE ===❉===❉
//************************************************************************************************

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([txtTimeZone isEditing])
    {
        return [arrTimeZone count];
    }
    else if ([txtStateProvince isEditing])
    {
        return [arrStateList count];
    }
    else if ([txtCity isEditing])
    {
        return [arrCityList count];
    }
    else if ([txtInterestedIn isEditing])
    {
        return [arrInterestedIn count];
    }
    return [arrCountry count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    pickerView.tintColor =[UIColor whiteColor];
    if ([txtTimeZone isEditing])
    {
        return [arrTimeZone objectAtIndex:row];
    }
    else if ([txtStateProvince isEditing])
    {
        return [arrStateList objectAtIndex:row];
    }
    else if ([txtCity isEditing])
    {
        return [arrCityList objectAtIndex:row];
    }
    else if ([txtInterestedIn isEditing])
    {
        return [arrInterestedIn objectAtIndex:row];
    }
    return [arrCountry objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([txtTimeZone isEditing])
    {
        [txtTimeZone setText:[arrTimeZone objectAtIndex:row]];
        timeZoneID = [arrTimeZoneID objectAtIndex:row];
        
    }
    else if ([txtCountry isEditing])
    {
        [txtCountry setText:[arrCountry objectAtIndex:row]];
        [self getStateByCountryName:txtCountry.text];
    }
    else if ([txtStateProvince isEditing])
    {
        [txtStateProvince setText:[arrStateList objectAtIndex:row]];
        [self getCityByStateName:txtStateProvince.text];
    }
    else if ([txtCity isEditing])
    {
        [txtCity setText:[arrCityList objectAtIndex:row]];
    }
    else if ([txtInterestedIn isEditing])
    {
        [txtInterestedIn setText:[arrInterestedIn objectAtIndex:row]];
        InterestedID = [arrInterestedID objectAtIndex:row];

    }
}
//- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    NSString *title = [arrTimeZone objectAtIndex:row];
//    [pickerView setBackgroundColor:DefaultThemeColor];
//    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
//                     NSFontAttributeName:UI_DEFAULT_FONT(5)}];
//    return attString;
//}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* label = (UILabel*)view;
    
    [pickerView setBackgroundColor:DefaultThemeColor];
    
    NSString *strValue;
    if ([txtCountry isEditing])
    {
        strValue = [NSString stringWithFormat:@"%@",[arrCountry objectAtIndex:row]];
    }
    else if ([txtStateProvince isEditing])
    {
        strValue = [NSString stringWithFormat:@"%@",[arrStateList objectAtIndex:row]];
    }
     else if ([txtCity isEditing])
     {
         strValue = [NSString stringWithFormat:@"%@",[arrCityList objectAtIndex:row]];
     }
     else if ([txtInterestedIn isEditing]){
         strValue = [NSString stringWithFormat:@"%@",[arrInterestedIn objectAtIndex:row]];
     }
     else{
         strValue = [NSString stringWithFormat:@"%@",[arrTimeZone objectAtIndex:row]];
     }
    
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:strValue attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                        NSFontAttributeName:UI_DEFAULT_FONT(16)}];
    if (view == nil)
    {
        label= [[UILabel alloc] initWithFrame:CGRectMake(5, 0, pickerView.frame.size.width-10, 44)];
        label.textAlignment = NSTextAlignmentLeft;
        
    }
    [label setAttributedText:attString];
    return label;
}

/******************************************************************************************************************/
#pragma mark ❉===❉=== SHOW PICKER WITH TOOLBAR ===❉===❉
/******************************************************************************************************************/
-(void)SetPickerViewWithToolBar
{
    pickerViewType=[[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 216.0f)];
    [pickerViewType setBackgroundColor:DefaultThemeColor];
    [pickerViewType setValue:[UIColor whiteColor] forKeyPath:@"textColor"];
    [pickerViewType setDelegate:self];
    [pickerViewType setDataSource:self];
    
    UITapGestureRecognizer *recognizer =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestureRecognizersTaped :)];
    [recognizer setNumberOfTapsRequired:1];
    [self.tableView addGestureRecognizer:recognizer];
    
    [txtTimeZone setInputView:pickerViewType];
    [txtCountry setInputView:pickerViewType];
    [txtStateProvince setInputView:pickerViewType];
    [txtCity setInputView:pickerViewType];
    [txtInterestedIn setInputView:pickerViewType];
    
    [CommonUtility setTooBarOnTextfield:txtTimeZone withTargetId:self withActionEvent:@selector(gestureRecognizersTaped:)];
    [CommonUtility setTooBarOnTextfield:txtCountry withTargetId:self withActionEvent:@selector(gestureRecognizersTaped:)];
    [CommonUtility setTooBarOnTextfield:txtStateProvince withTargetId:self withActionEvent:@selector(gestureRecognizersTaped:)];
    [CommonUtility setTooBarOnTextfield:txtCity withTargetId:self withActionEvent:@selector(gestureRecognizersTaped:)];
    [CommonUtility setTooBarOnTextfield:txtInterestedIn withTargetId:self withActionEvent:@selector(gestureRecognizersTaped:)];
    
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== BUTTON ACTION EVENT CALLED HERE ===❉===❉
/*****************************************************************************************************************/

-(IBAction)btnBackItemClicked:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(IBAction)btnAgreeTermsTapped:(UIButton *)sender
{
    sender.selected = !sender.selected;
}
-(IBAction)btnUpdateCompulsoryTaped:(UIButton *)sender
{
    BOOL isValidate=TRUE;
    [self.view endEditing:YES];

        if ([Validation validateTextField:txtCompanyName])
        {
            [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Enter your Company Name..!"];
            return;
        }
        else if ([Validation validateTextField:txtPANNo])
        {
            [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Enter your PAN Number..!"];
            return;
        }
    
        else if ([Validation validateTextField:txtGSTIN])
        {
            [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Enter your GSTIN / Company Registeration Number..!"];
            return;
        }
        else if ([Validation validateTextField:txtTimeZone])
        {
            [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Enter your Time Zone..!"];
            return;
        }
        else if ([Validation validateTextField:txtCountry])
        {
            [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Select Your Country..!"];
            return;
        }
        else if ([Validation validateTextField:txtStateProvince])
        {
            [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Select Your State..!"];
            return;
        }
        else if ([Validation validateTextField:txtCity])
        {
            [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Select Your City..!"];
            return;
        }
        else if ([Validation validateTextField:txtInterestedIn])
        {
            [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Select which you are Interested IN..!"];
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
    
                BuyerUserDetail *objBuyerdetail = [MBDataBaseHandler getBuyerUserDetail];
                
                NSMutableDictionary *dicParams = [[NSMutableDictionary alloc]init];
                [dicParams setValue:API_DEFAULT_TOKEN forKey:@"Token"];
                [dicParams setValue:objBuyerdetail.detail.CustomerID forKey:@"CustomerID"];
                [dicParams setValue:txtCompanyName.text forKey:@"CompanyName"];
                [dicParams setValue:txtPANNo.text forKey:@"CompanyPANNo"];
                [dicParams setValue:txtGSTIN.text forKey:@"CompanyGST"];
                [dicParams setValue:txtStateProvince.text forKey:@"StateMarginID"];
                [dicParams setValue:txtCity.text forKey:@"CityID"];
                [dicParams setValue:txtCountry.text forKey:@"Country"];
                [dicParams setValue:timeZoneID forKey:@"UserTimeZone"];
                [dicParams setValue:InterestedID forKey:@"InterestedIn"];
    
                MBCall_GetUpdateCompulsoryDetails(dicParams, ^(id response, NSString *error, BOOL status)
                {
                    if (status && ![[response valueForKey:@"success"]isEqual:@0])
                    {
                        NSLog(@"response == >%@",response);
                        [CommonUtility HideProgress];
                        
                        NSError* Error;
                        BuyerUserDetail *detail =[[BuyerUserDetail alloc]initWithDictionary:response error:&Error];
                        [MBDataBaseHandler saveCommonDataDetail:detail];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            RootViewController * rootVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RootViewController"];
                            [APP_DELEGATE setRootViewController:rootVC];
                        });
    
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
                [CommonUtility HideProgress];
            }
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
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSInteger newLength = txtPANNo.text.length - range.length + string.length;
    NSInteger intGSTLength = txtGSTIN.text.length - range.length + string.length;

    if (newLength > 10)
    {
        [txtPANNo resignFirstResponder];
        return YES;
    }
    else if (intGSTLength > 15)
    {
        [txtGSTIN resignFirstResponder];
        return YES;
    }
    else{
        return YES;
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [pickerViewType reloadAllComponents];
    
    if ([txtTimeZone isEditing])
    {
        if(arrTimeZone.count > 0)
        {
            [txtTimeZone setText:[arrTimeZone objectAtIndex:0]];
            timeZoneID = arrTimeZoneID.count > 0 ?[NSString stringWithFormat:@"%@",[arrTimeZoneID objectAtIndex:0]]:@"";
            [pickerViewType selectRow:0 inComponent:0 animated:YES];
        }
    }
    else if ([txtCountry isEditing])
    {
        if (arrCountry.count>0)
        {
            [txtCountry setText:[arrCountry objectAtIndex:0]];
            [pickerViewType selectRow:0 inComponent:0 animated:YES];
            [self getStateByCountryName:[arrCountry objectAtIndex:0]];
        }
    }
    else if ([txtStateProvince isEditing])
    {
        if (arrStateList.count>0)
        {
            [txtStateProvince setText:[arrStateList objectAtIndex:0]];
            [pickerViewType selectRow:0 inComponent:0 animated:YES];
            [self getCityByStateName:[arrStateList objectAtIndex:0]];
        }
        else{
            [txtStateProvince resignFirstResponder];
            [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please select a Country to get State list..!"];
        }
    }
    else if ([txtCity isEditing])
    {
        if (arrCityList.count > 0)
        {
            [txtCity setText:[arrCityList objectAtIndex:0]];
            [pickerViewType selectRow:0 inComponent:0 animated:YES];
        }
        else{
            [txtCity resignFirstResponder];
            [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please select a State to get City list..!"];
        }
    }
    else if ([txtInterestedIn isEditing])
    {
        if (arrInterestedIn.count > 0)
        {
            [txtInterestedIn setText:[arrInterestedIn objectAtIndex:0]];
            [pickerViewType selectRow:0 inComponent:0 animated:YES];
            InterestedID = arrInterestedID.count > 0 ?[NSString stringWithFormat:@"%@",[arrInterestedID objectAtIndex:0]]:@"";
        }
    }
}
-(void)gestureRecognizersTaped:(UITapGestureRecognizer *)gesture
{
    [self.view endEditing:YES];
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== GET DATA FROM SHARED INSTANCE HERE ===❉===❉
/******************************************************************************************************************/
-(void)getallCommonDataAPI
{
    arrTimeZone = [[NSMutableArray alloc]init];
    arrTimeZoneID = [[NSMutableArray alloc] init];
    for (NSDictionary *dicTimeValue in [SharedObject arrTimeZone])
    {
        [arrTimeZone addObject:[dicTimeValue valueForKey:@"DisplayName"]];
        [arrTimeZoneID addObject:[dicTimeValue valueForKey:@"Id"]];
    }
    arrCountry = [[NSMutableArray alloc]init];
    for (NSDictionary *dicCountry in [SharedObject arrCountry])
    {
        [arrCountry addObject:[dicCountry valueForKey:@"CountryName"]];
    }
    arrInterestedIn = [[NSMutableArray alloc]init];
    arrInterestedID = [[NSMutableArray alloc]init];

    for (NSDictionary *dicBuyerInterest in [SharedObject arrBuyerInterestedIn])
    {
        [arrInterestedIn addObject:[dicBuyerInterest valueForKey:@"InterestedName"]];
        [arrInterestedID addObject:[dicBuyerInterest valueForKey:@"InterestedID"]];
    }
}

/******************************************************************************************************************/
#pragma mark ❉===❉===  GET ALL STATE  ACCORDING TO COUNRTY ID  HERE ===❉===❉
/******************************************************************************************************************/

-(void)getStateByCountryName:(NSString *)countryName
{
    if (SharedObject.isNetAvailable)
    {
        NSMutableDictionary *dicParams =[[NSMutableDictionary alloc]init];
        [dicParams setObject:API_DEFAULT_TOKEN forKey:@"Token"];
        [dicParams setObject:countryName forKey:@"CountryName"];
        
        MBCall_GetStateListWithCountryName(dicParams, ^(id response, NSString *error, BOOL status)
        {
            if (status)
            {
                if (response != (NSDictionary *)[NSNull null])
                {
                    NSMutableArray *arrValue = [[NSMutableArray alloc]init];
                    arrValue = [[response valueForKey:@"detail"] mutableCopy];
                    arrStateList = [[NSMutableArray alloc]init];
                    if (arrValue.count > 0 )
                    {
                        for (NSDictionary *dicStateValue in [response valueForKey:@"detail"])
                        {
                            [arrStateList addObject:[dicStateValue valueForKey:@"StateName"]];
                            [pickerViewType reloadAllComponents];
                            [pickerViewType reloadComponent:0];
                        }
                    }
                    else{
                        [arrStateList addObject:@"No Record Found"];
                    }
                    
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
/******************************************************************************************************************/
#pragma mark ❉===❉===  GET ALL CITY  ACCORDING TO STATE NAME  HERE ===❉===❉
/******************************************************************************************************************/

-(void)getCityByStateName:(NSString *)StateName
{
    if (SharedObject.isNetAvailable)
    {
        NSMutableDictionary *dicParams =[[NSMutableDictionary alloc]init];
        [dicParams setObject:API_DEFAULT_TOKEN forKey:@"Token"];
        [dicParams setObject:StateName forKey:@"StateName"];
        
        MBCall_GetCityListWithStateName(dicParams, ^(id response, NSString *error, BOOL status)
        {
            if (status)
            {
                if (response != (NSDictionary *)[NSNull null])
                {
                    arrCityList = [[NSMutableArray alloc]init];
                    NSMutableArray *arrValue = [[NSMutableArray alloc]init];
                     arrValue = [[response valueForKey:@"detail"] mutableCopy];
                    
                    if (arrValue.count > 0 )
                    {
                        for (NSDictionary *dicStateValue in [response valueForKey:@"detail"])
                        {
                            [arrCityList addObject:[dicStateValue valueForKey:@"CityName"]];
                            [pickerViewType reloadAllComponents];
                            [pickerViewType reloadComponent:0];
                        }
                    }
                    else{
                        [arrCityList addObject:@"No Record Found"];
                    }
                    
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
