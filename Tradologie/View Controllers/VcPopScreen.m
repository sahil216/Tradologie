//
//  VcPopScreen.m
//  Tradologie
//
//  Created by Chandresh Maurya on 07/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "VcPopScreen.h"
#import "Constant.h"
#import "AppConstant.h"
#import "MBAPIManager.h"
#import "SharedManager.h"
#import "MBDataBaseHandler.h"


@interface VcPopScreen ()
{
    NSMutableArray *selectedItems;
    NSMutableArray *datasource;
    NSIndexPath *selectedRow;
    NSMutableArray *arrSelectedObject;
}

@end

@implementation VcPopScreen

- (void)viewDidLoad
{
    [super viewDidLoad];
    datasource =[[NSMutableArray alloc]init];
    selectedItems = [[NSMutableArray alloc]init];
    [btnClose.layer setCornerRadius:btnClose.frame.size.height/2];
    [viewBG.layer setCornerRadius:5.0f];
    [_tbtProductCat.layer setCornerRadius:5.0f];
    [btnClose addTarget:self action:@selector(didTapGestureHandle:) forControlEvents:UIControlEventTouchUpInside];

    arrSelectedObject = [[NSMutableArray alloc]init];
    [self.tbtProductCat setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self getallCategoryList];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//************************************************************************************************
#pragma mark ❉===❉=== TABLEVIEW DELEGATE & DATA SOURCE CALLED HERE ===❉===❉
//************************************************************************************************

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductsList *cell =(ProductsList *) [tableView dequeueReusableCellWithIdentifier:COMMON_CELL_ID];
    if (!cell) {
        cell = [[ProductsList alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:COMMON_CELL_ID];
    }
    [cell ConfigureProductsListbyCell];

    cell.imgCheckBox.image = [self containIndex:indexPath] ? IMAGE(CHECK_IMAGE) : IMAGE(UNCHECK_IMAGE);
    cell.lblProductName.text =[NSString stringWithFormat:@"%@",datasource[indexPath.row]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self containIndex:indexPath] ? [selectedItems removeObject:indexPath] : [selectedItems addObject:indexPath];
    [_tbtProductCat reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 50;
}


//************************************************************************************************
#pragma mark ❉===❉=== GET ALL CATEGORY LIST HERE ===❉===❉
//************************************************************************************************

-(void)getallCategoryList
{
    ProductCategory *objCat = [MBDataBaseHandler getAllProductCategories];
    for (detail *objDetail in objCat.detail)
    {
        [arrSelectedObject addObject:objDetail];
        [datasource addObject:objDetail.GroupName];
        [self.tbtProductCat reloadData];
    }
}
//************************************************************************************************
#pragma mark ❉===❉=== GESTURE HANDLE HERE ===❉===❉
//************************************************************************************************
-(void)didTapGestureHandle:(UIButton *)recoganise
{
    [self dismissViewControllerAnimated:NO completion:^{
        if ([self.delegate respondsToSelector:@selector(popupViewSelectedData:)])
        {
            [self.delegate popupViewSelectedData: [self getSelecetedValue]];
        }
    }];
}
//************************************************************************************************
#pragma mark ❉===❉=== GET ADITIONAL METHOD FOR SELECTED INDEX & VALUE  ===❉===❉
//************************************************************************************************
-(NSMutableArray *)getSelecetedValue
{
    NSMutableArray *selecteValues = [NSMutableArray new];
    for (int i = 0; i < selectedItems.count; i++) {
        NSIndexPath *index = selectedItems[i];
        [selecteValues addObject:arrSelectedObject[index.row]];
    }
    return selecteValues;
}
-(BOOL)containIndex:(NSIndexPath *)indxPath
{
    return  [selectedItems containsObject:indxPath] ? true : false;
}
@end

//************************************************************************************************
#pragma mark ❉===❉=== CUSTOM CELL CALLED HERE ===❉===❉
//************************************************************************************************

@implementation ProductsList

- (void)ConfigureProductsListbyCell
{
    
}

@end
