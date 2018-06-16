//
//  VcEnquiryRequestScreen.m
//  Tradologie
//
//  Created by Chandresh Maurya on 10/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "VcEnquiryRequestScreen.h"
#import "Constant.h"
#import "AppConstant.h"
#import "MBDataBaseHandler.h"
#import "SharedManager.h"
#import "VCAddNegotiation.h"
#import "VCHomeNotifications.h"
#import "VCViewEnquiryScreen.h"
#import "RootViewController.h"
#import "AppDelegate.h"
#import "CommonUtility.h"
#import "MBAPIManager.h"
#import "VCViewRateScreen.h"

#define K_CUSTOM_WIDTH 170

@interface VcEnquiryRequestScreen ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,
TvCellEnquiryDelegate,SFSafariViewControllerDelegate>
{
    NSMutableArray *arrTittle;
    NSMutableArray *arrData;
    float headerTotalWidth;
    NSInteger count;
    CGFloat height , lblHeight;
    UITextField *txtGPSCode, *txtSortBuy;
}

@property (nonatomic, strong) UIView * contentView;
@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation VcEnquiryRequestScreen

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setNavigationTittleWithLogoforLanscapeMode:@"tradologie.com"];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationItem setHidesBackButton:YES animated:YES];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationItem SetBackButtonWithID:self withSelectorAction:@selector(btnBackItemTaped:)];
    [self.navigationItem SetRightButtonWithID:self withSelectorAction:@selector(btnRightItemTaped:)withImage:@"IconAddNegotiation"];
    
    lblHeight = 90;
    [self SetInitialSetup];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if([self respondsToSelector:@selector(edgesForExtendedLayout)])
            [self setEdgesForExtendedLayout:UIRectEdgeNone];
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.myTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    });
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO animated:YES];
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== SET INITIAL SETUP ===❉===❉
/*****************************************************************************************************************/
-(void)SetInitialSetup
{
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT + 20)];
    [_contentView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_contentView];
    
    headerTotalWidth = ((SCREEN_MAX_LENGTH) == 568) ? SCREEN_WIDTH * 3: SCREEN_WIDTH * 2.50;
    
    height = ([SDVersion deviceSize] > Screen4Dot7inch)?_contentView.frame.size.height - 75:([SDVersion deviceSize] < Screen4Dot7inch)?_contentView.frame.size.height - 65:_contentView.frame.size.height - 70;
    
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, headerTotalWidth, height) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.bounces=NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView = tableView;
    
    UIScrollView *myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height)];
    myScrollView.bounces=NO;
    [myScrollView addSubview:tableView];
    [myScrollView setShowsHorizontalScrollIndicator:NO];
    myScrollView.contentSize = CGSizeMake(headerTotalWidth, 0);
    [_contentView addSubview:myScrollView];
    
    [self getAuctionDataListfromDataBase];
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== TABLEVIEW DELEGATE & DATA SOURCE CALLED HERE ===❉===❉
/*****************************************************************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0;
    }
    return [arrData count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier=@"cell_Identifier";
    TvCellEnquiry *cell = (TvCellEnquiry *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil)
    {
        cell=[[TvCellEnquiry alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier itemSize:CGSizeMake(K_CUSTOM_WIDTH, lblHeight) headerArray:arrTittle];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    cell.dataDict = [arrData objectAtIndex:indexPath.row];
    cell.delegate = self;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *tableViewHeadView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [arrTittle count] * K_CUSTOM_WIDTH, 45)];
    [tableViewHeadView setBackgroundColor:DefaultThemeColor];
    
    if (section ==  1)
    {
        int xx = 0;
        int width = 80;
        
        for(int i = 0 ; i < [arrTittle count] ; i++)
        {
            UILabel *headLabel=[[UILabel alloc]initWithFrame:CGRectMake(xx, 0, width, 45)];
            [headLabel setText:[arrTittle objectAtIndex:i]];
            [headLabel setTextAlignment:NSTextAlignmentCenter];
            [headLabel setNumberOfLines:0];
            [headLabel setTextColor:[UIColor whiteColor]];
            [headLabel setLineBreakMode:NSLineBreakByWordWrapping];
            [headLabel setFont:UI_DEFAULT_FONT_MEDIUM(18)];
            [tableViewHeadView addSubview:headLabel];
            
            xx = xx + width;
            width = K_CUSTOM_WIDTH;
        }
        
    }
    else
    {
        txtGPSCode = [[UITextField alloc]initWithFrame:CGRectMake(8, 5, 190, 40)];
        [self SetdefaultTextfieldwithView:tableViewHeadView withTextfield:txtGPSCode withTag:1001 withPlaceHolder:@"GPS Code"];
        txtSortBuy = [[UITextField alloc]initWithFrame:CGRectMake(txtGPSCode.frame.origin.x +txtGPSCode.frame.size.width +10 , 5, 150, 40)];
        [self SetdefaultTextfieldwithView:tableViewHeadView withTextfield:txtSortBuy withTag:1002 withPlaceHolder:@"-Sort By-"];
    }
    return tableViewHeadView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return lblHeight + 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AuctionDetail *objAuctionDetail = [MBDataBaseHandler getAuctionDetail];
    NSMutableArray *arrValue = [[NSMutableArray alloc]init];
    [arrValue addObjectsFromArray:[objAuctionDetail.detail mutableCopy]];
    NSString *strID = [NSString stringWithFormat:@"%@",[[arrValue valueForKey:@"AuctionID"]objectAtIndex:indexPath.row]];
    
    [self AuctionDetailForEditNegotiationWithAuctionID:strID];
}

/******************************************************************************************************************/
#pragma mark ❉===❉=== GET AUCTION DETAIL FROM NEGOTIATION API ===❉===❉
/******************************************************************************************************************/

