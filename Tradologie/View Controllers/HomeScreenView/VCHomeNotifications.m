//
//  VCHomeNotifications.m
//  Tradologie
//
//  Created by Chandresh Maurya on 09/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "VCHomeNotifications.h"
#import "VcEnquiryRequestScreen.h"
#import "AppConstant.h"
#import "MBAPIManager.h"
#import "SharedManager.h"
#import "CommonUtility.h"
#import "MBDataBaseHandler.h"
#import "VCAddNegotiation.h"


@interface VCHomeNotifications ()
{
    NSMutableArray *arrNotificationList;
    NSMutableArray *arrAuctionDetail;
    
    NSMutableDictionary *dicData;
    UILabel *lblMessage;
}
@end

@implementation VCHomeNotifications

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tbtNotify setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.navigationItem setNavigationTittleWithLogo:@"tradologie.com"];
    lblMessage = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, 50)];
    [lblMessage setText:@"No Record Found..!"];
    [lblMessage setTextAlignment:NSTextAlignmentCenter];
    [lblMessage setHidden:YES];
    [self.tbtNotify setBackgroundView:lblMessage];
    
    [btnAddNegotiation addTarget:self action:@selector(btnAddNegotiationCalled:) forControlEvents:UIControlEventTouchUpInside];
    [btnContactUs addTarget:self action:@selector(btnContactUsCalled:) forControlEvents:UIControlEventTouchUpInside];
    
    [btnAddNegotiation.titleLabel setFont:((SCREEN_MAX_LENGTH) == 568) ?UI_DEFAULT_FONT_MEDIUM(16):UI_DEFAULT_FONT_MEDIUM(18)];
    arrNotificationList = [[NSMutableArray alloc]init];
    arrAuctionDetail = [[NSMutableArray alloc]init];
    [self getDashboardNotificationAPI];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== TABLEVIEW DELEGATE & DATA SOURCE CALLED HERE ===❉===❉
/*****************************************************************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1)
    {
        return (arrNotificationList.count > 0)?arrNotificationList.count:0;
    }
    return arrAuctionDetail.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (arrAuctionDetail.count > 0 && indexPath.section == 1)
    {
        NotificationList *cell =(NotificationList *) [tableView dequeueReusableCellWithIdentifier:ENQUIRY_LIVE_CELL_ID];
        
        if (!cell)
        {
            cell = [[NotificationList alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:ENQUIRY_LIVE_CELL_ID];
        }
        
        [cell ConfigureCellWithLiveDataEnquiry:[NSString stringWithFormat:@"%@",[arrAuctionDetail objectAtIndex:indexPath.row]]];
        
        return cell;
        
    }
    
    NotificationList *cell =(NotificationList *) [tableView dequeueReusableCellWithIdentifier:COMMON_CELL_ID];
    if (arrNotificationList.count > 0)
    {
        if (!cell)
        {
            cell = [[NotificationList alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:COMMON_CELL_ID];
        }
        [cell ConfigureNotificationListbyCellwithData:[NSString stringWithFormat:@"You have %@ Enquiry Request in Creation",[arrNotificationList objectAtIndex:indexPath.row]]];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        NSNumber *selectedvalue = [NSNumber numberWithInteger:[[arrNotificationList objectAtIndex:indexPath.row] integerValue]];
        if (![[arrNotificationList objectAtIndex:indexPath.row] isEqualToString:@"0"])
        {
            if ([[dicData valueForKey:@"AuctionDraftCount"] isEqual:selectedvalue])
            {
                [self GetNegotiationListUsingAuction:@"Draft"];
            }
            else if ([[dicData valueForKey:@"AuctionNotStartCount"] isEqual:selectedvalue])
            {
                [self GetNegotiationListUsingAuction:@"NotStart"];
            }
            else
            {
                [self GetNegotiationListUsingAuction:@""];
            }
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section == 1)
    {
        return 50;
    }
    return 80;
}
/******************************************************************************************************************/
#pragma mark ❉===❉===  BUTTON ACTION EVENT CALLED HERE ===❉===❉
/******************************************************************************************************************/
-(IBAction)btnAddNegotiationCalled:(UIButton *)sender
{
    VCAddNegotiation *objScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"VCAddNegotiation"];
    [self.navigationController pushViewController:objScreen animated:YES];
}

-(IBAction)btnContactUsCalled:(UIButton *)sender
{
    [self getContactDialNumber];
}


