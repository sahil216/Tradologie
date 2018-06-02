//
//  VCFilterScreen.m
//  Tradologie
//
//  Created by Chandresh Maurya on 01/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "VCFilterScreen.h"
#import "AppConstant.h"
#import "Constant.h"

@interface VCFilterScreen ()

@end

@implementation VCFilterScreen

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setNavigationTittleWithLogo:@"Filter"];
    [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
    [self.tbtFiltterList setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.navigationItem SetBackButtonWithID:self withSelectorAction:@selector(btnBack:)];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointMake(0, -15);
    }
}

/******************************************************************************************************************/
#pragma mark ❉===❉=== TABLEVIEW DATASOURCE & DELEGATE ❉===❉===
/*****************************************************************************************************************/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =(UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:COMMON_CELL_ID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:COMMON_CELL_ID];
    }
    
  //cell.textLabel.text =[NSString stringWithFormat:@"%@",[arrTradeName objectAtIndex:indexPath.row]];
    [cell.textLabel setFont:UI_DEFAULT_FONT_MEDIUM(15)];
    [cell.textLabel setTextColor:GET_COLOR_WITH_RGB(29, 65, 106, .85f)];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
/******************************************************************************************************************/
#pragma mark ❉===❉===  BUTTON ACTION EVENT CALLED HERE ===❉===❉
/******************************************************************************************************************/

-(IBAction)btnBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
