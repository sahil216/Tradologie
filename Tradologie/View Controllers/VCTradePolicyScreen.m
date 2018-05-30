//
//  VCTradePolicyScreen.m
//  Tradologie
//
//  Created by Chandresh Maurya on 14/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "VCTradePolicyScreen.h"
#import "Constant.h"
#import "AppConstant.h"
#import <SafariServices/SafariServices.h>

@interface VCTradePolicyScreen ()<SFSafariViewControllerDelegate>
{
    NSMutableArray *arrTradeName;
}
@end

@implementation VCTradePolicyScreen

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    arrTradeName = [[NSMutableArray alloc]initWithObjects:@"Plywood-Trade-Policy",@"TMT-Trade-Policy",@"Rice-Trade-Policy",@"Cement-Trade-Policy",nil];
    [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
    [self.navigationItem setNavigationTittleWithLogo:@"tradologie.com"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/******************************************************************************************************************/
#pragma mark ❉===❉=== TableView Data Source ❉===❉===
/*****************************************************************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrTradeName.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =(UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:COMMON_CELL_ID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:COMMON_CELL_ID];
    }
    
    cell.textLabel.text =[NSString stringWithFormat:@"%@",[arrTradeName objectAtIndex:indexPath.row]];
    [cell.textLabel setFont:UI_DEFAULT_FONT_MEDIUM(15)];
    [cell.textLabel setTextColor:GET_COLOR_WITH_RGB(29, 65, 106, .85f)];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        [self OpenURLAccordingToUse:@"http://tradologie.com/lp/pdf/plywood-trade-policy.pdf#zoom=70"];
    }
    else if (indexPath.row == 1){
        [self OpenURLAccordingToUse:@"http://tradologie.com/lp/pdf/tmt-trade-policy.pdf#zoom=70"];

    }
    else if (indexPath.row== 2){
        [self OpenURLAccordingToUse:@"http://tradologie.com/lp/pdf/rice-trade-policy.pdf#zoom=70"];

    }
    else{
        [self OpenURLAccordingToUse:@"http://tradologie.com/lp/pdf/cement-trade-policy.pdf?zoom=50"];

    }
        
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 50;
}
//************************************************************************************************
#pragma mark ❉===❉=== OPEN URL WITH DEAFULT ===❉===❉
//************************************************************************************************

-(void)OpenURLAccordingToUse:(NSString *)strURL
{
    NSURL *url = [NSURL URLWithString:strURL];
    
    if([[UIDevice currentDevice].systemVersion floatValue] >= 10.0)
    {
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)])
        {
            [[UIApplication sharedApplication] openURL:url options:@{}
                                     completionHandler:^(BOOL success)
             {
             }];
        }
        else
        {
            BOOL success = [[UIApplication sharedApplication] openURL:url];
        }
    }
    else
    {
        bool can = [[UIApplication sharedApplication] canOpenURL:url];
        if(can){
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

@end
