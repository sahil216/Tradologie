//
//  VCViewEnquiryScreen.m
//  Tradologie
//
//  Created by Chandresh Maurya on 13/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "VCViewEnquiryScreen.h"

#import "Constant.h"
#import "AppConstant.h"
#import "VCHomeNotifications.h"
#import "MBDataBaseHandler.h"

#define K_CUSTOM_WIDTH 150


@interface VCViewEnquiryScreen ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *arrTittle ,*arrAuctionSellerList;
    NSMutableArray *arrData ,*arrAuctionSupplierData;
    float headerTotalWidth;
    NSInteger count,SupplierCount;
    CGFloat height , lblHeight;
}
@property (nonatomic, strong) UIView * contentView;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) ViewEnquiryState * viewLandscape;

@end

@implementation VCViewEnquiryScreen

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setNavigationTittleWithLogoforLanscapeMode:@"Negotiation Details"];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationItem setHidesBackButton:YES animated:YES];
    [self.navigationItem setHidesBackButton:YES];
    
    arrTittle = [[NSMutableArray alloc]initWithObjects:@"Sr.No",@"Grade",@"Quantity",@"Packing Type",@"Packing Size",@"Packing Image",nil];
    
    arrAuctionSellerList = [[NSMutableArray alloc]initWithObjects:@"  Sr.No",@"Seller Name",@"Company Name",nil];
    
    lblHeight = 120;
    [self SetInitialSetup];
    [self.navigationItem SetBackButtonWithID:self withSelectorAction:@selector(btnBackItem:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    
    headerTotalWidth =  SCREEN_WIDTH * 1.35;
    
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
    
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"ViewEnquiryState" owner:self options:nil];
    _viewLandscape = [subviewArray objectAtIndex:0];

    [self getAuctionDataListfromDataBase];
    [self getAuctionSellerDataListfromDataBase];

}
/******************************************************************************************************************/
#pragma mark ❉===❉=== TABLEVIEW DELEGATE & DATA SOURCE CALLED HERE ===❉===❉
/*****************************************************************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return  0;
    }
    else if (section == 1)
    {
        return  arrData.count;
    }
    
    return arrAuctionSupplierData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   static NSString *cellIdentifier = @"";
    
    if(indexPath.section == 1)
    {
        cellIdentifier = COMMON_CELL_ID;
        TVcellNotificationlist *cell = (TVcellNotificationlist *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell==nil)
        {
            cell=[[TVcellNotificationlist alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier itemSize:CGSizeMake(K_CUSTOM_WIDTH +50, lblHeight) headerArray:arrTittle];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.dataDict = [arrData objectAtIndex:indexPath.row];
        
        return cell;
    }
    else if (indexPath.section== 2)
    {
        cellIdentifier = @"cell_Identifier";
        
        TVCellAuctionSeller *cell = (TVCellAuctionSeller *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell=[[TVCellAuctionSeller alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier itemSize:CGSizeMake(K_CUSTOM_WIDTH + 200, 60) headerArray:arrAuctionSellerList];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.dataDict = [arrAuctionSupplierData objectAtIndex:indexPath.row];
        return cell;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section ==  0)
    {
        AuctionDetailForEdit *data = [MBDataBaseHandler getAuctionDetailForEditNegotiation];
        [_viewLandscape setDataDict:data];
        return _viewLandscape;
    }
    else if (section ==  1)
    {
        UIView *Viewsection2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [arrTittle count] * K_CUSTOM_WIDTH, 90)];
        [Viewsection2 setBackgroundColor:DefaultThemeColor];
        
        [self getLableAccordingtoView:Viewsection2 withTittle:@"Negotiation Product list"];
        int xx = 0;
        int width = 80;
        
         for(int i = 0 ; i < [arrTittle count] ; i++)
         {
         UILabel *headLabel=[[UILabel alloc]initWithFrame:CGRectMake(xx, Viewsection2.frame.size.height/2, width, Viewsection2.frame.size.height/2)];
         [headLabel setText:[arrTittle objectAtIndex:i]];
         [headLabel setTextAlignment:NSTextAlignmentCenter];
         [headLabel setNumberOfLines:0];
         [headLabel setTextColor:[UIColor whiteColor]];
         [headLabel setLineBreakMode:NSLineBreakByWordWrapping];
         [headLabel setFont:UI_DEFAULT_FONT_MEDIUM(18)];
         [Viewsection2 addSubview:headLabel];
         
         xx = xx + width;
         width = K_CUSTOM_WIDTH + 50 ;
         }
         return Viewsection2;
    }
    
    UIView *tableViewHeadView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [arrTittle count] * K_CUSTOM_WIDTH, 90)];
    [tableViewHeadView setBackgroundColor:DefaultThemeColor];
    [self getLableAccordingtoView:tableViewHeadView withTittle:@"Auction Seller List"];
    int xx = 0;
    int width = 150;
    
    for(int i = 0 ; i < [arrAuctionSellerList count] ; i++)
    {
        UILabel *headLabel=[[UILabel alloc]initWithFrame:CGRectMake(xx, tableViewHeadView.frame.size.height/2, width, tableViewHeadView.frame.size.height/2)];
        [headLabel setText:[arrAuctionSellerList objectAtIndex:i]];
        [headLabel setTextAlignment:NSTextAlignmentLeft];
        [headLabel setNumberOfLines:0];
        [headLabel setTextColor:[UIColor whiteColor]];
        [headLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [headLabel setFont:UI_DEFAULT_FONT_MEDIUM(18)];
        [tableViewHeadView addSubview:headLabel];
        
        xx = xx + width;
        width = K_CUSTOM_WIDTH + 200;
    }
    return tableViewHeadView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        return lblHeight + 10;
    }
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return _viewLandscape.frame.size.height - 200;
    }
    return 90;
}

-(void)getLableAccordingtoView:(UIView *)viewBG withTittle:(NSString *)strTittle
{
    UILabel *lblbHeaderTittle= [[UILabel alloc]initWithFrame:CGRectMake(20, 0, viewBG.frame.size.width - 20, 45)];
    [lblbHeaderTittle setText:strTittle];
    [lblbHeaderTittle setFont:UI_DEFAULT_FONT_MEDIUM(18)];
    [lblbHeaderTittle setTextColor:[UIColor whiteColor]];
    [viewBG addSubview:lblbHeaderTittle];
}

/******************************************************************************************************************/
#pragma mark ❉===❉=== BUTTON ACTION EVENT CALLED HERE ===❉===❉
/*****************************************************************************************************************/
-(IBAction)btnBackItem:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

