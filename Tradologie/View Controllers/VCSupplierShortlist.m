//
//  VCSupplierShortlist.m
//  Tradologie
//
//  Created by Chandresh Maurya on 05/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "VCSupplierShortlist.h"
#import "Constant.h"
#import "AppConstant.h"
#import "CommonUtility.h"
#import "MBAPIManager.h"
#import "SharedManager.h"
#import "MBDataBaseHandler.h"

@interface VCSupplierShortlist ()<SupplierCellDelegate>
{
    UILabel *lblMessage;
    NSMutableArray *arrCategoryList;
    NSMutableArray *arrCategoryID;
    NSMutableArray *arrSupplierList;
    NSMutableArray *arr_Is_shortlisted;
    NSString *selectedCategoryID;
    
    
}
@end

@implementation VCSupplierShortlist

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpInitialView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== INITIAL VIEW ===❉===❉
/*****************************************************************************************************************/
-(void)setUpInitialView
{
    [self.tbtSupplierShortlist setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.navigationItem setNavigationTittleWithLogo:@"Shortlisted Supplier"];
    lblMessage = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, 50)];
    [lblMessage setText:@"No Shortlisted Supplier Found..!"];
    [lblMessage setTextAlignment:NSTextAlignmentCenter];
    [lblMessage setHidden:YES];
    [self.tbtSupplierShortlist setBackgroundView:lblMessage];
    
    [txtCategory setAdditionalInformationTextfieldStyle:@"--Select Category--" Withimage:[UIImage imageNamed:@"IconDropDrown"] withID:self withSelectorAction:@selector(btnShowDropTaped:) withTag:0];
    [txtCategory setFont:UI_DEFAULT_FONT(17)];
    
    [btnFilter setDefaultButtonShadowStyle:DefaultThemeColor];
    [btnFilter.layer setCornerRadius:btnFilter.frame.size.height/2];
    
    [btnFilter setImage:[[UIImage imageNamed:@"IconFilter"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [btnFilter addTarget:self action:@selector(btnFilterTapped:) forControlEvents:UIControlEventTouchUpInside];
    [btnFilter setTintColor:[UIColor whiteColor]];
    [btnFilter setHidden:YES];
    
    [self getAllCategorylistfromDatabase];
}

-(void)getAllCategorylistfromDatabase
{
    ProductCategory *categoryList = [MBDataBaseHandler getAllProductCategories];
    
    arrCategoryList = [[NSMutableArray alloc]init];
    arrCategoryID = [[NSMutableArray alloc]init];
    
    for (NSMutableDictionary *dic in categoryList.detail)
    {
        [arrCategoryID addObject:[dic valueForKey:@"GroupID"]];
        [arrCategoryList addObject:[dic valueForKey:@"GroupName"]];
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
    return (arrSupplierList.count > 0)?arrSupplierList.count:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (arrSupplierList.count > 0)
    {
        TVCellSupplierList *cell = (TVCellSupplierList *) [tableView dequeueReusableCellWithIdentifier:COMMON_CELL_ID];
        if (!cell)
        {
            cell = [[TVCellSupplierList alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:COMMON_CELL_ID];
        }
        [cell ConfigureSupplierCellwithData:[arrSupplierList objectAtIndex:indexPath.row] withIndex:indexPath];
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
-(IBAction)btnShowDropTaped:(UIButton *)sender
{
    [self showPopUpWithData:sender];
}
-(IBAction)btnFilterTapped:(UIButton *)sender
{
    //    VCFilterScreen *objScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"VCFilterScreen"];
    //    [self.navigationController pushViewController:objScreen animated:YES];
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== SHOW POPUP DATA HERE ===❉===❉
/******************************************************************************************************************/
-(void)showPopUpWithData:(UIView *)viewtoShow
{
    if (arrCategoryList.count > 0)
    {
        [lblMessage setHidden:YES];
        [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor colorWithRed:29.0f/255.0f green:65.0f/255.0f blue:106.0f/255.0f alpha:.30f]];
        
        [CommonUtility showPopUpWithData:viewtoShow withArray:arrCategoryList withCompletion:^(NSInteger response)
        {
            [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
            [self->txtCategory setText:[self->arrCategoryList objectAtIndex:response]];
            self->selectedCategoryID = [NSString stringWithFormat:@"%@",[self->arrCategoryID objectAtIndex:response]];
            [self getSupplierShortlistAccordingToGroupID:[self->arrCategoryID objectAtIndex:response]];
        } withDismissBlock:^{
            [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
        }];
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
- (void)setSelectItemViewWithData:(UIButton *)sender
{
    NSIndexPath *indexPath = [CommonUtility MB_IndexPathForCellContainingView:sender];
    BuyerUserDetail *objBuyerdetail = [MBDataBaseHandler getBuyerUserDetail];
    SupplierDetailData *objSupplierDetail = (SupplierDetailData *)[arrSupplierList objectAtIndex:indexPath.row];
    NSMutableDictionary *dicParams =[[NSMutableDictionary alloc]init];
    [dicParams setValue:objBuyerdetail.detail.APIVerificationCode forKey:@"Token"];
    [dicParams setValue:objSupplierDetail.ShortlistID forKey:@"ShortlistID"];
    
    [self removeSupplierShortlist:dicParams withIndex:indexPath];
}

- (void)setbtnMicroSiteWithURL:(UIButton *)sender {
    
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== REMOVE SHORTLIST WITH ID ===❉===❉
/*****************************************************************************************************************/
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
                                                   [self->arrSupplierList removeObjectAtIndex:selectedIndex.row];
                                                   [self reloadTableWithData];
                                               }
                                               else{
                                                   [CommonUtility HideProgress];
                                               }
                                           }
                                           else
                                           {
                                               [CommonUtility HideProgress];
                                               [self->lblMessage setHidden:NO];
                                               [self.tbtSupplierShortlist reloadData];
                                           }
                                           
                                       });
    }
    else
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Internet Not Available Please Try Again..!"];
    }
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== GET SHORT LISTED SUPPLIER LIST WOTH CATEGORY ID ===❉===❉
/*****************************************************************************************************************/
-(void)getSupplierShortlistAccordingToGroupID:(NSString *)GroupID
{
    BuyerUserDetail *objBuyerdetail = [MBDataBaseHandler getBuyerUserDetail];
    
    NSMutableDictionary *dicParams = [[NSMutableDictionary alloc]init];
    [dicParams setValue:GroupID forKey:@"GroupID"];
    [dicParams setValue:objBuyerdetail.detail.CustomerID forKey:@"CustomerID"];
    
    if (SharedObject.isNetAvailable)
    {
        [CommonUtility showProgressWithMessage:@"Please Wait.."];
        
        MBCall_GetSupplierShortListedWithGroupID(dicParams, ^(id response, NSString *error, BOOL status)
        {
            self->arrSupplierList = [[NSMutableArray alloc]init];
            self->arr_Is_shortlisted = [[NSMutableArray alloc]init];
            [CommonUtility HideProgress];

            if (status && [[response valueForKey:@"success"]isEqual:@1])
            {
                [self->lblMessage setHidden:YES];
                [self->btnFilter setHidden:NO];

                if (response != (NSDictionary *)[NSNull null])
                {
                    NSError* Error;
                    SupplierDetail *objSupplierDetail = [[SupplierDetail alloc]initWithDictionary:response error:&Error];
                    [MBDataBaseHandler saveSupplierDetailData:objSupplierDetail];
                    
                    for (SupplierDetailData *data in objSupplierDetail.detail)
                    {
                        [self->arrSupplierList addObject:data];
                        [self->arr_Is_shortlisted addObject:@0];
                    }
                    [self reloadTableViewAndScrollToTop:YES];
                }
            }
            else
            {
                [self->lblMessage setHidden:NO];
                [self->btnFilter setHidden:YES];
                [self.tbtSupplierShortlist reloadData];
            }
            
        });
    }
    else
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Internet Not Available Please Try Again..!"];
    }
    
}

/******************************************************************************************************************/
#pragma mark ❉===❉=== TABLEVIEW RELOAD METHOD ===❉===❉
/*****************************************************************************************************************/
- (void)reloadTableViewAndScrollToTop:(BOOL)scrollToTop
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self->btnFilter setHidden:NO];
        [self.tbtSupplierShortlist reloadData];
        
        if (scrollToTop)
        {
            [CommonUtility HideProgress];
            [self.tbtSupplierShortlist selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        }
    });
    
}

-(void)reloadTableWithData
{
    (arrSupplierList.count > 0)? [lblMessage setHidden:YES]: [lblMessage setHidden:NO];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSRange range = NSMakeRange(0, 1);
        NSIndexSet *section = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.tbtSupplierShortlist reloadSections:section withRowAnimation:UITableViewRowAnimationFade];
    });
}


@end
