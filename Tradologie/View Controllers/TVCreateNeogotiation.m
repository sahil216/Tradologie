//
//  TVCreateNeogotiation.m
//  Tradologie
//
//  Created by Chandresh Maurya on 31/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "TVCreateNeogotiation.h"
#import "Constant.h"
#import "MBDataBaseHandler.h"
#import "MBAPIManager.h"
#import "CommonUtility.h"
#import "SharedManager.h"

@interface TVCreateNeogotiation ()
{
    NegotiationDetail *objNegotiation;
    NSMutableArray *arrInspectionAgency;
    NSMutableArray *arrLocationDelivery;
    NSMutableArray *arrCurrency;
    NSMutableArray *arrInspectionID;
    NSMutableArray *arrAddressValue;
    NSMutableArray *arrCurrencyID;
    BOOL isOthers;
    UIDatePicker *ObjdatePicker;
    UIDatePicker *dateLastPicker;
    
    NSString *strInspectionID,*strAddressValue,*strCurrencyId;
    
}
@end

@implementation TVCreateNeogotiation

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setNavigationTittleWithLogo:@"Enter Negotiation Detail"];
    [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.navigationItem SetBackButtonWithID:self withSelectorAction:@selector(btnBackItemTaped:)];
    [self.tableView setBounces:NO];
    
    isOthers = false;
    [self getDataFromDB];
    
    [txtNegotiationName setDefaultTextfieldStyleWithPlaceHolder:@"Negotiation Name" withTag:10];
    
    [txtInspectionAgency setAdditionalInformationTextfieldStyle:@"--Select Inspection Agency--" Withimage:[UIImage imageNamed:@"IconDropDrown"] withID:self withSelectorAction:@selector(btnDropMethodTaped:) withTag:0];
    [txtLocationDelivery setAdditionalInformationTextfieldStyle:@"--Select Location of Delivery--" Withimage:[UIImage imageNamed:@"IconDropDrown"] withID:self withSelectorAction:@selector(btnDropMethodTaped:) withTag:1];
    [txtPaymentTerm setAdditionalInformationTextfieldStyle:@"--Select Payment term--" Withimage:[UIImage imageNamed:@"IconDropDrown"] withID:self withSelectorAction:@selector(btnDropMethodTaped:) withTag:2];
    
    [txtAgencyName setDefaultTextfieldStyleWithPlaceHolder:@"Agency Name" withTag:11];
    [txtAgencyAddress setDefaultTextfieldStyleWithPlaceHolder:@"Agency Address" withTag:12];
    [txtAgencyPhone setDefaultTextfieldStyleWithPlaceHolder:@"Agency Phone" withTag:13];
    [txtAgencyPhone setKeyboardType:UIKeyboardTypeNumberPad];
    [txtAgencyEmail setDefaultTextfieldStyleWithPlaceHolder:@"Agency Email" withTag:14];
    [txtAgencyEmail setKeyboardType:UIKeyboardTypeEmailAddress];
    
    [txtCurrency setAdditionalInformationTextfieldStyle:@"--Select Currency--" Withimage:[UIImage imageNamed:@"IconDropDrown"] withID:self withSelectorAction:@selector(btnDropMethodTaped:) withTag:3];
    [txtPartialDelivery setAdditionalInformationTextfieldStyle:@"--Select Partial Delivery--" Withimage:[UIImage imageNamed:@"IconDropDrown"] withID:self withSelectorAction:@selector(btnDropMethodTaped:) withTag:4];
    
    [txtPeferedDate setRightViewTextfieldStyleWithCalender:@"--Select preferred Date & Time--" Withimage:@"IconCalender" withTag:0];
    [txtLastDate setRightViewTextfieldStyleWithCalender:@"--Select Last Date of Dispatch--" Withimage:@"IconCalender" withTag:0];
    
    [txtTotlaQuality setDefaultTextfieldStyleWithPlaceHolder:@"Total Quality" withTag:15];
    [txtTotlaQuality setKeyboardType:UIKeyboardTypeNumberPad];
    [txtMinOrder setDefaultTextfieldStyleWithPlaceHolder:@"Min Order Quantity per Supplier" withTag:16];
    [txtMinOrder setKeyboardType:UIKeyboardTypeNumberPad];
    [txtDeliveryTerms setDefaultTextfieldStyleWithPlaceHolder:@"Enter Delivery terms" withTag:17];
    
    [self setDefaultToolbarAndDatePickerWithTextfield:txtPeferedDate];
    
    UITapGestureRecognizer *recoganize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnToolBarTapped:)];
    [recoganize setNumberOfTapsRequired:1];
    [self.tableView addGestureRecognizer:recoganize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointMake(0, -15);
    }
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== GET DATA From DB ===❉===❉
/*****************************************************************************************************************/
-(void)getDataFromDB
{
    objNegotiation = [MBDataBaseHandler getNegotiationDetailData];
    
    [lblReferenceCode setText:[NSString stringWithFormat:@"Negotiation Reference Code : %@",objNegotiation.detail.AuctionCode]];
    
    arrInspectionAgency = [[NSMutableArray alloc]init];
    arrLocationDelivery = [[NSMutableArray alloc]init];
    arrCurrency = [[NSMutableArray alloc]init];
    arrInspectionID = [[NSMutableArray alloc]init];
    arrAddressValue = [[NSMutableArray alloc]init];
    arrCurrencyID = [[NSMutableArray alloc]init];
    
    
    for (InspectionAgencyList *list in objNegotiation.detail.InspectionAgencyList)
    {
        [arrInspectionID addObject:list.InspectionAgencyID];
        [arrInspectionAgency addObject: list.InspectionCompanyName];
    }
    [arrInspectionAgency insertObject:@"Others" atIndex:arrInspectionAgency.count];
    [arrInspectionID insertObject:@0 atIndex:arrInspectionID.count];
    
    for (CustomerAddressList *list in objNegotiation.detail.CustomerAddressList)
    {
        [arrAddressValue addObject:list.AddressValue];
        [arrLocationDelivery addObject: list.Address];
    }
    for (CurrencyList *list in objNegotiation.detail.CurrencyList)
    {
        [arrCurrency addObject: list.CurrencyName];
        [arrCurrencyID addObject:list.CurrencyID];
    }
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== TABLEVIEW DELEGATE & DATA SOURCE CALLED HERE ===❉===❉
/*****************************************************************************************************************/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (isOthers)
    {
        return 70;
    }
    else if (indexPath.row == 2 || indexPath.row==3 || indexPath.row== 4 || indexPath.row==5)
    {
        return 0;
    }
    return 70;
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
    _viewFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    btnAddNegotiation = [[UIButton alloc]initWithFrame:_viewFooter.frame];
    [btnAddNegotiation setBackgroundColor:DefaultThemeColor];
    [btnAddNegotiation setTitle:@"Add Negotiation" forState:UIControlStateNormal];
    [btnAddNegotiation.titleLabel setFont:UI_DEFAULT_FONT_MEDIUM(18)];
    [btnAddNegotiation setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnAddNegotiation addTarget:self action:@selector(btnAddNegotiationCalled:) forControlEvents:UIControlEventTouchUpInside];
    [_viewFooter addSubview:btnAddNegotiation];
    return _viewFooter;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}

