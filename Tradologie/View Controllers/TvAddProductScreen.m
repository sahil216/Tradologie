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
    
    [txtProductName setAdditionalInformationTextfieldStyle:@"--Select Inspection Agency--" Withimage:[UIImage imageNamed:@"IconDropDrown"] withID:self withSelectorAction:@selector(btnDropMethodTaped:) withTag:0];
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
    return 11;
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
@end
