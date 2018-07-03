//
//  TVPaymentScreen.m
//  Tradologie
//
//  Created by Chandresh Maurya on 28/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "TVPaymentScreen.h"
#import "Constant.h"
#import "CommonUtility.h"
#import "VcEnquiryRequestScreen.h"
#import "MBDataBaseHandler.h"
#import "SharedManager.h"
#import "MBAPIManager.h"

@interface TVPaymentScreen ()<TVPaymentPolicyDetailCellDelegate,UITextFieldDelegate>
{
    BOOL customerIsCollapsed;
    BOOL siteIsCollapsed;
    NSMutableDictionary *dicDetailCharges;
    NSMutableDictionary *dicValueData;
}
@end

@implementation TVPaymentScreen

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setNavigationTittleWithLogo:@"Negotiation Charge Payment"];
    [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
    [self.navigationItem SetBackButtonWithID:self withSelectorAction:@selector(btnBackPayment:)];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
    customerIsCollapsed = NO;
    siteIsCollapsed = NO;
    
    dicValueData = [[NSMutableDictionary alloc]init];
    
    [self AddAuctionSupplierWithNegotiationCustomerIdAPI:_strAuctionID];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivePaymentType:)
                                                 name:@"SelectedPaymentType"
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/******************************************************************************************************************/
#pragma mark ❉===❉=== TABLEVIEW DATASOURCE & DELEGATE ❉===❉===
/*****************************************************************************************************************/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 1)
    {
        if(customerIsCollapsed)
            return 1;
        else
            return 0;
    }
    else if (section == 2)
    {
        if(siteIsCollapsed)
            return 8;
        else
            return 0;
        
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cell_ID = @"";
    
    if (indexPath.section == 1)
    {
        Cell_ID = @"Cell_Id_Payment";
        TVPaymentCell *cell = (TVPaymentCell *) [tableView dequeueReusableCellWithIdentifier:Cell_ID];
        
        if (!cell)
        {
            cell = [[TVPaymentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:Cell_ID];
        }
        if  (dicDetailCharges != nil)
        {
            [cell ConfigurePaymentCellwithData:dicDetailCharges];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell;
    }
    else if (indexPath.section == 2)
    {
        if (indexPath.row == 0)
        {
            Cell_ID = @"Cell_Id_BankDetail";
            TVPaymentBankDetailCell *cell = (TVPaymentBankDetailCell *) [tableView dequeueReusableCellWithIdentifier:Cell_ID];
            
            if (!cell)
            {
                cell = [[TVPaymentBankDetailCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                      reuseIdentifier:Cell_ID];
            }
            if  (dicDetailCharges != nil)
            {
                NSString *strTotalValue = [NSString stringWithFormat:@"%@.0  %@",[dicDetailCharges valueForKey:@"BuyerAuctionCharge"],[dicDetailCharges valueForKey:@"CurrencyCode"]];
                [cell ConfigurePaymentBankDetailCellwithData:strTotalValue];
            }
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            return cell;
        }
        else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6)
        {
            static NSString * Cell_IDENTIFIER = @"Cell_Id_PaymentDetail";
            TVPaymentDetailCell *cell = (TVPaymentDetailCell *) [tableView dequeueReusableCellWithIdentifier:Cell_IDENTIFIER];
            
            if (!cell)
            {
                cell = [[TVPaymentDetailCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                  reuseIdentifier:Cell_IDENTIFIER];
            }
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell ConfigurePaymentDetailCellWithData:@"" withIndex:indexPath];
            return cell;
        }
        else{
            
            static NSString * Cell_IDENTIFIER = @"Cell_Id_Tradepolicy";
            TVPaymentPolicyDetail *cell = (TVPaymentPolicyDetail *) [tableView dequeueReusableCellWithIdentifier:Cell_IDENTIFIER];
            
            if (!cell)
            {
                cell = [[TVPaymentPolicyDetail alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:Cell_IDENTIFIER];
            }
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell ConfigurePaymentPolicyDetailwithData:@""];
            [cell setDelegate:self];
            return cell;
        }
    }
    
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 90)];
        [headerView setBackgroundColor:GET_COLOR_WITH_RGB(240, 244, 244, 1)];
        NSString *strNegotiationCode = [NSString stringWithFormat:@"Negotiation Code: %@",[dicDetailCharges valueForKey:@"AuctionCode"]];
        [self getLableAccordingtoView:headerView withTittle:strNegotiationCode withFrame:CGRectMake(5, 0,SCREEN_WIDTH-10, 45) withSize:16 withTextColor:DefaultThemeColor withAlignment:NSTextAlignmentLeft ];
        NSString *strNegotiationName = [NSString stringWithFormat:@"Negotiation Name: %@",[dicDetailCharges valueForKey:@"AuctionName"]];
        [self getLableAccordingtoView:headerView withTittle:strNegotiationName withFrame:CGRectMake(5, 45,SCREEN_WIDTH-10, 45) withSize:16 withTextColor:DefaultThemeColor withAlignment:NSTextAlignmentLeft];
        
        return headerView;
    }
    UIView *Viewsection2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    [Viewsection2 setBackgroundColor:[UIColor clearColor]];
    UIView *ViewHeader = [[UIView alloc]initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH - 10, 90)];
    [CommonUtility GetShadowWithBorder:ViewHeader];
    [ViewHeader setBackgroundColor:DefaultThemeColor];
    [ViewHeader.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    
    
    if(section == 1)
    {
        [self getLableAccordingtoView:ViewHeader withTittle:@"ONLINE (Credit Card/ Debit Card/ Net Banking)" withFrame:CGRectMake(5, 0,ViewHeader.frame.size.width - 10, 50) withSize:18 withTextColor:[UIColor whiteColor] withAlignment:NSTextAlignmentLeft];
        if  (dicDetailCharges != nil)
        {
            NSString *strTotalValue = [NSString stringWithFormat:@"%@.0  %@",[dicDetailCharges valueForKey:@"TotalCharge"],[dicDetailCharges valueForKey:@"CurrencyCode"]];
            
            [self getLableAccordingtoView:ViewHeader withTittle:(strTotalValue )?strTotalValue:@"" withFrame:CGRectMake(ViewHeader.frame.size.width - 210, 55,200, 30) withSize:18 withTextColor:[UIColor whiteColor] withAlignment:NSTextAlignmentRight];
        }
        
        if(!customerIsCollapsed)
        {
            
        }
        else
        {
            
        }
    }
    else if(section == 2)
    {
        [self getLableAccordingtoView:ViewHeader withTittle:@"OFFLINE (Cheque/ DD/ Wire Transfer)" withFrame:CGRectMake(5, 0,ViewHeader.frame.size.width - 10, 50) withSize:18 withTextColor:[UIColor whiteColor] withAlignment:NSTextAlignmentLeft];
        if  (dicDetailCharges != nil)
        {
            NSString *strTotalValue = [NSString stringWithFormat:@"%@.0  %@",[dicDetailCharges valueForKey:@"BuyerAuctionCharge"],[dicDetailCharges valueForKey:@"CurrencyCode"]];
            
            [self getLableAccordingtoView:ViewHeader withTittle:(strTotalValue )?strTotalValue:@"" withFrame:CGRectMake(ViewHeader.frame.size.width - 210, 55,200, 30) withSize:18 withTextColor:[UIColor whiteColor] withAlignment:NSTextAlignmentRight];
        }
        
        if(!siteIsCollapsed)
        {
            
        }
        else
        {
            
        }
        
    }
    UIButton *btnCollapse = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCollapse setFrame:CGRectMake(0, 0, ViewHeader.frame.size.width, Viewsection2.frame.size.height)];
    [btnCollapse setBackgroundColor:[UIColor clearColor]];
    [btnCollapse addTarget:self action:@selector(touchedSection:) forControlEvents:UIControlEventTouchUpInside];
    btnCollapse.tag = section;
    
    [ViewHeader addSubview:btnCollapse];
    [Viewsection2 addSubview:ViewHeader];
    
    return Viewsection2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        return 250;
    }
    else if (indexPath.section == 2)
    {
        if (indexPath.row == 0)
        {
            return 180;
        }
        else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6)
        {
            return 65;
        }
        return 180;
    }
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 100;
    }
    return 110;
}

