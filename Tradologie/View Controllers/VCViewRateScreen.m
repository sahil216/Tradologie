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
    NSMutableArray *arrProductRate;
    NSString *strTimer , *strServerTime;
    BOOL isFromSecond;
    
    NSTimer *timer;
    NSTimer *ServerTimer;

    int Serverhours, ServerMinutes, ServerSeconds;
    int ServerSecondsLeft;
    
    int hours, minutes, seconds;
    int secondsLeft;
    
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
    
    [self countdownTimer];
    [self setServerCountDownfroProcessOrder];
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
    
    if (arrTittle.count > 7)
    {
         headerTotalWidth = SCREEN_WIDTH * ([arrTittle count] / 2.20);
    }
    else
    {
         headerTotalWidth = SCREEN_WIDTH * 2.50;
    }
    
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
    isFromSecond = NO ;
    [self getAuctionOrderProcessItemListDataFromDB];
    
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== TABLEVIEW DELEGATE & DATA SOURCE CALLED HERE ===❉===❉
/*****************************************************************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (arrProductRate.count > 0)
    {
        return 3;
    }
    return 2;
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
        isFromSecond = NO;
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
             [arrTittle removeObject:[arrTittle lastObject]];
            cell = [[TVCellCounterTime alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell_ID" itemSize:CGSizeMake(K_CUSTOM_WIDTH + 150, K_CUSTOM_WIDTH + 50) headerArray:arrTittle];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        [cell setDataDict:[arrData objectAtIndex:indexPath.row] WithIndex:indexPath.row WithCounterValue:strTimer withServerTime:strServerTime];
        
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
    if(indexPath.section == 1)
    {
        return lblHeight + 10;
    }
    else
    {
        return K_CUSTOM_WIDTH + 50;
    }
    
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
    //    [[UIDevice currentDevice] setValue:
    //     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait] forKey:@"orientation"];
    //    [self.navigationItem setNavigationTittleWithLogo:@"tradologie.com"];
    //
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        RootViewController * rootVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RootViewController"];
    //        AppDelegate *delegateClass = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    //        [delegateClass setRootViewController:rootVC];
    //    });
    
    [timer invalidate];
    timer = nil;
    [ServerTimer invalidate];
    ServerTimer = nil;
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
    arrProductRate = [[NSMutableArray alloc]init];

    for (NSMutableDictionary *dicData in arrObject)
    {
        NSMutableDictionary *dataDict = [NSMutableDictionary new];
        count ++;
        
        [dataDict setObject:[NSString stringWithFormat:@"%lu",count] forKey:[arrTittle objectAtIndex:0]];
        [dataDict setObject:[[dicData valueForKey:@"AuctionCategoryName"] stringByAppendingString:[@"\n " stringByAppendingString:[[dicData valueForKey:@"AuctionAttributeValue1"] stringByAppendingString:[@"\n " stringByAppendingString:[dicData valueForKey:@"AuctionAttributeValue2"]]]]] forKey:[arrTittle objectAtIndex:1]];
        [dataDict setObject:[dicData valueForKey:@"Quantity"] forKey:[arrTittle objectAtIndex:2]];
        [dataDict setObject:[dicData valueForKey:@"Rate"] forKey:@"RATE"];
        [arrProductRate addObjectsFromArray:[dicData valueForKey:@"Rate"]];
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
}


/******************************************************************************************************************/
#pragma mark ❉===❉=== GET TIMER COUNT DOWN START ===❉===❉
/******************************************************************************************************************/

