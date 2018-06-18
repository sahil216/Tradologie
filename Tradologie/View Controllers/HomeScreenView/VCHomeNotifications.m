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


@interface VCHomeNotifications ()<SFSafariViewControllerDelegate>
{
    NSMutableArray *arrNotificationList;
    NSMutableArray *arrAuctionDetail;
    NSMutableArray *arrEndDate,*arrStartDate,*arrServerDate;

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
    arrEndDate = [[NSMutableArray alloc]init];
    arrStartDate = [[NSMutableArray alloc]init];
    arrServerDate = [[NSMutableArray alloc]init];

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
        return arrAuctionDetail.count;
       
    }
     return (arrNotificationList.count > 0)?arrNotificationList.count:0;
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
        
        [cell ConfigureCellWithLiveDataEnquiry:[arrAuctionDetail objectAtIndex:indexPath.row] withEndDate:[arrEndDate objectAtIndex:indexPath.row]];
        [cell.btnplaceOrder addTarget:self action:@selector(btnViewTapped:) forControlEvents:UIControlEventTouchUpInside];

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
        [cell ConfigureNotificationListbyCellwithData:[arrNotificationList objectAtIndex:indexPath.row]];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        
    }
    else
    {
        NSNumber *selectedvalue = [NSNumber numberWithInteger:[[arrNotificationList objectAtIndex:indexPath.row] integerValue]];
        LiveAuctionData *objlivedata = [MBDataBaseHandler getliveAuctionDataUsingDashBoard];
        
        self->dicData = [[NSMutableDictionary alloc]init];
        self->dicData = [objlivedata.detail objectAtIndex:0];
        
        if (![[dicData valueForKey:@"AuctionDraftCount"] isEqual:@0] && ![[dicData valueForKey:@"AuctionNotStartCount"] isEqual:@0] )
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
        return 80;
    }
    return 50;
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
-(IBAction)btnViewTapped:(UIButton *)sender
{
    NSIndexPath *indexPath = [CommonUtility MB_IndexPathForCellContainingView:sender];
    
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationLandscapeRight] forKey:@"orientation"];
    [[UIApplication sharedApplication] setStatusBarHidden:YES animated:YES];
    [CommonUtility showProgressWithMessage:@"Please Wait"];
    
    BuyerUserDetail *objBuyerdetail = [MBDataBaseHandler getBuyerUserDetail];
    
    NSString *loadURL= [NSString stringWithFormat:@"http://tradologie.com/APIAuctionLive/%@/%@",objBuyerdetail.detail.APIVerificationCode,[arrAuctionDetail objectAtIndex:indexPath.row]];
    NSURL *url = [[NSURL alloc] initWithString:loadURL];
    SFSafariViewController *sfcontroller = [[SFSafariViewController alloc] initWithURL:url];
    [sfcontroller setDelegate:self];
    if (@available(iOS 10.0, *))
    {
        [sfcontroller setPreferredBarTintColor:DefaultThemeColor];
    } else {
        [sfcontroller setAutomaticallyAdjustsScrollViewInsets:YES];
    }
    [self.navigationController presentViewController:sfcontroller animated:YES completion:^{
        
    }];
}
/******************************************************************************************************************/
#pragma mark ❉===❉===  SAFARI BROWSER DELEGATE CALLED HERE ===❉===❉
/******************************************************************************************************************/
- (void)safariViewController:(SFSafariViewController *)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully
{
    [CommonUtility HideProgress];
}
- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller
{
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationPortrait] forKey:@"orientation"];
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
                    NSError *Error;
                    LiveAuctionData *objlivedata = [[LiveAuctionData alloc]initWithDictionary:response error:&Error];
                    [MBDataBaseHandler saveDashBoradLiveAuctionDataDetail:objlivedata];
                    [CommonUtility HideProgress];
                    
                    [self->lblMessage setHidden:YES];
                    [self.tbtNotify setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
                    
                    for (LiveAuctionDetailData *detail in objlivedata.detail)
                    {
                        NSString *strValue = [NSString stringWithFormat:@"%@,%@",detail.AuctionDraftCount,detail.AuctionNotStartCount];
                        
                        [self->arrNotificationList addObjectsFromArray:[strValue componentsSeparatedByString:@","]];
                    }
                    
                    for (NSMutableDictionary *dicdata in [self->dicData valueForKey:@"AuctionDetail"])
                    {
                        NSLog(@"%@",dicdata);
                        if ([[dicdata valueForKey:@"IsStarted"]isEqual:@1])
                        {

                        }
                        else
                        {
                            NSString *strValue = [NSString stringWithFormat:@"Enquiry Completed in %@",[dicdata valueForKey:@"AuctionCode"]];

                            [self->arrAuctionDetail addObject:strValue];
                        }
                    }
                    
                    
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
-(void)awakeFromNib
{
    [super awakeFromNib];
}
- (void)ConfigureNotificationListbyCellwithData:(NSString *)strValue
{
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self SetAttributedStringWithUnderlineTittle:strValue];
}
- (void)ConfigureCellWithLiveDataEnquiry:(NSString *)strValue withEndDate:(NSString *)strEndDate
{
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [_lblEnquiry setFont:([SDVersion deviceSize] > Screen4Dot7inch)?UI_DEFAULT_FONT(16):([SDVersion deviceSize] < Screen4Dot7inch)?UI_DEFAULT_FONT(14):UI_DEFAULT_FONT(16)];
    
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"The Enquiry in %@ is now live",strValue]];
    
    NSRange range = NSMakeRange(tncString.length - 11, 11);
    [tncString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0/255.0f green:145/255.0f blue:147/255.0f alpha:1.0f] range:range];
    [tncString addAttribute:NSFontAttributeName value:UI_DEFAULT_FONT_LIGHT(16) range:range];
    
    [_lblEnquiry setAttributedText:tncString];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-mm-dd hh:mm:ss"];
    
    strEndDate = [strEndDate stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    
    //NSDate *date = [dateFormatter dateFromString:strEndDate];
    
   // [_lblTimer setText:[self timeLeftSinceDate:date]];
}
-(void)SetAttributedStringWithUnderlineTittle:(NSString *)strValue
{
    [_lblNotifyName setFont:([SDVersion deviceSize] > Screen4Dot7inch)?UI_DEFAULT_FONT(17):([SDVersion deviceSize] < Screen4Dot7inch)?UI_DEFAULT_FONT(14):UI_DEFAULT_FONT(16)];
    
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"You have %@ Enquiry Request in Creation",strValue]];
    NSRange range = (strValue.length == 2)?NSMakeRange(9, 2):NSMakeRange(9, 1);
    
    [tncString addAttribute:NSUnderlineStyleAttributeName
                      value:@(NSUnderlineStyleDouble)
                      range:range];
    [tncString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:range];
    [tncString addAttribute:NSFontAttributeName value:UI_DEFAULT_FONT_MEDIUM(16) range:range];
    
    [_lblNotifyName setAttributedText:tncString];
}
@end