/******************************************************************************************************************/
#pragma mark ❉===❉=== GET LABLE FOR HEADER HERE ===❉===❉
/*****************************************************************************************************************/

-(void)getLableAccordingtoView:(UIView *)viewBG withTittle:(NSString *)strTittle withFrame:(CGRect)frame withSize:(NSInteger)fontSize withTextColor:(UIColor *)color withAlignment:(NSTextAlignment )align
{
    UILabel *lblbHeaderTittle= [[UILabel alloc]initWithFrame:frame];
    [lblbHeaderTittle setText:strTittle];
    [lblbHeaderTittle setFont:UI_DEFAULT_FONT_MEDIUM(fontSize)];
    [lblbHeaderTittle setTextColor:color];
    [lblbHeaderTittle setTextAlignment:align];
    [lblbHeaderTittle setBackgroundColor:[UIColor clearColor]];
    [lblbHeaderTittle setNumberOfLines:0];
    [lblbHeaderTittle setLineBreakMode:NSLineBreakByWordWrapping];
    [viewBG addSubview:lblbHeaderTittle];
}

/******************************************************************************************************************/
#pragma mark ❉===❉=== GET AUCTION CHARGES DETAIL API CALLED HERE ===❉===❉
/*****************************************************************************************************************/
-(void)AddAuctionSupplierWithNegotiationCustomerIdAPI:(NSString *)strAuctionID
{
    BuyerUserDetail *objBuyerdetail = [MBDataBaseHandler getBuyerUserDetail];
    
    NSMutableDictionary *dicParams = [[NSMutableDictionary alloc]init];
    [dicParams setValue:objBuyerdetail.detail.APIVerificationCode forKey:@"Token"];
    [dicParams setValue:strAuctionID forKey:@"AuctionID"];
    
    if (SharedObject.isNetAvailable)
    {
        [CommonUtility showProgressWithMessage:@"Please Wait.."];
        
        MBCall_AuctionChargesDetailAPI(dicParams, ^(id response, NSString *error, BOOL status)
        {
            [CommonUtility HideProgress];
            
            self->dicDetailCharges  = [[NSMutableDictionary alloc]init];
            
            if (status && [[response valueForKey:@"success"]isEqual:@1])
            {
                if (response != (NSDictionary *)[NSNull null])
                {
                    for (NSMutableDictionary *dicValue in [response objectForKey:@"detail"])
                    {
                        self->dicDetailCharges = dicValue;
                        NSLog(@"%@",self->dicDetailCharges);
                    }
                    [self.tableView reloadData];
                }
            }
            else
            {
                [CommonUtility HideProgress];
                [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:error];
            }
        });
    }
    else
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Internet Not Available Please Try Again..!"];
    }
}

