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

@interface TVPaymentScreen ()
{
    BOOL customerIsCollapsed;
    BOOL siteIsCollapsed;
}
@end

@implementation TVPaymentScreen

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    customerIsCollapsed = NO;
    siteIsCollapsed = NO;
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
            return 10;
        else
            return 0;
    }
    else if (section == 2)
    {
        if(siteIsCollapsed)
            return 10;
        else
            return 0;
        
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cell_ID = @"Cell_Id_Payment";
    
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:Cell_ID];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:Cell_ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    [cell.textLabel setFont:UI_DEFAULT_FONT_MEDIUM(15)];
    [cell.textLabel setTextColor:GET_COLOR_WITH_RGB(29, 65, 106, .85f)];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 90)];
        [headerView setBackgroundColor:[UIColor whiteColor]];
        [self getLableAccordingtoView:headerView withTittle:@"Negotiation Code: " withFrame:CGRectMake(5, 0,SCREEN_WIDTH-10, 45) withSize:16 withTextColor:DefaultButtonColor];
        [self getLableAccordingtoView:headerView withTittle:@"Negotiation Name: "withFrame:CGRectMake(5, 45,SCREEN_WIDTH-10, 45) withSize:16 withTextColor:DefaultButtonColor];

        return headerView;
    }
    UIView *Viewsection2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
    [Viewsection2 setBackgroundColor:[UIColor whiteColor]];
    UIView *ViewHeader = [[UIView alloc]initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH - 10, 80)];
    [CommonUtility GetShadowWithBorder:ViewHeader];
    [ViewHeader setBackgroundColor:DefaultThemeColor];
    [ViewHeader.layer setBorderColor:[UIColor whiteColor].CGColor];

   
   
    if(section == 1)
    {
         [self getLableAccordingtoView:ViewHeader withTittle:@"ONLINE (Credit Card/Debit Card/Net Banking)" withFrame:CGRectMake(5, 0,ViewHeader.frame.size.width - 10, 40) withSize:16 withTextColor:[UIColor whiteColor]];
        if(!customerIsCollapsed)
        {
            
        }
        else
        {
            
        }
    }
    else if(section == 2)
    {
         [self getLableAccordingtoView:ViewHeader withTittle:@"OFFLINE (Cheque/DD/Wire Transfer)" withFrame:CGRectMake(5, 0,ViewHeader.frame.size.width - 10, 40) withSize:16 withTextColor:[UIColor whiteColor]];
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
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 90;
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== GET LABLE FOR HEADER HERE ===❉===❉
/*****************************************************************************************************************/
-(void)getLableAccordingtoView:(UIView *)viewBG withTittle:(NSString *)strTittle withFrame:(CGRect)frame withSize:(NSInteger)fontSize withTextColor:(UIColor *)color
{
    UILabel *lblbHeaderTittle= [[UILabel alloc]initWithFrame:frame];
    [lblbHeaderTittle setText:strTittle];
    [lblbHeaderTittle setFont:UI_DEFAULT_FONT_MEDIUM(fontSize)];
    [lblbHeaderTittle setTextColor:color];
    [viewBG addSubview:lblbHeaderTittle];
}

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
        }
        else
        {
            customerIsCollapsed = NO;
        }
        
    }
    else if(btnSection.tag == 2)
    {
        NSLog(@"Touched Site header");
        if(!siteIsCollapsed)
        {
            siteIsCollapsed = YES;
        }
        else
        {
            siteIsCollapsed = NO;
        }
        
        
    }
    [self.tableView beginUpdates];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

@end