-(void)updateCounter:(NSTimer *)theTimer
{
    if(secondsLeft > 0 )
    {
        secondsLeft -- ;
        hours = secondsLeft / 3600;
        minutes = (secondsLeft % 3600) / 60;
        seconds = (secondsLeft % 3600) % 60;
        strTimer = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"CounterTimer" object:strTimer];
        NSLog(@"%@",strTimer);
    }
    else
    {
        if([timer isValid])
        {
            strTimer = @"";
             [[NSNotificationCenter defaultCenter]postNotificationName:@"CounterTimer" object:strTimer];
            [timer invalidate];
            timer = nil;
        }
    }
}
-(void)countdownTimer
{
    secondsLeft = hours = minutes = seconds = (int)getTime();
    
    if([timer isValid])
    {
        strTimer = @"";
        [[NSNotificationCenter defaultCenter]postNotificationName:@"CounterTimer" object:strTimer];
        [timer invalidate];
        timer = nil;
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
    
}

NSInteger getTime()
{
    AuctionDetailForEdit *data = [MBDataBaseHandler getAuctionDetailForEditNegotiation];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
    
    NSString *strDate = [CommonUtility getDateFromSting:data.detail.EndDate fromFromate:@"MM/dd/yyyy hh:mm:ss a" withRequiredDateFormate:@"MM/dd/yyyy hh:mm:ss a"];
    
    NSDate *dateFrom = [dateFormatter dateFromString:strDate];
    NSTimeInterval aTimeInterval = [dateFrom timeIntervalSinceReferenceDate] + 60 * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
   
    NSString *strGiventime = [dateFormatter stringFromDate:newDate];
    NSString *strCurrentTime = [dateFormatter stringFromDate:[NSDate date]];
    
    NSDate* date1 = date(strGiventime);
    NSDate* date2 = date(strCurrentTime);
    
    NSComparisonResult result = [[NSDate date] compare:newDate];
    if(result==NSOrderedAscending)
    {
        NSTimeInterval distanceBetweenDates = [date1 timeIntervalSinceDate:date2];
        return distanceBetweenDates;
    }
    else if(result==NSOrderedDescending)
    {

    }
    else
    {
        NSLog(@"Both dates are same");
    }
    return 0;
}

NSDate *date(NSString *dateStr)
{
    NSString *dateString =  dateStr;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== GET SERVER TIMER COUNT DOWN START ===❉===❉
/******************************************************************************************************************/
-(void)setServerCountDownfroProcessOrder
{
    if([ServerTimer isValid])
    {
        [ServerTimer invalidate];
        ServerTimer = nil;
    }
    
    ServerSecondsLeft = Serverhours = ServerMinutes = ServerSeconds = (int)getServerTimeForProcessOrder();

    ServerTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateCounterForServerDate:) userInfo:nil repeats:YES];
    
}
NSInteger getServerTimeForProcessOrder()
{
    NSString *objData = [MBDataBaseHandler getAuctionOrderProcessItemWithData];
    NSMutableDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:[objData dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    
    NSMutableArray *arrObject = [[dataDict valueForKey:@"detail"] mutableCopy];
    NSMutableArray *arrServerTime = [[NSMutableArray alloc]init];

    for (NSMutableDictionary *dicData in arrObject)
    {
        NSMutableDictionary *dataDict = [NSMutableDictionary new];
        
        [dataDict setObject:[dicData valueForKey:@"ServerTime"] forKey:@"ServerTime"];
        [dataDict setObject:[dicData valueForKey:@"BuyerProcessOrderDate"] forKey:@"BuyerProcessOrderDate"];
        [arrServerTime addObject:dataDict];
    }
  
    NSMutableDictionary *dataValue = [NSMutableDictionary new];
    dataValue = [arrServerTime objectAtIndex:0];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm:ss"];

    NSString *str = [NSString stringWithFormat:@"%@",[dataValue valueForKey:@"BuyerProcessOrderDate"]];
    str = [str stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSString *strServerTime = [NSString stringWithFormat:@"%@",[dataValue valueForKey:@"ServerTime"]];
    strServerTime = [strServerTime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    strServerTime = [strServerTime stringByReplacingOccurrencesOfString:@"Z" withString:@" "];


    NSString *strDate = [CommonUtility getDateFromSting:str fromFromate:@"yyyy-MM-dd HH:mm:ss " withRequiredDateFormate:@"MM/dd/yyyy hh:mm:ss"];

    NSString *serverTime = [CommonUtility getDateFromSting:strServerTime fromFromate:@"yyyy-MM-dd HH:mm:s.SSS" withRequiredDateFormate:@"MM/dd/yyyy hh:mm:ss"];
    
    NSDate* date1 = Serverdate(serverTime);
    NSDate* date2 = Serverdate(strDate);

    NSComparisonResult result = [date2 compare:date1];
    
    if(result==NSOrderedAscending)
    {
        NSTimeInterval distanceBetweenDates = [date1 timeIntervalSinceDate:date2];
        return distanceBetweenDates;
    }
    else if(result==NSOrderedDescending)
    {
//        NSTimeInterval distanceBetweenDates = [date2 timeIntervalSinceDate:date1];
//        return distanceBetweenDates;
    }
    else
    {
        NSLog(@"Both dates are same");
    }
    return 0;
}
-(void)updateCounterForServerDate:(NSTimer *)theTimer
{
    if(ServerSecondsLeft > 0)
    {
        ServerSecondsLeft -- ;
        Serverhours = ServerSecondsLeft / 3600;
        ServerMinutes = (ServerSecondsLeft % 3600) / 60;
        ServerSeconds = (ServerSecondsLeft % 3600) % 60;
        strServerTime = [NSString stringWithFormat:@"%02d:%02d:%02d", Serverhours, ServerMinutes, ServerSeconds];
    
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ServerTimerTime" object:strServerTime];
        NSLog(@"%@",strServerTime);
    }
    else
    {
        if([ServerTimer isValid])
        {
            strServerTime = @"";
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ServerTimerTime" object:strServerTime];
            [ServerTimer invalidate];
            ServerTimer = nil;
        }
    }
}
NSDate *Serverdate(NSString *dateStr)
{
    NSString *dateString =  dateStr;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}
@end