/******************************************************************************************************************/
#pragma mark ❉===❉=== BUTTON ACTION EVENT CALLED HERE===❉===❉
/*****************************************************************************************************************/

- (IBAction)touchedSection:(id)sender
{
    UIButton *btnSection = (UIButton *)sender;
    
    NSInteger section = btnSection.tag;
    
    if(btnSection.tag == 1)
    {
        NSLog(@"Touched Customers header");
        if(!customerIsCollapsed)
        {
            customerIsCollapsed = YES;
            [self reloadTableInputViewsWithSection:section];
        }
        else
        {
            customerIsCollapsed = NO;
            [self reloadTableInputViewsWithSection:section];
        }
        
    }
    else if(btnSection.tag == 2)
    {
        NSLog(@"Touched Site header");
        if(!siteIsCollapsed)
        {
            siteIsCollapsed = YES;
            [self reloadTableInputViewsWithSection:section];
        }
        else
        {
            siteIsCollapsed = NO;
            [self reloadTableInputViewsWithSection:section];
        }
    }
}
-(IBAction)btnBackPayment:(UIButton *)sender
{
    VcEnquiryRequestScreen *requestSc=[self.storyboard instantiateViewControllerWithIdentifier:@"VcEnquiryRequestScreen"];
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationLandscapeRight] forKey:@"orientation"];
    [self.navigationController pushViewController:requestSc animated:YES];
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== RELOAD DATA HERE ===❉===❉
/*****************************************************************************************************************/
-(void)reloadTableInputViewsWithSection:(NSInteger )section
{
    [self.tableView beginUpdates];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== TEXTFIELD DELEGATE CALLED HERE ===❉===❉
/*****************************************************************************************************************/
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag == 1001)
    {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 1002)
    {
        [dicValueData setValue:textField.text forKey:@"ChequeNo"];
        NSLog(@"%@",textField.text);
    }
    else if (textField.tag == 1003)
    {
        [dicValueData setValue:textField.text forKey:@"BankName"];
        NSLog(@"%@",textField.text);
    }
    else if (textField.tag == 1004)
    {
        [dicValueData setValue:textField.text forKey:@"IFSCode"];
        NSLog(@"%@",textField.text);
    }
    else if (textField.tag == 1005)
    {
        [dicValueData setValue:textField.text forKey:@"Remarks"];
        NSLog(@"%@",textField.text);
    }
    else if (textField.tag == 1006)
    {
        [dicValueData setValue:textField.text forKey:@"ChequeDate"];
        NSLog(@"%@",textField.text);
    }
}

