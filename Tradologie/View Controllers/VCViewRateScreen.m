//
//  VCViewRateScreen.m
//  Tradologie
//
//  Created by Chandresh Maurya on 15/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "VCViewRateScreen.h"
#import "Constant.h"
#import "AppConstant.h"
#import "VCHomeNotifications.h"
#import "MBDataBaseHandler.h"

#define K_CUSTOM_WIDTH 150


@interface VCViewRateScreen ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *arrTittle;
    NSMutableArray *arrData;
    float headerTotalWidth;
    NSInteger count,SupplierCount;
    CGFloat height , lblHeight;
}
@property (nonatomic, strong) UIView * contentView;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) ViewEnquiryState * viewLandscape;

@end


@implementation VCViewRateScreen

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setNavigationTittleWithLogoforLanscapeMode:@"View Rate"];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationItem setHidesBackButton:YES animated:YES];
    [self.navigationItem setHidesBackButton:YES];
    
    arrTittle = [[NSMutableArray alloc]initWithObjects:@"Sr.No",@"Grade",@"Enquiry Quantity",@"Packing Type",@"Packing Size",@"Packing Image",nil];
    
    
    lblHeight = 120;
    [self SetInitialSetup];
    [self.navigationItem SetBackButtonWithID:self withSelectorAction:@selector(btnBackItem:)];
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
    
//    [self getAuctionDataListfromDataBase];
    
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
        return  0;
    }
    return  arrData.count;
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
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        AuctionDetailForEdit *data = [MBDataBaseHandler getAuctionDetailForEditNegotiation];
        [_viewLandscape setDataDict:data];
        return _viewLandscape;
    }
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return lblHeight + 10;
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
@end