-(void)AuctionDetailForEditNegotiationWithAuctionID:(NSString *)auctionID
{
    BuyerUserDetail *objBuyerdetail = [MBDataBaseHandler getBuyerUserDetail];
    
    NSMutableDictionary *dicParams = [[NSMutableDictionary alloc]init];
    [dicParams setValue:objBuyerdetail.detail.APIVerificationCode forKey:@"Token"];
    [dicParams setValue:auctionID forKey:@"AuctionID"];
    [dicParams setValue:objBuyerdetail.detail.UserTimeZone forKey:@"UserTimeZone"];
    
    if (SharedObject.isNetAvailable)
    {
        [CommonUtility showProgressWithMessage:@"Please Wait.."];
        
        MBCall_AuctionDetailForEditNegotiation(dicParams, ^(id response, NSString *error, BOOL status)
        {
            [CommonUtility HideProgress];
            
            if (status && [[response valueForKey:@"success"]isEqual:@1])
            {
                if (response != (NSDictionary *)[NSNull null])
                {
                    NSError *error;
                    AuctionDetailForEdit *data = [[AuctionDetailForEdit alloc]initWithDictionary:response error:&error];
                    [MBDataBaseHandler saveAuctionDetailForEditNegotiation:data];
                    
                    [self getAuctionListAPIWithAuctionID:auctionID];
                    [self getAuctionSellerListAPIWithAuctionID:auctionID];
                    
                }
            }
            else
            {
                [CommonUtility HideProgress];
                [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:error];
            }
        });
    }
    else
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Internet Not Available Please Try Again..!"];
    }
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== GET AUCTION LIST ITEM API ===❉===❉
/******************************************************************************************************************/
-(void)getAuctionListAPIWithAuctionID:(NSString *)auctionID
{
    BuyerUserDetail *objBuyerdetail = [MBDataBaseHandler getBuyerUserDetail];
    
    NSMutableDictionary *dicParams = [[NSMutableDictionary alloc]init];
    [dicParams setValue:objBuyerdetail.detail.APIVerificationCode forKey:@"Token"];
    [dicParams setValue:auctionID forKey:@"AuctionID"];
    
    if (SharedObject.isNetAvailable)
    {
        [CommonUtility showProgressWithMessage:@"Please Wait.."];
        
        MBCall_AuctionItemListWithProductList(dicParams, ^(id response, NSString *error, BOOL status)
        {
            [CommonUtility HideProgress];
            
            if (status && [[response valueForKey:@"success"]isEqual:@1])
            {
                if (response != (NSDictionary *)[NSNull null])
                {
                    NSError *error;
                    AuctionItemList *objData = [[AuctionItemList alloc]initWithDictionary:response error:&error];
                    [MBDataBaseHandler saveAuctionItemListData:objData];
                    
                    VCViewEnquiryScreen *objScreen =[self.storyboard instantiateViewControllerWithIdentifier:@"VCViewEnquiryScreen"];
                    
                    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationLandscapeRight] forKey:@"orientation"];
                    [self.navigationController pushViewController:objScreen animated:YES];
                    
                }
            }
            else
            {
                [CommonUtility HideProgress];
                [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:error];
            }
        });
    }
    else
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Internet Not Available Please Try Again..!"];
    }
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== GET AUCTION LIST ITEM API ===❉===❉
/******************************************************************************************************************/
-(void)getAuctionListAPIWithAuctionCode:(NSString *)auctionCode
{
    BuyerUserDetail *objBuyerdetail = [MBDataBaseHandler getBuyerUserDetail];
    
    NSMutableDictionary *dicParams = [[NSMutableDictionary alloc]init];
    [dicParams setValue:objBuyerdetail.detail.APIVerificationCode forKey:@"Token"];
    [dicParams setValue:auctionCode forKey:@"AuctionCode"];
    
    if (SharedObject.isNetAvailable)
    {
        [CommonUtility showProgressWithMessage:@"Please Wait.."];
        
        MBCall_GetAuctionOrderProcessDetailWithAuctionCode(dicParams, ^(id response, NSString *error, BOOL status)
        {
            [CommonUtility HideProgress];
            
            if (status && [[response valueForKey:@"success"]isEqual:@1])
            {
                if (response != (NSDictionary *)[NSNull null])
                {
                    VCViewRateScreen *objScreen =[self.storyboard instantiateViewControllerWithIdentifier:@"VCViewRateScreen"];
                    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationLandscapeRight] forKey:@"orientation"];
                    [self.navigationController pushViewController:objScreen animated:YES];
                }
            }
            else
            {
                [CommonUtility HideProgress];
                [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:error];
            }
        });
    }
    else
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Internet Not Available Please Try Again..!"];
    }
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== GET AUCTION LIST ITEM API ===❉===❉
/******************************************************************************************************************/
-(void)getAuctionSellerListAPIWithAuctionID:(NSString *)auctionID
{
    BuyerUserDetail *objBuyerdetail = [MBDataBaseHandler getBuyerUserDetail];
    
    NSMutableDictionary *dicParams = [[NSMutableDictionary alloc]init];
    [dicParams setValue:objBuyerdetail.detail.APIVerificationCode forKey:@"Token"];
    [dicParams setValue:auctionID forKey:@"AuctionID"];
    
    if (SharedObject.isNetAvailable)
    {
        [CommonUtility showProgressWithMessage:@"Please Wait.."];
        
        MBCall_AuctionSupplierWithAuctionID(dicParams, ^(id response, NSString *error, BOOL status)
        {
            [CommonUtility HideProgress];
            
            if (status && [[response valueForKey:@"success"]isEqual:@1])
            {
                if (response != (NSDictionary *)[NSNull null])
                {
                    NSError *error;
                    AuctionSupplierList *objData = [[AuctionSupplierList alloc]initWithDictionary:response error:&error];
                    [MBDataBaseHandler saveAuctionSupplierListWithData:objData];
                }
            }
            else
            {
                [CommonUtility HideProgress];
                [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:error];
            }
        });
    }
    else
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Internet Not Available Please Try Again..!"];
    }
    
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== SCROLL VIEW DELEGATE CALLED HERE ===❉===❉
/*****************************************************************************************************************/
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY= self.myTableView.contentOffset.y;
    if(offsetY==0)
    {
        self.myTableView.contentOffset=CGPointZero;
    }
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== CELL  DELEGATE CALLED HERE ===❉===❉
/*****************************************************************************************************************/
-(void)setSelectItemViewWithData:(NSIndexPath *)selectedIndex withTittle:(NSString *)btnState
{
    AuctionDetail *objAuctionDetail = [MBDataBaseHandler getAuctionDetail];
    NSMutableArray *arrValue = [[NSMutableArray alloc]init];
    [arrValue addObjectsFromArray:[objAuctionDetail.detail mutableCopy]];
    NSString *strCode = [NSString stringWithFormat:@"%@",[[arrValue valueForKey:@"AuctionCode"]objectAtIndex:selectedIndex.row]];
    
    if ([btnState isEqualToString:@"View Rate"])
    {
        [self getAuctionListAPIWithAuctionCode:strCode];
    }
    else if ([btnState isEqualToString:@"View Enquiry"])
    {
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationLandscapeRight] forKey:@"orientation"];
        [[UIApplication sharedApplication] setStatusBarHidden:YES animated:YES];
        [CommonUtility showProgressWithMessage:@"Please Wait"];

        BuyerUserDetail *objBuyerdetail = [MBDataBaseHandler getBuyerUserDetail];

        NSString *loadURL= [NSString stringWithFormat:@"http://tradologie.com/APIAuctionLive/%@/%@",objBuyerdetail.detail.APIVerificationCode,strCode];
        NSURL *url = [[NSURL alloc] initWithString:loadURL];
        SFSafariViewController *sfcontroller = [[SFSafariViewController alloc] initWithURL:url];
        [sfcontroller setDelegate:self];
        [sfcontroller setPreferredBarTintColor:DefaultThemeColor];

        [self.navigationController presentViewController:sfcontroller animated:YES completion:^{

        }];
    }
}