-(void)receivePaymentType:(NSNotification *)notification
{
    NSString *strPaymentType = [NSString stringWithFormat:@"%@",notification.object];
    [dicValueData setValue:strPaymentType forKey:@"PaymentType"];
}

/******************************************************************************************************************/
#pragma mark ❉===❉=== CELL DELEGATE CALLED HERE ===❉===❉
/*****************************************************************************************************************/
-(void)setPaymentInformationDetailWithData:(UIButton *)sender
{
    BuyerUserDetail *objBuyerdetail = [MBDataBaseHandler getBuyerUserDetail];
    [dicValueData setValue:objBuyerdetail.detail.APIVerificationCode forKey:@"Token"];
    [dicValueData setValue:objBuyerdetail.detail.CustomerID forKey:@"CustomerID"];
    [dicValueData setValue:_strAuctionID forKey:@"AuctionID"];
    NSNumber * AuctionCharge  = [NSNumber numberWithInteger:[[dicDetailCharges valueForKey:@"BuyerAuctionCharge"]intValue]];
    [dicValueData setValue:AuctionCharge forKey:@"AuctionCharge"];
    
    if (SharedObject.isNetAvailable)
    {
        [CommonUtility showProgressWithMessage:@"Please Wait.."];
        
        MBCall_AuctionOffLinePaymentWithCustomerIdAPI(dicValueData, ^(id response, NSString *error, BOOL status)
        {
            [CommonUtility HideProgress];
            
            self->dicDetailCharges  = [[NSMutableDictionary alloc]init];
            
            if (status && [[response valueForKey:@"success"]isEqual:@1])
            {
                if (response != (NSDictionary *)[NSNull null])
                {
                    VcEnquiryRequestScreen *requestSc=[self.storyboard instantiateViewControllerWithIdentifier:@"VcEnquiryRequestScreen"];
                    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationLandscapeRight] forKey:@"orientation"];
                    [self.navigationController pushViewController:requestSc animated:YES];
                }
            }
            else
            {
                [CommonUtility HideProgress];
                [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:error];
            }
        });
    }
    else
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Internet Not Available Please Try Again..!"];
    }
}
@end