/******************************************************************************************************************/
#pragma mark ❉===❉===  BUTTON ACTION EVENT CALLED HERE ===❉===❉
/******************************************************************************************************************/

-(IBAction)btnBackItemTaped:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(IBAction)btnDropMethodTaped:(UIButton *)sender
{
    [self showPopUpWithData:sender];
}
-(IBAction)btnAddNegotiationCalled:(UIButton *)sender
{
    BOOL isValidate=TRUE;
    [self.view endEditing:YES];
    NSInteger value = [txtTotlaQuality.text integerValue];
    NSInteger MinOrder = [txtMinOrder.text integerValue];
    NSInteger precentage = (value * 30)/100;
    
    if ([Validation validateTextField:txtNegotiationName])
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Enter Negotiation Name..!"];
        return;
    }
    else if ([Validation validateTextField:txtInspectionAgency])
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Select a Inspection Agency..!"];
        return;
    }
    else if (isOthers)
    {
        if ([Validation validateTextField:txtAgencyName])
        {
            [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Enter Agency Name..!"];
            return;
        }
        else if ([Validation validateTextField:txtAgencyAddress])
        {
            [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Enter Agency Address..!"];
            return;
        }
        else if ([Validation validateTextField:txtAgencyPhone])
        {
            [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Enter Agency Number..!"];
            return;
        }
        else if ([Validation validateTextField:txtAgencyEmail])
        {
            [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Enter Agency Email..!"];
            return;
        }
    }
    else if ([Validation validateTextField:txtLocationDelivery])
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Select a Location for Delivery..!"];
        return;
    }
    else if ([Validation validateTextField:txtPaymentTerm])
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Select a Payment Term..!"];
        return;
    }
    else if ([Validation validateTextField:txtCurrency])
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Select a Currency..!"];
        return;
    }
    else if ([Validation validateTextField:txtPartialDelivery])
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Select a Partial Delivery..!"];
        return;
    }
    else if ([Validation validateTextField:txtPeferedDate])
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Select a Preffered Date & Time..!"];
        return;
    }
    else if ([Validation validateTextField:txtTotlaQuality])
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Enter Total Quality..!"];
        return;
    }
    else if (value < [objNegotiation.detail.MinAuctionQty integerValue])
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Total Quantity is less than minimum Quantity 20..!"];
        return;
    }
    else if ([Validation validateTextField:txtMinOrder])
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Enter Minimum Order Quantity as per Supplier..!"];
        return;
    }
    else if (MinOrder < precentage)
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Minimum Order Quantity can not be Less than 30% of Total Quantity..!"];
        return;
    }
    else if ([Validation validateTextField:txtLastDate])
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Select a Last Date for Dispatch..!"];
        return;
    }
    else if ([Validation validateTextField:txtDeliveryTerms])
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Please Enter Delivery Terms..!"];
        return;
    }
    if (isValidate)
    {
        BuyerUserDetail *objBuyerdetail = [MBDataBaseHandler getBuyerUserDetail];
        
        NSMutableDictionary *dicParams = [[NSMutableDictionary alloc]init];
        [dicParams setValue:objBuyerdetail.detail.APIVerificationCode forKey:@"Token"];
        [dicParams setValue:objBuyerdetail.detail.CustomerID forKey:@"CustomerID"];
        [dicParams setValue:objBuyerdetail.detail.UserTimeZone forKey:@"UserTimeZone"];
        [dicParams setValue:_strAuctionGroupID forKey:@"AuctionGroupID"];
        [dicParams setValue:@0 forKey:@"AuctionID"];
        [dicParams setValue:@"" forKey:@"BankerName"];
        [dicParams setValue:objNegotiation.detail.AuctionCode forKey:@"AuctionCode"];
        [dicParams setValue:txtNegotiationName.text forKey:@"AuctionName"];
        [dicParams setValue:strInspectionID forKey:@"InspectionAgency"];
        [dicParams setValue:txtAgencyName.text forKey:@"AgencyName"];
        [dicParams setValue:txtAgencyEmail.text forKey:@"AgencyEmail"];
        [dicParams setValue:txtAgencyAddress.text forKey:@"AgencyAddress"];
        [dicParams setValue:txtAgencyPhone.text forKey:@"AgencyPhone"];
        [dicParams setValue:strAddressValue forKey:@"DeliveryAddress"];
        [dicParams setValue:txtPaymentTerm.text forKey:@"PaymentTerm"];
        [dicParams setValue:strCurrencyId forKey:@"Currency"];
        [dicParams setValue:txtPartialDelivery.text forKey:@"PartialDelivery"];
        [dicParams setValue:txtPeferedDate.text forKey:@"AuctionStartDate"];
        [dicParams setValue:txtTotlaQuality.text forKey:@"TotalQuantity"];
        [dicParams setValue:txtMinOrder.text forKey:@"MinQuantity"];
        [dicParams setValue:txtLastDate.text forKey:@"DeliveryLastDate"];
        [dicParams setValue:txtDeliveryTerms.text forKey:@"Remarks"];
        
        if (SharedObject.isNetAvailable)
        {
            MBCall_AddUpdateAuctionforNegotiation(dicParams, ^(id response, NSString *error, BOOL status)
            {
                if (status && [[response valueForKey:@"success"]isEqual:@1])
                {
                    if (response != (NSDictionary *)[NSNull null])
                    {
                        
                        
                    }
                    else{
                        [CommonUtility HideProgress];
                    }
                }
                else
                {
                    [CommonUtility HideProgress];
                    [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:error];
                }
            });
        }
    }
    else
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Internet Not Available Please Try Again..!"];
    }
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== SHOW POPUP DATA HERE ===❉===❉
/******************************************************************************************************************/
-(void)showPopUpWithData:(UIView *)viewtoShow
{
    [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor colorWithRed:29.0f/255.0f green:65.0f/255.0f blue:106.0f/255.0f alpha:.30f]];
    
    if (viewtoShow.tag == 0)
    {
        [CommonUtility showPopUpWithData:viewtoShow withArray:arrInspectionAgency withCompletion:^(NSInteger response)
         {
             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
             NSString *strValue = [NSString stringWithFormat:@"%@",[arrInspectionAgency objectAtIndex:response]];
             [txtInspectionAgency setText:strValue];
             if ([strValue isEqualToString:[arrInspectionAgency lastObject]])
             {
                 isOthers = true;
                 strInspectionID = [NSString stringWithFormat:@"%@",[arrInspectionID lastObject]];
             }
             else
             {
                 isOthers = false;
                 strInspectionID = [NSString stringWithFormat:@"%@",[arrInspectionID objectAtIndex:response]];
             }
             [self.tableView reloadData];
             
         } withDismissBlock:^{
             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
         }];
    }
    else if (viewtoShow.tag == 1)
    {
        [CommonUtility showPopUpWithData:viewtoShow withArray:arrLocationDelivery withCompletion:^(NSInteger response)
         {
             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
             [txtLocationDelivery setText:[NSString stringWithFormat:@"%@",[arrLocationDelivery objectAtIndex:response]]];
             strAddressValue = [NSString stringWithFormat:@"%@",[arrAddressValue objectAtIndex:response]];
             [self.tableView reloadData];
         } withDismissBlock:^{
             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
         }];
    }
    else if (viewtoShow.tag == 2)
    {
        NSMutableArray *arrPayment = [[NSMutableArray alloc]initWithObjects:@"LC",@"ESCROW", nil];
        [CommonUtility showPopUpWithData:viewtoShow withArray:arrPayment withCompletion:^(NSInteger response)
         {
             [txtPaymentTerm setText:[NSString stringWithFormat:@"%@",[arrPayment objectAtIndex:response]]];
             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
             
             [self.tableView reloadData];
             
         } withDismissBlock:^{
             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
         }];
    }
    else if (viewtoShow.tag == 3)
    {
        [CommonUtility showPopUpWithData:viewtoShow withArray:arrCurrency withCompletion:^(NSInteger response)
         {
             [txtCurrency setText:[NSString stringWithFormat:@"%@",[arrCurrency objectAtIndex:response]]];
             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
             strCurrencyId = [NSString stringWithFormat:@"%@",[arrCurrencyID objectAtIndex:response]];

             [self.tableView reloadData];
             
         } withDismissBlock:^{
             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
         }];
    }
    else if (viewtoShow.tag == 4)
    {
        NSMutableArray *arrPartial = [[NSMutableArray alloc]initWithObjects:@"Allowed",@"Not Allowed", nil];
        
        [CommonUtility showPopUpWithData:viewtoShow withArray:arrPartial withCompletion:^(NSInteger response)
         {
             [txtPartialDelivery setText:[NSString stringWithFormat:@"%@",[arrPartial objectAtIndex:response]]];
             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
             
         } withDismissBlock:^{
             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
         }];
    }
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== SET TOOlBAR WITH TEXTFIELD ===❉===❉
/*****************************************************************************************************************/
-(void)setDefaultToolbarAndDatePickerWithTextfield:(UITextField *)txtdate
{
    ObjdatePicker = [[UIDatePicker alloc]init];
    [ObjdatePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    [ObjdatePicker setMinimumDate:[NSDate date]];
    [ObjdatePicker addTarget:self action:@selector(dateTextField:) forControlEvents:UIControlEventValueChanged];
    [ObjdatePicker setValue:DefaultThemeColor forKeyPath:@"textColor"];
    [ObjdatePicker setBackgroundColor:DefaultThemeColor];
    [txtdate setInputView:ObjdatePicker];
    
    //**************************************TOOL BAR ADDED ****************************************
    [CommonUtility setTooBarOnTextfield:txtdate withTargetId:self withActionEvent:@selector(btnToolBarTapped:)];
}
-(void)dateTextField:(id)sender
{
    [self checkTimeAccordingtoDate];
}
-(void)checkTimeAccordingtoDate
{
    NSDate *selectedDate;
    NSTimeInterval timeDifference = [ObjdatePicker.date timeIntervalSinceDate:[NSDate date]];
    double minutes = timeDifference / 60;
    
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    [fmt setMaximumFractionDigits:0];
    
    NSLog(@"%@", [fmt stringFromNumber:[NSNumber numberWithFloat:minutes]]);
    
    if (minutes < 15)
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Preffered Date & time for Negotiation Would be Greater than 15 minutes from Current date & time ..!"];
        return;
    }
    else
    {
        selectedDate = ObjdatePicker.date;
        [selectedDate descriptionWithLocale: [NSLocale currentLocale]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];

        NSString *datestring = [dateFormatter stringFromDate:selectedDate];
        [txtPeferedDate setText:datestring];
    }
}
-(IBAction)btnToolBarTapped:(UIButton *)sender
{
    [self.view endEditing:YES];
}
-(void)dateSelected:(id)sender
{
    NSDate *selectedDate;
    selectedDate = dateLastPicker.date;
    [selectedDate descriptionWithLocale: [NSLocale currentLocale]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    
    NSString *datestring = [dateFormatter stringFromDate:selectedDate];
    [txtLastDate setText:datestring];
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== TEXTFIELD DELEGATE CALLED HERE ===❉===❉
/*****************************************************************************************************************/
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField== txtLastDate && [txtLastDate isEditing])
    {
        dateLastPicker = [[UIDatePicker alloc]init];
        [dateLastPicker setDatePickerMode:UIDatePickerModeDateAndTime];
        
        NSDate *startdate = [NSDate dateWithDaysFromNow:[objNegotiation.detail.MinDaysDiffDeliveryLastDate integerValue]];
        
        NSDate *Enddate = [NSDate dateWithDaysFromNow:[objNegotiation.detail.MaxDaysDiffDeliveryLastDate integerValue]];
        
        [dateLastPicker setMinimumDate:startdate];
        [dateLastPicker setMaximumDate:Enddate];
        [dateLastPicker addTarget:self action:@selector(dateSelected:) forControlEvents:UIControlEventValueChanged];
        [dateLastPicker setValue:DefaultThemeColor forKeyPath:@"textColor"];
        [txtLastDate setInputView:dateLastPicker];
        [CommonUtility setTooBarOnTextfield:txtLastDate withTargetId:self withActionEvent:@selector(btnToolBarTapped:)];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField.placeholder isEqualToString:@"--Select Inspection Agency--"])
    {
        [self showPopUpWithData:textField];
        [textField resignFirstResponder];
        return NO;
    }
    else if ([textField.placeholder isEqualToString:@"--Select Location of Delivery--"])
    {
        [self showPopUpWithData:textField];
        [textField resignFirstResponder];
        return NO;
    }
    else if ([textField.placeholder isEqualToString:@"--Select Payment term--"])
    {
        [self showPopUpWithData:textField];
        [textField resignFirstResponder];
        return NO;
    }
    else if ([textField.placeholder isEqualToString:@"--Select Currency--"])
    {
        [self showPopUpWithData:textField];
        [textField resignFirstResponder];
        return NO;
    }
    else if ([textField.placeholder isEqualToString:@"--Select Partial Delivery--"])
    {
        [self showPopUpWithData:textField];
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
    
}
@end