/******************************************************************************************************************/
#pragma mark ❉===❉===  GET DASHBOARD NOTIFICATION API CALLED HERE ===❉===❉
/******************************************************************************************************************/
-(void)getDashboardNotificationAPI
{
    if (SharedObject.isNetAvailable)
    {
        [CommonUtility showProgressWithMessage:@"Please Wait.."];
        BuyerUserDetail *objBuyerdetail = [MBDataBaseHandler getBuyerUserDetail];
        
        NSMutableDictionary *dicParams =[[NSMutableDictionary alloc]init];
        [dicParams setObject:objBuyerdetail.detail.APIVerificationCode forKey:@"Token"];
        [dicParams setObject:objBuyerdetail.detail.CustomerID forKey:@"CustomerID"];
        [dicParams setObject:objBuyerdetail.detail.UserTimeZone forKey:@"UserTimeZone"];
        
        MBCall_GetDashBoardNotificationDetails(dicParams, ^(id response, NSString *error, BOOL status)
        {
            if (status && [[response valueForKey:@"success"]isEqual:@1])
            {
                if (response != (NSDictionary *)[NSNull null])
                {
                    self->dicData = [[NSMutableDictionary alloc]init];
                    self->dicData = [[[response valueForKey:@"detail"]objectAtIndex:0] mutableCopy];
                    
                    NSString *data = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:response options:0 error:nil] encoding:NSUTF8StringEncoding];
                    [MBDataBaseHandler saveDashBoradAuctionDataDetail:data];
                    [CommonUtility HideProgress];
                    
                    
                    [self->lblMessage setHidden:YES];
                    [self.tbtNotify setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
                    
                    NSString *strValue = [NSString stringWithFormat:@"%@,%@",[self->dicData valueForKey:@"AuctionDraftCount"],[self->dicData valueForKey:@"AuctionNotStartCount"]];
                    [self->arrNotificationList addObjectsFromArray:[strValue componentsSeparatedByString:@","]];
                    
//                    for (NSMutableDictionary *dicdata in [self->dicData valueForKey:@"AuctionDetail"])
//                    {
//                        NSLog(@"%@",dicdata);
//                        if ([[dicdata valueForKey:@"IsStarted"]isEqual:@1])
//                        {
//                               NSString *strValue = [NSString stringWithFormat:@"The Enquiry in %@",[dicdata valueForKey:@"AuctionCode"]];
//                            [self->arrAuctionDetail addObject:strValue];
//                        }
//                        else
//                        {
//                            NSString *strValue = [NSString stringWithFormat:@"Enquiry Completed in %@",[dicdata valueForKey:@"AuctionCode"]];
//
//                            [self->arrAuctionDetail addObject:strValue];
//                        }
//                    }
                    
                    
                    [self.tbtNotify reloadData];
                    
                }
            }
            else
            {
                [self->lblMessage setHidden:NO];
                [CommonUtility HideProgress];
                [self.tbtNotify setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                
            }
        });
    }
    else
    {
        [lblMessage setHidden:NO];
        [self.tbtNotify setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Internet Not Available Please Try Again..!"];
    }
}
/******************************************************************************************************************/
#pragma mark ❉===❉===  GET AUCTION NEGOTIATION LIST API CALLED HERE ===❉===❉
/******************************************************************************************************************/
-(void)GetNegotiationListUsingAuction:(NSString *)strValue
{
    BuyerUserDetail *objBuyerdetail = [MBDataBaseHandler getBuyerUserDetail];
    
    NSMutableDictionary *dicParams =[[NSMutableDictionary alloc]init];
    [dicParams setObject:objBuyerdetail.detail.APIVerificationCode forKey:@"Token"];
    [dicParams setObject:objBuyerdetail.detail.CustomerID forKey:@"CustomerID"];
    [dicParams setObject:strValue forKey:@"FilterAuction"];
    
    if (SharedObject.isNetAvailable)
    {
        [CommonUtility showProgressWithMessage:@"Please Wait.."];
        MBCall_GetAuctionListUsingDashboardApi(dicParams, ^(id response, NSString *error, BOOL status)
        {
            [CommonUtility HideProgress];
            if (status && [[response valueForKey:@"success"]isEqual:@1])
            {
                if (response != (NSDictionary *)[NSNull null])
                {
                    NSError* Error;
                    AuctionDetail *detail = [[AuctionDetail alloc]initWithDictionary:response error:&Error];
                    [MBDataBaseHandler saveAuctionDetailData:detail];
                    
                    VcEnquiryRequestScreen *requestSc=[self.storyboard instantiateViewControllerWithIdentifier:@"VcEnquiryRequestScreen"];
                    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationLandscapeRight] forKey:@"orientation"];
                    [self.navigationController pushViewController:requestSc animated:YES];
                }
                else{
                    [CommonUtility HideProgress];
                }
            }
            else
            {
                [CommonUtility HideProgress];
                
            }
        });
    }
    else
    {
        [lblMessage setHidden:NO];
        [self.tbtNotify setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Internet Not Available Please Try Again..!"];
    }
}

@end
/******************************************************************************************************************/
#pragma mark ❉===❉=== TABLEVIEW CELL METHOD CALLED HERE ===❉===❉
/*****************************************************************************************************************/

@implementation NotificationList

- (void)ConfigureNotificationListbyCellwithData:(NSString *)strValue
{
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self SetAttributedStringWithUnderlineTittle:strValue];
}
- (void)ConfigureCellWithLiveDataEnquiry:(NSString *)strValue
{
    [_lblEnquiry setFont:([SDVersion deviceSize] > Screen4Dot7inch)?UI_DEFAULT_FONT(17):([SDVersion deviceSize] < Screen4Dot7inch)?UI_DEFAULT_FONT(14):UI_DEFAULT_FONT(16)];
    
    [_lblEnquiry setText:strValue];

}
-(void)SetAttributedStringWithUnderlineTittle:(NSString *)strValue
{
    [_lblNotifyName setFont:([SDVersion deviceSize] > Screen4Dot7inch)?UI_DEFAULT_FONT(17):([SDVersion deviceSize] < Screen4Dot7inch)?UI_DEFAULT_FONT(14):UI_DEFAULT_FONT(16)];
    
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:strValue];
    NSRange range = (strValue.length == 2)?NSMakeRange(9, 2):NSMakeRange(9, 1);
    
    [tncString addAttribute:NSUnderlineStyleAttributeName
                      value:@(NSUnderlineStyleDouble)
                      range:range];
    [tncString addAttribute:NSUnderlineColorAttributeName value:[UIColor orangeColor] range:range];
    [tncString addAttribute:NSFontAttributeName value:UI_DEFAULT_FONT_MEDIUM(16) range:range];
    
    [_lblNotifyName setAttributedText:tncString];
}
@end