/******************************************************************************************************************/
#pragma mark ❉===❉=== TABLEVIEW CELL METHOD CALLED HERE ===❉===❉
/*****************************************************************************************************************/

@implementation TVPaymentCell

-(void)awakeFromNib
{
    [super awakeFromNib];
}
- (void)ConfigurePaymentCellwithData:(NSMutableDictionary *)dicValue
{
    [_btnPayment setDefaultButtonShadowStyle:DefaultThemeColor];
    [_btnPayment.titleLabel setFont:UI_DEFAULT_FONT_BOLD(16)];
    [_btnPayment addTarget:self action:@selector(btnPaymentMethodTapped:) forControlEvents:UIControlEventTouchUpInside];
    [_btnAccept addTarget:self action:@selector(btnAcceptCalled:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *strRefundValue = [NSString stringWithFormat:@":-  %@.0  %@",[dicValue valueForKey:@"BuyerAuctionCharge"],[dicValue valueForKey:@"CurrencyCode"]];
    [self.lblRefundPayment setText:strRefundValue];
    
    NSString *strConvienceValue = [NSString stringWithFormat:@":-  %@.0  %@",[dicValue valueForKey:@"ConvenienceCharge"],[dicValue valueForKey:@"CurrencyCode"]];
    [self.lblConvienceFees setText:strConvienceValue];
    
    NSString *strTotalValue = [NSString stringWithFormat:@":-  %@.0  %@",[dicValue valueForKey:@"TotalCharge"],[dicValue valueForKey:@"CurrencyCode"]];
    [self.lblTotalCharges setText:strTotalValue];
}

/******************************************************************************************************************/
#pragma mark ❉===❉===  BUTTON ACTION EVENT CALLED HERE ===❉===❉
/******************************************************************************************************************/
-(IBAction)btnPaymentMethodTapped:(UIButton *)sender
{
    
}
-(IBAction)btnAcceptCalled:(UIButton *)sender
{
    sender.selected = !sender.selected;
}
@end

/******************************************************************************************************************/
#pragma mark ❉===❉=== TABLEVIEW CELL METHOD CALLED HERE ===❉===❉
/*****************************************************************************************************************/

@implementation TVPaymentBankDetailCell

-(void)awakeFromNib
{
    [super awakeFromNib];
}
- (void)ConfigurePaymentBankDetailCellwithData:(NSString *)strValue
{
    [self.lblRefundAmount setText:[@"Refundable Deposit : -   " stringByAppendingString:strValue]];
}

@end

/******************************************************************************************************************/
#pragma mark ❉===❉=== TABLEVIEW CELL METHOD CALLED HERE ===❉===❉
/*****************************************************************************************************************/

@implementation TVPaymentDetailCell

-(void)awakeFromNib
{
    [super awakeFromNib];
}
- (void)ConfigurePaymentDetailCellWithData:(NSString *)strValue withIndex:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1)
    {
        [_txtBankName setAdditionalInformationTextfieldStyle:@"Select Payment Mode" Withimage:IMAGE(@"IconDropDrown")  withID:self withSelectorAction:@selector(btnDropDownTapped:) withTag:1001];
        [_txtBankName setValue:DefaultThemeColor forKeyPath:@"_placeholderLabel.textColor"];
        
    }
    else if (indexPath.row == 2)
    {
        [_txtBankName setRightViewTextfieldStyle:@"Cheque/DD/Transaction No" Withimage:@"" withTag:1002];
        [_txtBankName setKeyboardType:UIKeyboardTypeNumberPad];
        [CommonUtility setTooBarOnTextfield:_txtBankName withTargetId:self withActionEvent:@selector(btnToolBarTapped:)];
    }
    else if (indexPath.row == 3)
    {
        [_txtBankName setRightViewTextfieldStyle:@"Your Bank Name" Withimage:@"" withTag:1003];
    }
    else if (indexPath.row == 4)
    {
        [_txtBankName setRightViewTextfieldStyle:@"RTGS/NEFT IFSC Code" Withimage:@"" withTag:1004];
    }
    else if (indexPath.row == 5)
    {
        [_txtBankName setRightViewTextfieldStyle:@"Remark's" Withimage:@"" withTag:1005];
    }
    else if (indexPath.row == 6)
    {
        [_txtBankName setRightViewTextfieldStyle:@"Cheque/DD/Transaction Date *" Withimage:@"" withTag:1006];
        _ObjdatePicker = [[UIDatePicker alloc]init];
        [_ObjdatePicker setDatePickerMode:UIDatePickerModeDateAndTime];
        [_ObjdatePicker setMinimumDate:[NSDate date]];
        [_ObjdatePicker addTarget:self action:@selector(dateTextField:) forControlEvents:UIControlEventValueChanged];
        [_ObjdatePicker setValue:DefaultThemeColor forKeyPath:@"textColor"];
        [_txtBankName setInputView:_ObjdatePicker];
        
        //**************************************TOOL BAR ADDED ****************************************
        [CommonUtility setTooBarOnTextfield:_txtBankName withTargetId:self withActionEvent:@selector(btnToolBarTapped:)];
    }
}
-(void)dateTextField:(UIDatePicker *)sender
{
    [self checkTimeAccordingtoDate];
}

