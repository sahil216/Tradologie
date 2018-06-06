//
//  VCOrderHistory.m
//  Tradologie
//
//  Created by Chandresh Maurya on 04/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "VCOrderHistory.h"
#import "Constant.h"
#import "AppConstant.h"
#import "SharedManager.h"
#import "MBAPIManager.h"
#import "CommonUtility.h"
#import "MBDataBaseHandler.h"

#define K_CUSTOM_WIDTH 170

@interface VCOrderHistory ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
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
@property (nonatomic, assign) BOOL hideStatusBar;
@end

@implementation VCOrderHistory

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setNavigationTittleWithLogoforLanscapeMode:@"Order History"];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationItem setHidesBackButton:YES animated:YES];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationItem SetBackButtonWithID:self withSelectorAction:@selector(btnBackItemTaped:)];
    
    
    lblHeight = 90;
    [self SetInitialSetup];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
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
    
    headerTotalWidth =  SCREEN_WIDTH * 2.50;
    
    height = ([SDVersion deviceSize] > Screen4Dot7inch)?_contentView.frame.size.height - 75:([SDVersion deviceSize] < Screen4Dot7inch)?_contentView.frame.size.height - 65:_contentView.frame.size.height - 70;
    
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, headerTotalWidth, height) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.bounces=NO;
    self.myTableView = tableView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIScrollView *myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height)];
    myScrollView.bounces=NO;
    [myScrollView addSubview:tableView];
    [myScrollView setShowsHorizontalScrollIndicator:NO];
    myScrollView.contentSize = CGSizeMake(headerTotalWidth, 0);
    [_contentView addSubview:myScrollView];
    [self GetOrderHistoryWithData];
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== TABLEVIEW DELEGATE & DATA SOURCE CALLED HERE ===❉===❉
/*****************************************************************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrData count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier=@"cell_Identifier";
    TVCellOrderHistory *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil)
    {
        cell=[[TVCellOrderHistory alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier itemSize:CGSizeMake(K_CUSTOM_WIDTH, lblHeight) headerArray:arrTittle];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    cell.dataDict = [arrData objectAtIndex:indexPath.row];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *tableViewHeadView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [arrTittle count] * K_CUSTOM_WIDTH, 45)];
    [tableViewHeadView setBackgroundColor:DefaultThemeColor];
    
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
/******************************************************************************************************************/
#pragma mark ❉===❉=== GET ORDER HISTORY API CALLED HERE ===❉===❉
/******************************************************************************************************************/
-(void)GetOrderHistoryWithData
{
    arrTittle = [[NSMutableArray alloc]initWithObjects:@"Sr.No",@"Negotiation Reference No",@"Supplier Name",@"PO Reference Number",@"Document",@"PO Number",@"Order Status",@"Order Quantity",@"Last Date of Inspection",@"Last Date of Delivery", nil];
    arrData = [[NSMutableArray alloc]init];
    count = 0;
    
    [self GetAuctionOrderHistoryWithData];
}
/******************************************************************************************************************/
#pragma mark ❉===❉===  GET AUCTION ORDER HISTORY LIST API CALLED HERE ===❉===❉
/******************************************************************************************************************/
-(void)GetAuctionOrderHistoryWithData
{
    BuyerUserDetail *objBuyerdetail = [MBDataBaseHandler getBuyerUserDetail];
    NSMutableDictionary *dicParams =[[NSMutableDictionary alloc]init];
    [dicParams setObject:objBuyerdetail.detail.APIVerificationCode forKey:@"Token"];
    [dicParams setObject:objBuyerdetail.detail.CustomerID forKey:@"CustomerID"];
    
    if (SharedObject.isNetAvailable)
    {
        BuyerUserDetail *objBuyerdetail = [MBDataBaseHandler getBuyerUserDetail];
        NSMutableDictionary *dicParams = [[NSMutableDictionary alloc]init];
        [dicParams setValue:objBuyerdetail.detail.APIVerificationCode forKey:@"Token"];
        [dicParams setValue:objBuyerdetail.detail.CustomerID forKey:@"CustomerID"];
        
        [CommonUtility showProgressWithMessage:@"Please Wait.."];
        
        MBCall_GetAuctionOrderHistoryWithID(dicParams, ^(id response, NSString *error, BOOL status)
        {
            [CommonUtility HideProgress];
            
            if (status && [[response valueForKey:@"success"]isEqual:@1])
            {
                if (response != (NSDictionary *)[NSNull null])
                {
                    NSError* Error;
                    AuctionOrderHistory *objOrderHistory = [[AuctionOrderHistory alloc]initWithDictionary:response error:&Error];
                    [MBDataBaseHandler saveAuctionOrderHistory:objOrderHistory];
                    
                    for (OrderHistoryData *data in objOrderHistory.detail)
                    {
                        NSMutableDictionary *dataDict = [NSMutableDictionary new];
                        count ++;
                        
                        [dataDict setObject:[NSString stringWithFormat:@"%lu",count] forKey:[arrTittle objectAtIndex:0]];
                        [dataDict setObject:data.AuctionCode forKey:[arrTittle objectAtIndex:1]];
                        [dataDict setObject:data.VendorName forKey:[arrTittle objectAtIndex:2]];
                        [dataDict setObject:data.ReferenceNo forKey:[arrTittle objectAtIndex:3]];
                        [dataDict setObject:data.AccountDocumentCount forKey:[arrTittle objectAtIndex:4]];
                        [dataDict setObject:data.PONo forKey:[arrTittle objectAtIndex:5]];
                        [dataDict setObject:data.OrderStatus forKey:[arrTittle objectAtIndex:6]];
                        [dataDict setObject:data.TotalOrderQty forKey:[arrTittle objectAtIndex:7]];
                        
                        NSString *startDate = [NSString stringWithFormat:@" %@",[self dateFromString:[NSString stringWithFormat:@"%@",data.StartDate]]];
                        NSString *EndDate = [NSString stringWithFormat:@" %@",[self dateFromString:[NSString stringWithFormat:@"%@",data.EndDate]]];
                        
                        [dataDict setObject:startDate forKey:[arrTittle objectAtIndex:8]];
                        [dataDict setObject:EndDate forKey:[arrTittle objectAtIndex:9]];
                        
                        [arrData addObject:dataDict];
                        
                    }
                    [self.myTableView reloadData];
                }
                else
                {
                    [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:[response valueForKey:@"message"]];
                }
            }
            else
            {
                [CommonUtility HideProgress];
                [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:error];
            }
        });
        
    }
    else{
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Internet Not Available Please Try Again..!"];
    }
}
-(NSString *)dateFromString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    [date descriptionWithLocale: [NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"dd-MMM-yyyy"];
    NSString *newDate = [dateFormatter stringFromDate:date];
    
    return newDate;
}

@end