- (void)safariViewController:(SFSafariViewController *)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully
{
    [CommonUtility HideProgress];
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
/******************************************************************************************************************/
#pragma mark ❉===❉=== BUTTON ACTION EVENT CALLED HERE ===❉===❉
/*****************************************************************************************************************/
-(void)SetdefaultTextfieldwithView:(UIView *)addView withTextfield:(UITextField *)txtfield withTag:(NSInteger)tag withPlaceHolder:(NSString *)placeholder
{
    [txtfield setAdditionalInformationTextfieldStyle:placeholder Withimage:[UIImage imageNamed:@"IconDropDownWhite"] withID:self withSelectorAction:@selector(btnDropDownTapped:) withTag:tag];
    [txtfield setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [txtfield setBackgroundColor:DefaultThemeColor];
    [txtfield setFont:UI_DEFAULT_FONT_MEDIUM(17)];
    [txtfield setTextColor:[UIColor whiteColor]];
    [txtfield setTag:tag];
    [txtfield.layer setBorderColor:[UIColor clearColor].CGColor];
    [txtfield setDelegate:self];
    [addView addSubview:txtfield];
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== BUTTON ACTION EVENT CALLED HERE ===❉===❉
/*****************************************************************************************************************/
-(IBAction)btnBackItemTaped:(UIButton *)sender
{    
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait] forKey:@"orientation"];
    [self.navigationItem setNavigationTittleWithLogo:@"tradologie.com"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        RootViewController * rootVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RootViewController"];
        AppDelegate *delegateClass = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        [delegateClass setRootViewController:rootVC];
    });
}
-(IBAction)btnRightItemTaped:(UIButton *)sender
{
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait] forKey:@"orientation"];
    VCAddNegotiation *objScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"VCAddNegotiation"];
    [self.navigationController pushViewController:objScreen animated:YES];
}
-(IBAction)btnDropDownTapped:(UIButton *)sender
{
    NSMutableArray *arrGPS=[[NSMutableArray alloc]initWithObjects:@"Delivery Address",@"Payment Term",@"Delivery State", nil];
    NSMutableArray *arrSortBy=[[NSMutableArray alloc]initWithObjects:@"All",@"Opened",@"Closed",@"Not Started",nil];
    
    FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
    configuration.menuRowHeight = 45;
    configuration.menuWidth = 150;
    
    [FTPopOverMenu showForSender:sender
                   withMenuArray:(sender.tag == 1001)?arrGPS:arrSortBy
                      imageArray:nil
                       doneBlock:^(NSInteger selectedIndex)
    {
        (sender.tag == 1001)?[self->txtGPSCode setText:[arrGPS objectAtIndex:selectedIndex]]: [self->txtSortBuy setText:[arrSortBy objectAtIndex:selectedIndex]];
        // [_myTableView reloadData];
        
    } dismissBlock:^{
        
    }];
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== GET DATA FROM DATABASE HERE ===❉===❉
/******************************************************************************************************************/
-(void)getAuctionDataListfromDataBase
{
    AuctionDetail *objBuyerdetail = [MBDataBaseHandler getAuctionDetail];
    arrTittle = [[NSMutableArray alloc]initWithObjects:@"Sr.No",@"View Rate",@"Enquiry Code",@"Enquiry Name",@"Negotiation Status",@"Enquiry Period",@"Payment Term",@"Partial Delivery",@"Address",@"Delivery State", nil];
    arrData = [[NSMutableArray alloc]init];
    count = 0;
    
    for (AuctionData *data in objBuyerdetail.detail)
    {
        NSMutableDictionary *dataDict = [NSMutableDictionary new];
        count ++;
        
        [dataDict setObject:[NSString stringWithFormat:@"%lu",count] forKey:[arrTittle objectAtIndex:0]];
        
        if ([data.Status isEqualToString:@"Draft"])
        {
            [dataDict setObject:[NSString stringWithFormat:@"Edit"] forKey:[arrTittle objectAtIndex:1]];
        }
        else if ([data.Status isEqualToString:@"Pending"])
        {
            [dataDict setObject:[NSString stringWithFormat:@"View Enquiry"] forKey:[arrTittle objectAtIndex:1]];
        }
        else if ([data.Status isEqualToString:@"PaymentPending"])
        {
            [dataDict setObject:[NSString stringWithFormat:@"Payment Pending"] forKey:[arrTittle objectAtIndex:1]];
        }
        else if ([data.Status isEqualToString:@"Approved"])
        {
            [dataDict setObject:[NSString stringWithFormat:@"View Rate"] forKey:[arrTittle objectAtIndex:1]];
        }
        
        [dataDict setObject:data.AuctionCode forKey:[arrTittle objectAtIndex:2]];
        [dataDict setObject:data.AuctionName forKey:[arrTittle objectAtIndex:3]];
        [dataDict setObject:data.Status forKey:[arrTittle objectAtIndex:4]];
        NSString *startDate = [CommonUtility getDateFromSting:data.StartDate fromFromate:@"dd/mm/yyyy hh:mm:ss a" withRequiredDateFormate:@"dd-MMM-yyyy hh:mm"];
        NSString *EndDate = [CommonUtility getDateFromSting:data.EndDate fromFromate:@"dd/mm/yyyy hh:mm:ss a" withRequiredDateFormate:@"dd-MMM-yyyy hh:mm"];
        
        [dataDict setObject:[startDate stringByAppendingString:[@"\n" stringByAppendingString:EndDate]] forKey:[arrTittle objectAtIndex:5]];
        [dataDict setObject:data.PaymentTerm forKey:[arrTittle objectAtIndex:6]];
        [dataDict setObject:data.PartialDelivery forKey:[arrTittle objectAtIndex:7]];
        [dataDict setObject:data.DeliveryAddress forKey:[arrTittle objectAtIndex:8]];
        [dataDict setObject:data.DeliveryState forKey:[arrTittle objectAtIndex:9]];
        
        [arrData addObject:dataDict];
        
    }
    [self.myTableView reloadData];
}
@end