-(void)checkTimeAccordingtoDate
{
    NSDate *selectedDate = _ObjdatePicker.date;
    [selectedDate descriptionWithLocale: [NSLocale currentLocale]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    
    NSString *datestring = [dateFormatter stringFromDate:selectedDate];
    [_txtBankName setText:datestring];
}

-(IBAction)btnToolBarTapped:(UIButton *)sender
{
    [self.contentView endEditing:YES];
}
/******************************************************************************************************************/
#pragma mark ❉===❉===  BUTTON ACTION EVENT CALLED HERE ===❉===❉
/******************************************************************************************************************/
-(IBAction)btnDropDownTapped:(UIButton *)sender
{
    NSMutableArray *arrPayemtnMethod = [[NSMutableArray alloc]initWithObjects:@"Cheque",@"DD",@"Transaction",nil];
    
    if (_txtBankName.tag == 1001)
    {
        [CommonUtility showPopUpWithData:sender withArray:arrPayemtnMethod withCompletion:^(NSInteger response)
        {
            [self->_txtBankName setText:[arrPayemtnMethod objectAtIndex:response]];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"SelectedPaymentType" object:self->_txtBankName.text];
        } withDismissBlock:^{
            [self.contentView endEditing:YES];
        }];
    }
}
@end

/******************************************************************************************************************/
#pragma mark ❉===❉=== TABLEVIEW CELL METHOD CALLED HERE ===❉===❉
/*****************************************************************************************************************/

@implementation TVPaymentPolicyDetail

-(void)awakeFromNib
{
    [super awakeFromNib];
}
- (void)ConfigurePaymentPolicyDetailwithData:(NSString *)strValue
{
    [_btnSubmit setDefaultButtonShadowStyle:DefaultThemeColor];
    [_btnSubmit.titleLabel setFont:UI_DEFAULT_FONT_BOLD(18)];
    [_btnSubmit addTarget:self action:@selector(btnSubmitPaymentTapped:) forControlEvents:UIControlEventTouchUpInside];
    [_btnAccept addTarget:self action:@selector(btnAcceptCalled:) forControlEvents:UIControlEventTouchUpInside];
    
}
/******************************************************************************************************************/
#pragma mark ❉===❉===  BUTTON ACTION EVENT CALLED HERE ===❉===❉
/******************************************************************************************************************/
-(IBAction)btnSubmitPaymentTapped:(UIButton *)sender
{
    if([_delegate respondsToSelector:@selector(setPaymentInformationDetailWithData:)])
    {
        [_delegate setPaymentInformationDetailWithData:sender];
    }
}
-(IBAction)btnAcceptCalled:(UIButton *)sender
{
    sender.selected = !sender.selected;
}


@end
