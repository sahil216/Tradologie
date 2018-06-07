//
//  TvAddProductScreen.m
//  Tradologie
//
//  Created by Chandresh Maurya on 06/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "TvAddProductScreen.h"
#import "Constant.h"
#import "AppConstant.h"
#import "CommonUtility.h"
@interface TvAddProductScreen ()

@end

@implementation TvAddProductScreen

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setNavigationTittleWithLogo:@"Add Product"];
    [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.navigationItem SetBackButtonWithID:self withSelectorAction:@selector(btnBackItemtapped:)];
    
    [txtProductName setAdditionalInformationTextfieldStyle:@"--Select Product Name--" Withimage:[UIImage imageNamed:@"IconDropDrown"] withID:self withSelectorAction:@selector(btnDropMethodTaped:) withTag:0];
    [txtGrade setAdditionalInformationTextfieldStyle:@"--Select Grade--" Withimage:[UIImage imageNamed:@"IconDropDrown"] withID:self withSelectorAction:@selector(btnDropMethodTaped:) withTag:0];
    [txtQuality setAdditionalInformationTextfieldStyle:@"--Select Quality--" Withimage:[UIImage imageNamed:@"IconDropDrown"] withID:self withSelectorAction:@selector(btnDropMethodTaped:) withTag:0];
    [txtProductType setAdditionalInformationTextfieldStyle:@"--Select Product Type--" Withimage:[UIImage imageNamed:@"IconDropDrown"] withID:self withSelectorAction:@selector(btnDropMethodTaped:) withTag:0];
    [txtProductUnit setAdditionalInformationTextfieldStyle:@"--Select Product Unit--" Withimage:[UIImage imageNamed:@"IconDropDrown"] withID:self withSelectorAction:@selector(btnDropMethodTaped:) withTag:0];
    [txtPackingType setAdditionalInformationTextfieldStyle:@"--Select Packing Type--" Withimage:[UIImage imageNamed:@"IconDropDrown"] withID:self withSelectorAction:@selector(btnDropMethodTaped:) withTag:0];
    [txtPackingSize setAdditionalInformationTextfieldStyle:@"--Select Packing Size--" Withimage:[UIImage imageNamed:@"IconDropDrown"] withID:self withSelectorAction:@selector(btnDropMethodTaped:) withTag:0];
    
    [txtTotalQty setDefaultTextfieldStyleWithPlaceHolder:@"Total Quantity" withTag:11];
    [txtSpecification setDefaultTextfieldStyleWithPlaceHolder:@"Please Enter Other Specifications,if any." withTag:12];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/******************************************************************************************************************/
#pragma mark ❉===❉=== TABLEVIEW DATASOURCE & DELEGATE ❉===❉===
/*****************************************************************************************************************/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return _viewFooter;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== BUTTON ACTION EVENT CALLED HERE ===❉===❉
/*****************************************************************************************************************/
-(IBAction)btnBackItemtapped:(UIButton *)sender
{
    [self.navigationItem setNavigationTittleWithLogo:@"tradologie.com"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        RootViewController * rootVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RootViewController"];
        AppDelegate *delegateClass = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        [delegateClass setRootViewController:rootVC];
    });
}

-(IBAction)btnDropMethodTaped:(UIButton *)sender
{
    
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== SHOW POPUP DATA HERE ===❉===❉
/******************************************************************************************************************/
-(void)showPopUpWithData:(UIView *)viewtoShow
{
    [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor colorWithRed:29.0f/255.0f green:65.0f/255.0f blue:106.0f/255.0f alpha:.30f]];
    
    if (viewtoShow.tag == 0)
    {
//        [CommonUtility showPopUpWithData:viewtoShow withArray:arrInspectionAgency withCompletion:^(NSInteger response)
//         {
//             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
//             NSString *strValue = [NSString stringWithFormat:@"%@",[arrInspectionAgency objectAtIndex:response]];
//             [txtInspectionAgency setText:strValue];
//             if ([strValue isEqualToString:[arrInspectionAgency lastObject]])
//             {
//                 isOthers = true;
//                 strInspectionID = [NSString stringWithFormat:@"%@",[arrInspectionID lastObject]];
//             }
//             else
//             {
//                 isOthers = false;
//                 strInspectionID = [NSString stringWithFormat:@"%@",[arrInspectionID objectAtIndex:response]];
//             }
//             [self.tableView reloadData];
//
//         } withDismissBlock:^{
//             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
//         }];
    }
    else if (viewtoShow.tag == 1)
    {
//        [CommonUtility showPopUpWithData:viewtoShow withArray:arrLocationDelivery withCompletion:^(NSInteger response)
//         {
//             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
//             [txtLocationDelivery setText:[NSString stringWithFormat:@"%@",[arrLocationDelivery objectAtIndex:response]]];
//             strAddressValue = [NSString stringWithFormat:@"%@",[arrAddressValue objectAtIndex:response]];
//             [self.tableView reloadData];
//         } withDismissBlock:^{
//             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
//         }];
    }
    else if (viewtoShow.tag == 2)
    {
        NSMutableArray *arrPayment = [[NSMutableArray alloc]initWithObjects:@"LC",@"ESCROW", nil];
//        [CommonUtility showPopUpWithData:viewtoShow withArray:arrPayment withCompletion:^(NSInteger response)
//         {
//             [txtPaymentTerm setText:[NSString stringWithFormat:@"%@",[arrPayment objectAtIndex:response]]];
//             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
//
//             [self.tableView reloadData];
//
//         } withDismissBlock:^{
//             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
//         }];
    }
    else if (viewtoShow.tag == 3)
    {
//        [CommonUtility showPopUpWithData:viewtoShow withArray:arrCurrency withCompletion:^(NSInteger response)
//         {
//             [txtCurrency setText:[NSString stringWithFormat:@"%@",[arrCurrency objectAtIndex:response]]];
//             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
//             strCurrencyId = [NSString stringWithFormat:@"%@",[arrCurrencyID objectAtIndex:response]];
//
//             [self.tableView reloadData];
//
//         } withDismissBlock:^{
//             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
//         }];
    }
    else if (viewtoShow.tag == 4)
    {
        NSMutableArray *arrPartial = [[NSMutableArray alloc]initWithObjects:@"Allowed",@"Not Allowed", nil];
        
//        [CommonUtility showPopUpWithData:viewtoShow withArray:arrPartial withCompletion:^(NSInteger response)
//         {
//             [txtPartialDelivery setText:[NSString stringWithFormat:@"%@",[arrPartial objectAtIndex:response]]];
//             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
//             
//         } withDismissBlock:^{
//             [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
//         }];
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
    return NO;    
}
@end
