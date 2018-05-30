//
//  VCAddNegotiation.m
//  Tradologie
//
//  Created by Chandresh Maurya on 26/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "VCAddNegotiation.h"
#import "Constant.h"
#import "CommonUtility.h"
#import "MBAPIManager.h"
#import "SharedManager.h"
#import "MBDataBaseHandler.h"


@interface VCAddNegotiation ()<SupplierCellDelegate>
{
    UILabel *lblMessage;
    UIButton *btnRight;
    NSMutableArray *arrCategoryList;
    NSMutableArray *arrCategoryID;
    NSMutableArray *arrSupplierList;
    NSMutableArray *arr_Is_shortlisted;
    NSString *selectedCategoryID;
    
}
@end

@implementation VCAddNegotiation

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tbtNegotiation setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.navigationItem setNavigationTittleWithLogo:@"tradologie.com"];
    lblMessage = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, 50)];
    [lblMessage setText:@"No Supplier Found..!"];
    [lblMessage setTextAlignment:NSTextAlignmentCenter];
    [lblMessage setHidden:YES];
    [self.tbtNegotiation setBackgroundView:lblMessage];
    
    [txtCategory setAdditionalInformationTextfieldStyle:@"--Select One Category--" Withimage:[UIImage imageNamed:@"IconDropDrown"] withID:self withSelectorAction:@selector(btnDropTaped:) withTag:0];
    [txtCategory setFont:UI_DEFAULT_FONT(17)];
    
    
    [btnContactUs addTarget:self action:@selector(btnContactUsTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self GetCategoryListForNegotiation];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return (arrSupplierList.count > 0)?arrSupplierList.count:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (arrSupplierList.count > 0)
    {
        SupplierCell *cell = (SupplierCell *) [tableView dequeueReusableCellWithIdentifier:COMMON_CELL_ID];
        if (!cell)
        {
            cell = [[SupplierCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:COMMON_CELL_ID];
        }
        [cell ConfigureSupplierCellwithData:[arrSupplierList objectAtIndex:indexPath.row] withIsselected:(arr_Is_shortlisted.count > 0)?[[arr_Is_shortlisted objectAtIndex:indexPath.row] boolValue]:false];
        cell.delegate = self;
        return cell;
    }
    
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 210;
}
/******************************************************************************************************************/
#pragma mark ❉===❉===  BUTTON ACTION EVENT CALLED HERE ===❉===❉
/******************************************************************************************************************/

-(IBAction)btnContactUsTapped:(UIButton *)sender
{
    [self getContactDialNumber];
}
-(IBAction)btnDropTaped:(UIButton *)sender
{
    [self showPopUpWithData:sender];
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== SHOW POPUP DATA HERE ===❉===❉
/******************************************************************************************************************/
-(void)showPopUpWithData:(UIView *)viewtoShow
{
    [lblMessage setHidden:YES];
    FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
    configuration.menuRowHeight = 45;
    configuration.menuWidth = SCREEN_WIDTH-20;
    configuration.textColor = [UIColor whiteColor];
    configuration.textFont = UI_DEFAULT_FONT_MEDIUM(16);
    configuration.tintColor = [UIColor whiteColor];
    configuration.borderColor = [UIColor whiteColor];
    configuration.borderWidth = 2.0f;
    configuration.menuIconMargin = 6;
    configuration.ignoreImageOriginalColor = YES;
    configuration.allowRoundedArrow = YES;
    
    [FTPopOverMenu showForSender:viewtoShow
                   withMenuArray:arrCategoryList
                      imageArray:nil
                       doneBlock:^(NSInteger selectedIndex)
    {
        
        [txtCategory setText:[arrCategoryList objectAtIndex:selectedIndex]];
        selectedCategoryID = [NSString stringWithFormat:@"%@",[arrCategoryID objectAtIndex:selectedIndex]];
        [self getSupplierListAccordingtoCategoryID:[arrCategoryID objectAtIndex:selectedIndex]];
        
    } dismissBlock:^{
        
    }];
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== GET ALL CATEGORY API CALLED HERE ===❉===❉
/******************************************************************************************************************/
-(void)GetCategoryListForNegotiation
{
    if (SharedObject.isNetAvailable)
    {
        MBCall_GetCategoryListForNegotiation(^(id response, NSString *error, BOOL status)
        {
            arrCategoryList = [[NSMutableArray alloc]init];
            arrCategoryID = [[NSMutableArray alloc]init];
            
            if (status && [[response valueForKey:@"success"]isEqual:@1])
            {
                if (response != (NSDictionary *)[NSNull null])
                {
                    //   NSError* Error;
                    //   ProductCategory *objProduct = [[ProductCategory alloc]initWithDictionary:response error:&Error];
                    //   [MBDataBaseHandler saveProductCategoryDetail:objProduct];
                    
                    for (NSMutableDictionary *dic in [response valueForKey:@"detail"])
                    {
                        [arrCategoryID addObject:[dic valueForKey:@"GroupID"]];
                        [arrCategoryList addObject:[dic valueForKey:@"GroupName"]];
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
#pragma mark ❉===❉=== GET ALL CATEGORY API CALLED HERE ===❉===❉
/******************************************************************************************************************/
-(void)getSupplierListAccordingtoCategoryID:(NSString *)GroupID
{
    BuyerUserDetail *objBuyerdetail = [MBDataBaseHandler getBuyerUserDetail];
    
    NSMutableDictionary *dicParams = [[NSMutableDictionary alloc]init];
    [dicParams setValue:GroupID forKey:@"categoryID"];
    [dicParams setValue:objBuyerdetail.detail.CustomerID forKey:@"CustomerID"];
    
    if (SharedObject.isNetAvailable)
    {
        [CommonUtility showProgressWithMessage:@"Please Wait.."];
        
        MBCall_GetSuplierlistWithCategoryID(dicParams, ^(id response, NSString *error, BOOL status)
        {
            [CommonUtility HideProgress];
            arrSupplierList = [[NSMutableArray alloc]init];
            arr_Is_shortlisted = [[NSMutableArray alloc]init];
            if (status && [[response valueForKey:@"success"]isEqual:@1])
            {
                [lblMessage setHidden:YES];
                if (response != (NSDictionary *)[NSNull null])
                {
                    NSError* Error;
                    SupplierDetail *objSupplierDetail = [[SupplierDetail alloc]initWithDictionary:response error:&Error];
                    [MBDataBaseHandler saveSupplierDetailData:objSupplierDetail];
                    
                    for (SupplierDetailData *data in objSupplierDetail.detail)
                    {
                        [arrSupplierList addObject:data];
                        [arr_Is_shortlisted addObject:@0];
                    }
                    
                    [self reloadTableViewAndScrollToTop:YES];
                    
                }
                else{
                    [CommonUtility HideProgress];
                }
            }
            else
            {
                [CommonUtility HideProgress];
                [lblMessage setHidden:NO];
                [self.tbtNegotiation reloadData];
            }
            
        });
    }
    else
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Internet Not Available Please Try Again..!"];
    }
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== ADD SUPPLIER LIST CALLED HERE ===❉===❉
/******************************************************************************************************************/
-(void)getAddSupplierShortlist:(NSMutableDictionary *)paramters withIndex:(NSIndexPath *)selectedIndex
{
    if (SharedObject.isNetAvailable)
    {
        [CommonUtility showProgressWithMessage:@"Please Wait.."];
        
        MBCall_AddSupplierShortlist(paramters, ^(id response, NSString *error, BOOL status)
        {
            [CommonUtility HideProgress];
            
            if (status && [[response valueForKey:@"success"]isEqual:@1])
            {
                if (response != (NSDictionary *)[NSNull null])
                {
                    [self reloadTableWithData:selectedIndex];
                }
                else{
                    [CommonUtility HideProgress];
                }
            }
            else
            {
                [CommonUtility HideProgress];
                [lblMessage setHidden:NO];
                [self.tbtNegotiation reloadData];
            }
            
        });
    }
    else
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Internet Not Available Please Try Again..!"];
    }
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== REMOVE SUPPLIER LIST CALLED HERE ===❉===❉
/******************************************************************************************************************/
-(void)removeSupplierShortlist:(NSMutableDictionary *)paramters withIndex:(NSIndexPath *)selectedIndex
{
    if (SharedObject.isNetAvailable)
    {
        [CommonUtility showProgressWithMessage:@"Please Wait.."];
        
        MBCall_RemoveSupplierShortlist(paramters, ^(id response, NSString *error, BOOL status)
        {
            [CommonUtility HideProgress];
            
            if (status && [[response valueForKey:@"success"]isEqual:@1])
            {
                if (response != (NSDictionary *)[NSNull null])
                {
                    [self reloadTableWithData:selectedIndex];
                }
                else{
                    [CommonUtility HideProgress];
                }
            }
            else
            {
                [CommonUtility HideProgress];
                [lblMessage setHidden:NO];
                [self.tbtNegotiation reloadData];
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
/*****************************************************************************************************************/
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self showPopUpWithData:textField];
    return NO;
}

/******************************************************************************************************************/
#pragma mark ❉===❉=== CELL  DELEGATE CALLED HERE ===❉===❉
/*****************************************************************************************************************/
-(void)setSelectItemViewWithData:(UIButton *)sender
{
    NSIndexPath *indexPath = [CommonUtility MB_IndexPathForCellContainingView:sender];
    
    BOOL currentStatus = [[arr_Is_shortlisted objectAtIndex:indexPath.row] boolValue];
    
    [arr_Is_shortlisted replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:!currentStatus]];
    
    BuyerUserDetail *objBuyerdetail = [MBDataBaseHandler getBuyerUserDetail];
    SupplierDetailData *objSupplierDetail = (SupplierDetailData *)[arrSupplierList objectAtIndex:indexPath.row];
    
    if ([sender.titleLabel.text isEqualToString:@"Add to Shortlist"])
    {
        NSMutableDictionary *dicParams =[[NSMutableDictionary alloc]init];
        [dicParams setValue:objBuyerdetail.detail.APIVerificationCode forKey:@"Token"];
        [dicParams setValue:objBuyerdetail.detail.UserID forKey:@"UserID"];
        [dicParams setValue:objBuyerdetail.detail.CustomerID forKey:@"CustomerID"];
        [dicParams setValue:selectedCategoryID forKey:@"GroupID"];
        [dicParams setValue:objSupplierDetail.VendorID forKey:@"SupplierID"];
        
        [self getAddSupplierShortlist:dicParams withIndex:indexPath];
    }
    else{
        NSMutableDictionary *dicParams =[[NSMutableDictionary alloc]init];
        [dicParams setValue:objBuyerdetail.detail.APIVerificationCode forKey:@"Token"];
        [dicParams setValue:objSupplierDetail.ShortlistID forKey:@"ShortlistID"];
        [self removeSupplierShortlist:dicParams withIndex:indexPath];
    }
}
-(void)setbtnMicroSiteWithURL:(UIButton *)sender
{
    NSIndexPath *indexPath = [CommonUtility MB_IndexPathForCellContainingView:sender];
    SupplierDetailData *objSupplierDetail = (SupplierDetailData *)[arrSupplierList objectAtIndex:indexPath.row];

}
/******************************************************************************************************************/
#pragma mark ❉===❉=== TABLEVIEW RELOAD METHOD ===❉===❉
/*****************************************************************************************************************/
- (void)reloadTableViewAndScrollToTop:(BOOL)scrollToTop
{
    [self.tbtNegotiation reloadData];
    if (scrollToTop)
    {
        [self.tbtNegotiation selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
}
-(void)reloadTableWithData:(NSIndexPath *)index
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (index == nil)
        {
            [self.tbtNegotiation reloadData];
        }
        else{
            [self.tbtNegotiation beginUpdates];
            [self.tbtNegotiation reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index, nil] withRowAnimation:UITableViewRowAnimationFade];
            [self.tbtNegotiation endUpdates];
        }
    });
}
@end



/******************************************************************************************************************/
#pragma mark ❉===❉=== TABLEVIEW CELL METHOD CALLED HERE ===❉===❉
/*****************************************************************************************************************/

@implementation SupplierCell
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [CommonUtility GetShadowWithBorder:_viewBG];
    
    [_lblCompanyName setNumberOfLines:0];
    [_lblCompanyName setLineBreakMode:NSLineBreakByWordWrapping];
    [_btnAddShort addTarget:self action:@selector(btnAddShortTapped:) forControlEvents:UIControlEventTouchUpInside];
    [_btnMicroSite setDefaultButtonShadowStyle:[UIColor redColor]];
    [_btnMicroSite.titleLabel setFont:IS_IPHONE5? UI_DEFAULT_FONT_MEDIUM(12):UI_DEFAULT_FONT_MEDIUM(14)];
    [_btnMicroSite addTarget:self action:@selector(btnMicroSiteTapped:) forControlEvents:UIControlEventTouchUpInside];

}
- (void)ConfigureSupplierCellwithData:(SupplierDetailData *)objSupplierDetail withIsselected:(BOOL)isSelected
{
    [_lblCompanyName setText:objSupplierDetail.CompanyName];
    
    [_lblAreaofOperation setText:[objSupplierDetail.AreaOfOperation isEqualToString:@""] ?[NSString stringWithFormat:@"Area of Operation : N/A"]:[NSString stringWithFormat:@"Area of Operation : %@",objSupplierDetail.AreaOfOperation]];
    
    [_lblyearOfEstablish setText:[objSupplierDetail.YearOfEstablishment isEqualToString:@""]?[NSString stringWithFormat:@"Year of Establishment : N/A"]:[NSString stringWithFormat:@"Year of Establishment : %@",objSupplierDetail.YearOfEstablishment]];
    
    [_lblAnualTurnOver setText:[objSupplierDetail.AnnualTurnOver isEqualToString:@""] ?[NSString stringWithFormat:@"Annual TurnOver : N/A"]:[NSString stringWithFormat:@"Annual TurnOver : %@",objSupplierDetail.AnnualTurnOver]];
    
    [_lblCertification setText:[objSupplierDetail.Certifications isEqualToString:@""]?[NSString stringWithFormat:@"Certifications : N/A"]:[NSString stringWithFormat:@"Certifications : %@",objSupplierDetail.Certifications]];
    
    if (objSupplierDetail.WebURL == (id)[NSNull null] || objSupplierDetail.WebURL.length == 0)
    {
        [_btnMicroSite setHidden:YES];
    }
    else{
        [_btnMicroSite setHidden:NO];
    }
    
    if (isSelected)
    {
        [_btnAddShort setTitle:@"Remove from Shortlist" forState:UIControlStateNormal];
        [_btnAddShort setDefaultButtonShadowStyle:[UIColor redColor]];
        _btnWidth.constant = 200;
    }
    else
    {
        [_btnAddShort setTitle:@"Add to Shortlist" forState:UIControlStateNormal];
        [_btnAddShort setDefaultButtonShadowStyle:GET_COLOR_WITH_RGB(0, 145, 147, 1)];
        _btnWidth.constant = 160;
        
    }
    
    [_imgSupplier setImageWithURL:[NSURL URLWithString:[objSupplierDetail.VendorLogo checkIfEmpty]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
    {
        if (!error)
        {
            if(cacheType == SDImageCacheTypeNone)
            {
                _imgSupplier.alpha = 0;
                
                [UIView transitionWithView:_imgSupplier
                                  duration:1.0
                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                animations:^{
                                    if (image==nil)
                                    {
                                        [_imgSupplier setImage:[UIImage imageNamed:@"IconNoImageAvailable"]];
                                    }
                                    else
                                    {
                                        [_imgSupplier setImage:image];
                                    }
                                    
                                    _imgSupplier.alpha = 1.0;
                                } completion:NULL];
            }
            else
            {
                _imgSupplier.alpha = 1;
            }
        }
        else
        {
            [_imgSupplier setImage:[UIImage imageNamed:@"IconNoImageAvailable"]];
        }
    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
}
-(IBAction)btnAddShortTapped:(UIButton *)sender
{
    if([_delegate respondsToSelector:@selector(setSelectItemViewWithData:)])
    {
        [_delegate setSelectItemViewWithData:sender];
    }
}
-(IBAction)btnMicroSiteTapped:(UIButton *)sender
{
    if([_delegate respondsToSelector:@selector(setbtnMicroSiteWithURL:)])
    {
        [_delegate setbtnMicroSiteWithURL:sender];
    }
}
@end
