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
#import "CommonUtility.h"

#define K_CUSTOM_WIDTH 200


@interface VCViewRateScreen ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *arrTittle;
    NSMutableArray *arrData;
    float headerTotalWidth;
    NSInteger count,SupplierCount;
    CGFloat height , lblHeight;
    NSMutableDictionary *dicRateData;
    NSString *strRate;

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

    lblHeight = 100;
    
    [self GetHeaderTittleValue];
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
    
    headerTotalWidth = SCREEN_WIDTH * ([arrTittle count] / 2);

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
    
    [self getAuctionOrderProcessItemListDataFromDB];
    
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
    else  if (section == 1)
    {
        return  arrData.count;
    }
    return  1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1)
    {
        TVCellEnquiryRate *cell = (TVCellEnquiryRate *)[tableView dequeueReusableCellWithIdentifier:COMMON_CELL_ID];
        
        if(cell==nil)
        {
            cell=[[TVCellEnquiryRate alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:COMMON_CELL_ID itemSize:CGSizeMake(K_CUSTOM_WIDTH + 150, lblHeight) headerArray:arrTittle];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        [cell setDataDict:[arrData objectAtIndex:indexPath.row] WithIndex:indexPath.row];
        
        return cell;
    }
    else if (indexPath.section == 2)
    {
        TVCellCounterTime *cell = (TVCellCounterTime *)[tableView dequeueReusableCellWithIdentifier:@"Cell_ID"];
        
        if(cell==nil)
        {
            cell = [[TVCellCounterTime alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell_ID" itemSize:CGSizeMake(K_CUSTOM_WIDTH + 150, lblHeight) headerArray:arrTittle];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        [cell setDataDict:nil WithIndex:indexPath.row];
        
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
    UIView *viewHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [arrTittle count] * K_CUSTOM_WIDTH, 60)];
    [viewHeader setBackgroundColor:DefaultThemeColor];
    
    if (section == 1)
    {
        int xx = 0;
        int width = 80;
        
        for(int i = 0 ; i < [arrTittle count] ; i++)
        {
            
            UILabel *headLabel=[[UILabel alloc]initWithFrame:CGRectMake(xx, 0 , width, viewHeader.frame.size.height)];
            [headLabel setText:[[arrTittle objectAtIndex:i]capitalizedString]];
            [headLabel setNumberOfLines:0];
            [headLabel setTextColor:[UIColor whiteColor]];
            [headLabel setLineBreakMode:NSLineBreakByWordWrapping];
            [headLabel setFont:UI_DEFAULT_FONT_MEDIUM(17)];
            [viewHeader addSubview:headLabel];
            
            xx = xx + width;
            
            if (i == 0)
            {
                width = 150;
                [headLabel setTextAlignment:NSTextAlignmentLeft];
                
            }
            else if (i == 1)
            {
                width = 120;
                [headLabel setTextAlignment:NSTextAlignmentLeft];
                
            }
            else if (i == arrTittle.count - 1)
            {
                width = 100;
                [headLabel setTextAlignment:NSTextAlignmentLeft];
            }
            else
            {
                width = K_CUSTOM_WIDTH + 150;
                [headLabel setTextAlignment:NSTextAlignmentCenter];
                
            }
        }
    }
    
    return viewHeader;
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
    else if(section == 1)
    {
        return 60;
    }
    return CGFLOAT_MIN;
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
-(void)getAuctionOrderProcessItemListDataFromDB
{
    NSString *objData = [MBDataBaseHandler getAuctionOrderProcessItemWithData];
    NSMutableDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:[objData dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    
    NSMutableArray *arrObject = [[dataDict valueForKey:@"detail"] mutableCopy];
    arrData = [[NSMutableArray alloc]init];
 
    for (NSMutableDictionary *dicData in arrObject)
    {
        NSMutableDictionary *dataDict = [NSMutableDictionary new];
        count ++;
        
        [dataDict setObject:[NSString stringWithFormat:@"%lu",count] forKey:[arrTittle objectAtIndex:0]];
        [dataDict setObject:[[dicData valueForKey:@"AuctionCategoryName"] stringByAppendingString:[@"\n " stringByAppendingString:[[dicData valueForKey:@"AuctionAttributeValue1"] stringByAppendingString:[@"\n " stringByAppendingString:[dicData valueForKey:@"AuctionAttributeValue2"]]]]] forKey:[arrTittle objectAtIndex:1]];
        [dataDict setObject:[dicData valueForKey:@"Quantity"] forKey:[arrTittle objectAtIndex:2]];
        [dataDict setObject:[dicData valueForKey:@"Rate"] forKey:@"RATE"];

        [arrData addObject:dataDict];
    }

    [self.myTableView reloadData];
}
-(void)GetHeaderTittleValue
{
    NSString *objData = [MBDataBaseHandler getAuctionOrderProcessItemWithData];
    NSMutableDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:[objData dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    
    arrTittle = [[NSMutableArray alloc]init];
    
    for (NSMutableDictionary *dicData in [dataDict valueForKey:@"detail"])
    {
        dicRateData = [[NSMutableDictionary alloc]init];
        for (NSMutableDictionary *dicRate in [dicData valueForKey:@"Rate"])
        {
            [arrTittle addObject:[dicRate valueForKey:@"SupplierName"]];
        }
    }
    NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:arrTittle];
    [arrTittle removeAllObjects];
    
    arrTittle = [[orderedSet array] mutableCopy];
    [arrTittle insertObject:@"  Sr.No" atIndex:0];
    [arrTittle insertObject:@"Description" atIndex:1];
    [arrTittle insertObject:@"Enquiry QTY" atIndex:2];
    [arrTittle insertObject:@"" atIndex:arrTittle.count];
    
    NSLog(@"TITLE ======> %@",arrTittle);
}
@end
