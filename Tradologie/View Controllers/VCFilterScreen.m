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
{
    NSMutableArray *arrCountryList;
    NSMutableArray *arrSelectType;
    NSInteger index;

}

@end

@implementation VCFilterScreen

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setNavigationTittleWithLogo:@"Filter"];
    [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
    [self.navigationItem SetBackButtonWithID:self withSelectorAction:@selector(btnBack:)];
    [self.tbtFiltterList.layer setBorderWidth:1.0f];
    [self.tbtFiltterList.layer setBorderColor:DefaultThemeColor.CGColor];
    
    [btnSelectCountry addTarget:self action:@selector(btnSelectCountryType:) forControlEvents:UIControlEventTouchUpInside];
    [btnSelectCountry setBackgroundColor:DefaultThemeColor];
    [btnSelectCountry setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnSelectType addTarget:self action:@selector(btnSelectType:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationItem SetRightButtonWithID:self withSelectorAction:@selector(btnSubmitCalled:) withImage:@"IconTickMark"];
    
    arrCountryList = [[NSMutableArray alloc]initWithObjects:@"India",@"Nepal",@"Bahrain",@"Saudi Arabia",@"China",@"Pakistan",@"Thailand",@"Vietnam",@"United Arab Emirates",@"Oman",@"Kuwait",@"Qatar",@"Iran",nil];
    arrSelectType = [[NSMutableArray alloc]initWithObjects:@"Manufacturer",@"Trader",@"Member",@"Verified",@"Un-Verified",nil];
    
    [btnSelectCountry setSelected:YES];
    index = -1;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointMake(0, 0);
    }
}

/******************************************************************************************************************/
#pragma mark ❉===❉=== TABLEVIEW DATASOURCE & DELEGATE ❉===❉===
/*****************************************************************************************************************/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (btnSelectCountry.isSelected)
    {
        return arrCountryList.count;
    }
    else
    {
        return arrSelectType.count;

    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =(UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:COMMON_CELL_ID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:COMMON_CELL_ID];
    }
    
    cell.textLabel.text = (btnSelectCountry.isSelected) ?[NSString stringWithFormat:@"%@",[arrCountryList objectAtIndex:indexPath.row]]:[NSString stringWithFormat:@"%@",[arrSelectType objectAtIndex:indexPath.row]];
               cell.imageView.image = [UIImage imageNamed:@"IconUnCheckBox"];

    if (indexPath.row == index)
    {
        cell.imageView.image = [UIImage imageNamed:@"IconCheckBox"];
    }
    else
    {
        cell.imageView.image = [UIImage imageNamed:@"IconUnCheckBox"];
    }
    
    [cell.textLabel setFont:UI_DEFAULT_FONT_MEDIUM(15)];
    [cell.textLabel setTextColor:GET_COLOR_WITH_RGB(29, 65, 106, .85f)];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    index = indexPath.row;
    
    if (indexPath.row == index)
    {
        cell.imageView.image = [UIImage imageNamed:@"IconCheckBox"];
    }
    else
    {
        cell.imageView.image = [UIImage imageNamed:@"IconUnCheckBox"];
    }
    [self reloadInputViewsforTable];
}
/******************************************************************************************************************/
#pragma mark ❉===❉===  BUTTON ACTION EVENT CALLED HERE ===❉===❉
/******************************************************************************************************************/

-(IBAction)btnBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(IBAction)btnSubmitCalled:(UIButton *)sender{
    
}
-(IBAction)btnSelectCountryType:(UIButton *)sender
{
    [sender setSelected:YES];
     index = -1;
    if(sender.isSelected)
    {
        [sender setBackgroundColor:DefaultThemeColor];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [btnSelectType setSelected:NO];
        [btnSelectType setTitleColor:DefaultThemeColor forState:UIControlStateNormal];
        [btnSelectType setTitle:@"  Select Type" forState:UIControlStateNormal];
        [btnSelectType setBackgroundColor:[UIColor clearColor]];
    }
    [self reloadInputViewsforTable];

}
-(IBAction)btnSelectType:(UIButton *)sender
{
    [sender setSelected:YES];
    index = -1;
    if(sender.isSelected)
    {
        [sender setBackgroundColor:DefaultThemeColor];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [btnSelectCountry setSelected:NO];
        [btnSelectCountry setTitleColor:DefaultThemeColor forState:UIControlStateNormal];
        [btnSelectCountry setTitle:@"  Select Country" forState:UIControlStateNormal];
        [btnSelectCountry setBackgroundColor:[UIColor clearColor]];
        
    }
    [self reloadInputViewsforTable];
}
-(void)reloadInputViewsforTable
{
    NSRange range = NSMakeRange(0, 1);
    NSIndexSet *section = [NSIndexSet indexSetWithIndexesInRange:range];
    [self.tbtFiltterList reloadSections:section withRowAnimation:UITableViewRowAnimationFade];
}
@end