/******************************************************************************************************************/
#pragma mark ❉===❉=== GET DATA FROM DATABASE HERE ===❉===❉
/******************************************************************************************************************/
-(void)getAuctionDataListfromDataBase
{
    AuctionItemList *objData = [MBDataBaseHandler getAuctionItemListWithData];
    arrData = [[NSMutableArray alloc]init];
    count = 0;
    
    for (AuctionItemListData *data in objData.detail)
    {
        NSMutableDictionary *dataDict = [NSMutableDictionary new];
        count ++;
        
        [dataDict setObject:[NSString stringWithFormat:@"%lu",count] forKey:[arrTittle objectAtIndex:0]];
        [dataDict setObject:[data.CategoryName stringByAppendingString:[@"\n " stringByAppendingString:[data.AttributeValue1 stringByAppendingString:[@"\n " stringByAppendingString:data.AttributeValue2]]]] forKey:[arrTittle objectAtIndex:1]];
        [dataDict setObject:data.Quantity forKey:[arrTittle objectAtIndex:2]];
        [dataDict setObject:data.PackingType forKey:[arrTittle objectAtIndex:3]];
        [dataDict setObject:data.PackingSize forKey:[arrTittle objectAtIndex:4]];
        [dataDict setObject:data.PackingImage forKey:[arrTittle objectAtIndex:5]];
        
        [arrData addObject:dataDict];
    }
    [self.myTableView reloadData];
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== GET DATA FROM DATABASE HERE ===❉===❉
/******************************************************************************************************************/
-(void)getAuctionSellerDataListfromDataBase
{
    AuctionSupplierList *objData = [MBDataBaseHandler getAuctionSupplierListWithData];
    arrAuctionSupplierData = [[NSMutableArray alloc]init];
    
    SupplierCount = 0;
    
    for (AuctionSupplierListData *data in objData.detail)
    {
        NSMutableDictionary *dataDict = [NSMutableDictionary new];
        SupplierCount ++;
        [dataDict setObject:[NSString stringWithFormat:@"%lu",SupplierCount] forKey:[arrAuctionSellerList objectAtIndex:0]];
        [dataDict setObject:data.VendorName forKey:[arrAuctionSellerList objectAtIndex:1]];
        [dataDict setObject:data.CompanyName forKey:[arrAuctionSellerList objectAtIndex:2]];
      
        
        [arrAuctionSupplierData addObject:dataDict];
    }
    [self.myTableView reloadData];
}
@end


