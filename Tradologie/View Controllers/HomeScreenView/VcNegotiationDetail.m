//
//  VcNegotiationDetail.m
//  Tradologie
//
//  Created by Chandresh Maurya on 02/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "VcNegotiationDetail.h"
#import "Constant.h"
#import "CommonUtility.h"
#import "AppConstant.h"
#import "VCHomeNotifications.h"
#import "MBDataBaseHandler.h"
#import "TvAddProductScreen.h"
#import "SharedManager.h"
#import "MBAPIManager.h"
#import "TVAddSupplierList.h"
#import "VCSupplierShortlist.h"
#import "TVPaymentScreen.h"



#define K_CUSTOM_WIDTH 170

@interface VcNegotiationDetail ()<UITableViewDataSource,UITableViewDelegate,LandScapeViewDelegate,TVcellNotificationDelegate>
{
    NSMutableArray *arrTittle,*arrAuctionSellerList;
    NSMutableArray *arrData,*arrSupplierData;
    float headerTotalWidth;
    NSInteger count , sellerCount;
    CGFloat height , lblHeight;
    NSString *strGroupID;
    CGFloat viewHeight;
    NSMutableArray *arrMaximumQty;
}
@property (nonatomic, strong) UIView * contentView;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong)  LandScapeView * viewLandscape;

@end

@implementation VcNegotiationDetail

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setNavigationTittleWithLogoforLanscapeMode:@"Negotiation Details"];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationItem setHidesBackButton:YES animated:YES];
    [self.navigationItem setHidesBackButton:YES];
    
    arrTittle = [[NSMutableArray alloc]initWithObjects:@"Sr.No",@"Grade",@"Quantity",@"Packing Type",@"Packing Size",@"Packing Image",nil];
    arrAuctionSellerList = [[NSMutableArray alloc]initWithObjects:@"    Sr.No",@"Seller Name",nil];
    
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
    
    [self getAuctionListAPIWithAuctionID:_AuctionID withMode:YES];
    [self GetSupplierSelectedList];
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== SET INITIAL SETUP ===❉===❉
/*****************************************************************************************************************/
-(void)SetInitialSetup
{
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT + 20)];
    [_contentView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_contentView];
    
    headerTotalWidth =  SCREEN_WIDTH * 2.00;
    
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
    
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"LandScapeView" owner:self options:nil];
    _viewLandscape = [subviewArray objectAtIndex:0];
    [_viewLandscape setDelegate:self];
    if (arrData.count > 0)
    {
        viewHeight = _viewLandscape.frame.size.height;
    }
    else
    {
        viewHeight = _viewLandscape.frame.size.height - 200;
    }
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== TABLEVIEW DELEGATE & DATA SOURCE CALLED HERE ===❉===❉
/*****************************************************************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (arrData.count > 0)
    {
        return 5;
    }
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return  0;
    }
    else if (section == 1)
    {
        return (arrData.count > 0)?arrData.count:0;
    }
    else if (section == 2)
    {
        return (arrSupplierData.count > 0)?arrSupplierData.count:0;
    }
    else if (section == 3)
    {
        return 1;
    }
    else if (section == 4)
    {
        return 1;
    }
    
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static  NSString *cellIdentifier = @"";
    
    if(indexPath.section == 1)
    {
        cellIdentifier = COMMON_CELL_ID;
        
        TVcellNotificationlist *cell = (TVcellNotificationlist *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if(cell == nil)
        {
            cell=[[TVcellNotificationlist alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier itemSize:CGSizeMake(K_CUSTOM_WIDTH +50, lblHeight) headerArray:arrTittle isWithBoolValue:1];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.dataDict = [arrData objectAtIndex:indexPath.row];
        [cell setDelegate:self];
        return cell;
    }
    else if (indexPath.section == 2)
    {
        cellIdentifier = @"cell_Identifier";
        
        TVCellAuctionSeller *cell = (TVCellAuctionSeller *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil)
        {
            cell=[[TVCellAuctionSeller alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier itemSize:CGSizeMake(K_CUSTOM_WIDTH + 80, 55) headerArray:arrAuctionSellerList];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.dataDict = [arrSupplierData objectAtIndex:indexPath.row];
        
        return cell;
    }
    else if (indexPath.section == 3)
    {
        cellIdentifier = @"Cell_ID";
        
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if(cell == nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            [self GetButtonAccordingToTittle:cell withTittle:@"Add Supplier" withBtnframe:CGRectMake(20, 20, 150, 45) withSelectorAction:@selector(btnAddSupplier:)];
            
             [self GetButtonAccordingToTittle:cell withTittle:@"Add From Shortlisted" withBtnframe:CGRectMake(190, 20, 200, 45) withSelectorAction:@selector(btnAddSortlisted:)];
        }
        if (arrSupplierData.count > 0)
        {
             [self GetButtonAccordingToTittle:cell withTittle:@"Clear" withBtnframe:CGRectMake(410, 20, 100, 45) withSelectorAction:@selector(btnClearShortListSupplier:)];
        }
        return cell;
    }
    else if (indexPath.section == 4)
    {
       NSString *Cell_ID = @"Cell__Submit_ID";
        
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:Cell_ID];
        
        if(cell == nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell_ID];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            [self GetButtonAccordingToTittle:cell withTittle:@"Submit Negotiation" withBtnframe:CGRectMake(20, 20, 300, 45) withSelectorAction:@selector(btnSubmitNegotiation:)];

            [self GetButtonAccordingToTittle:cell withTittle:@"Back to List" withBtnframe:CGRectMake(360, 20, 300, 45) withSelectorAction:@selector(btnBacktoList:)];
        }
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
        
        [self getLableAccordingtoView:Viewsection2 withTittle:@"Negotiation Product Draft list"];
        
        if (arrData.count > 0)
        {
            int xx = 0;
            int width = 120;
            
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
        }
        
        return Viewsection2;
    }
    else if (section ==  2)
    {
        UIView *tableViewHeadView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [arrTittle count] * K_CUSTOM_WIDTH,(arrSupplierData.count > 0)?90:45)];
        [tableViewHeadView setBackgroundColor:DefaultThemeColor];
        [self getLableAccordingtoView:tableViewHeadView withTittle:@"Choose Supplier for Negotiation"];
        
        if (arrSupplierData.count > 0)
        {
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
        }
        return tableViewHeadView;
    }
    UIView *viewBG=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [arrTittle count] * K_CUSTOM_WIDTH, 0)];
    [viewBG setBackgroundColor:DefaultThemeColor];
    return viewBG;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        return lblHeight + 10;
    }
    if (indexPath.section == 2)
    {
        return 55;
    }
    return 70;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        if (arrData.count > 0)
        {
            return _viewLandscape.frame.size.height;
        }
        return viewHeight;
    }
    else if (section == 1)
    {
        if (arrData.count > 0)
        {
            return 90;
        }
        return 50;
    }
    else if (section == 2)
    {
        return (arrSupplierData.count > 0)?90:50;
    }
    return CGFLOAT_MIN;
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== GET LABLE FOR HEADER HERE ===❉===❉
/*****************************************************************************************************************/
-(void)getLableAccordingtoView:(UIView *)viewBG withTittle:(NSString *)strTittle
{
    UILabel *lblbHeaderTittle= [[UILabel alloc]initWithFrame:CGRectMake(20, 0, viewBG.frame.size.width - 20, 45)];
    [lblbHeaderTittle setText:strTittle];
    [lblbHeaderTittle setFont:UI_DEFAULT_FONT_MEDIUM(18)];
    [lblbHeaderTittle setTextColor:[UIColor whiteColor]];
    [viewBG addSubview:lblbHeaderTittle];
}
-(void)GetButtonAccordingToTittle:(UITableViewCell *)cell withTittle:(NSString *)strTittle withBtnframe:(CGRect)btnFrame
withSelectorAction:(SEL)sector
{
    UIButton *btnBack = [[UIButton alloc]initWithFrame:btnFrame];
    [btnBack setTitle:strTittle forState:UIControlStateNormal];
    [btnBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnBack addTarget:self action:sector forControlEvents:UIControlEventTouchUpInside];
    [btnBack setBackgroundColor:DefaultThemeColor];
    [cell addSubview:btnBack];
}


/******************************************************************************************************************/
#pragma mark ❉===❉=== BUTTON ACTION EVENT CALLED HERE ===❉===❉
/*****************************************************************************************************************/
-(IBAction)btnBackItem:(UIButton *)sender
{
    if (_isfromViewEnquiry)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
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
}
-(IBAction)btnAddSupplier:(UIButton *)sender
{
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationPortrait] forKey:@"orientation"];
    TVAddSupplierList *objTVAddSupplier = [self.storyboard instantiateViewControllerWithIdentifier:@"TVAddSupplierList"];
    objTVAddSupplier.strGroupID = strGroupID;
    objTVAddSupplier.strAuctionID = _AuctionID;
    [self.navigationController pushViewController:objTVAddSupplier animated:YES];
}
-(IBAction)btnAddSortlisted:(UIButton *)sender
{
//    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationPortrait] forKey:@"orientation"];
//    VCSupplierShortlist *objShortlist =[self.storyboard instantiateViewControllerWithIdentifier:@"VCSupplierShortlist"];
//    [self.navigationController pushViewController:objShortlist animated:YES];
}
-(IBAction)btnSubmitNegotiation:(UIButton *)sender
{
    AuctionDetailForEdit *objData = [MBDataBaseHandler getAuctionDetailForEditNegotiation];
    
    double sum = 0;
    
    for (NSNumber * n in arrMaximumQty)
    {
        sum += [n doubleValue];
    }
    if (sum >= [objData.detail.MinQuantity doubleValue] && arrSupplierData.count > 0)
    {
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationPortrait] forKey:@"orientation"];
        TVPaymentScreen *objTVPaymentScreen =[self.storyboard instantiateViewControllerWithIdentifier:@"TVPaymentScreen"];
        [self.navigationController pushViewController:objTVPaymentScreen animated:YES];
    }
    else
    {
         [[CommonUtility new]show_ErrorAlertWithTitle:@"" withMessage:@"Your Order Quanity Should be Greaterthan OR Equalto Minimum Order Quantity"];
    }
}
-(IBAction)btnClearShortListSupplier:(UIButton *)sender
{
    [arrSupplierData removeAllObjects];

    NSString *data = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:arrSupplierData options:0 error:nil] encoding:NSUTF8StringEncoding];
    [MBDataBaseHandler savegetAuctionSupplierListData:data WithID:[NSNumber numberWithInteger:[_AuctionID integerValue]]];
    
    [sender removeFromSuperview];
    [self reloadInputViewsforTableWithRange:2];
}

-(void)reloadInputViewsforTableWithRange:(NSInteger)sectionIndex
{
    NSRange range = NSMakeRange(sectionIndex, 1);
    NSIndexSet *section = [NSIndexSet indexSetWithIndexesInRange:range];
    [self.myTableView reloadSections:section withRowAnimation:UITableViewRowAnimationFade];
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== CELL DELEGATE CALLED HERE ===❉===❉
/*****************************************************************************************************************/
- (void)setSelectItemViewCodeWithData:(NSIndexPath *)selectedIndex{
    
    AuctionItemList *objData = [MBDataBaseHandler getAuctionItemListWithData];
    AuctionItemListData *data  = [objData.detail objectAtIndex:selectedIndex.row];
    [self getAuctionSupplierListWithDataWithAuctionTranID:data.AuctionTranID withIndex:selectedIndex.row];
    
}

/******************************************************************************************************************/
#pragma mark ❉===❉=== GET AUCTION LIST ITEM API ===❉===❉
/******************************************************************************************************************/
-(void)getAuctionSupplierListWithDataWithAuctionTranID:(NSString *)AuctionTranID withIndex:(NSInteger)Index;
{
    BuyerUserDetail *objBuyerdetail = [MBDataBaseHandler getBuyerUserDetail];
    
    NSMutableDictionary *dicParams = [[NSMutableDictionary alloc]init];
    [dicParams setValue:objBuyerdetail.detail.APIVerificationCode forKey:@"Token"];
    [dicParams setValue:objBuyerdetail.detail.CustomerID forKey:@"CustomerID"];
    [dicParams setValue:AuctionTranID forKey:@"AuctionTranID"];
    
    if (SharedObject.isNetAvailable)
    {
        [CommonUtility showProgressWithMessage:@"Please Wait.."];
        
        MBCall_DeleteAuctionItemWithData(dicParams, ^(id response, NSString *error, BOOL status)
        {
            [CommonUtility HideProgress];
            
            if (status && [[response valueForKey:@"success"]isEqual:@1])
            {
                if (response != (NSDictionary *)[NSNull null])
                {
                    [self getAuctionListAPIWithAuctionID:self->_AuctionID withMode:YES];
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
-(void)getAuctionListAPIWithAuctionID:(NSString *)auctionID withMode:(BOOL)boolvalue
{
    BuyerUserDetail *objBuyerdetail = [MBDataBaseHandler getBuyerUserDetail];
    
    NSMutableDictionary *dicParams = [[NSMutableDictionary alloc]init];
    [dicParams setValue:objBuyerdetail.detail.APIVerificationCode forKey:@"Token"];
    [dicParams setValue:auctionID forKey:@"AuctionID"];
    
    if (SharedObject.isNetAvailable)
    {
        [CommonUtility showProgressWithMessage:@"Please Wait.."];
        
        MBCall_AuctionItemListWithProductList(dicParams,boolvalue, ^(id response, NSString *error, BOOL status)
          {
              [CommonUtility HideProgress];
              
              if (status && [[response valueForKey:@"success"]isEqual:@1])
              {
                  if (response != (NSDictionary *)[NSNull null])
                  {
                      NSError *error;
                      AuctionItemList *objData = [[AuctionItemList alloc]initWithDictionary:response error:&error];
                      [MBDataBaseHandler saveAuctionItemListData:objData];
                      
                      self->arrData = [[NSMutableArray alloc]init];
                      self->arrMaximumQty = [[NSMutableArray alloc]init];
                      self->count = 0;
                      
                      for (AuctionItemListData *data in objData.detail)
                      {
                          NSMutableDictionary *dataDict = [NSMutableDictionary new];
                          self->count ++;
                          
                          [dataDict setObject:[NSString stringWithFormat:@"%lu",self->count] forKey:[self->arrTittle objectAtIndex:0]];
                          [dataDict setObject:[data.CategoryName stringByAppendingString:[@"\n " stringByAppendingString:[data.AttributeValue1 stringByAppendingString:[@"\n " stringByAppendingString:data.AttributeValue2]]]] forKey:[self->arrTittle objectAtIndex:1]];
                          [dataDict setObject:data.Quantity forKey:[self->arrTittle objectAtIndex:2]];
                          [dataDict setObject:data.PackingType forKey:[self->arrTittle objectAtIndex:3]];
                          [dataDict setObject:data.PackingSize forKey:[self->arrTittle objectAtIndex:4]];
                          [dataDict setObject:data.PackingImage forKey:[self->arrTittle objectAtIndex:5]];
                          self->strGroupID  = [data.GroupID stringValue];
                          [self->arrMaximumQty addObject:data.Quantity];
                          [self->arrData addObject:dataDict];
                      }
                      [self.myTableView reloadData];
                  }
              }
              else
              {
                  [CommonUtility HideProgress];
                  [self->arrData removeAllObjects];
                 // [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:error];
                  [self.myTableView reloadData];
                  
              }
          });
    }
    else
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Internet Not Available Please Try Again..!"];
    }
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== LANDSCAPE VIEW DELEGATE CALLED HERE ===❉===❉
/*****************************************************************************************************************/
-(void)setSelectItemViewWithData:(UIButton *)sender
{
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationPortrait] forKey:@"orientation"];
    TvAddProductScreen *objAddScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"TvAddProductScreen"];
    [self.navigationController pushViewController:objAddScreen animated:YES];
}



-(void)GetSupplierSelectedList
{
    NSMutableDictionary *objData = [MBDataBaseHandler getAuctionSupplierListData];
    if (objData != nil)
    {
        NSString * strAucID = [[objData valueForKey:[[objData allKeys]objectAtIndex:0]] stringValue];
        
        if ([strAucID isEqualToString:_AuctionID])
        {
            NSString * strValue = [objData valueForKey:[[objData allKeys]objectAtIndex:1]];
            
            NSMutableDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:[strValue dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            sellerCount = 0;
            arrSupplierData = [[NSMutableArray alloc]init];
            
            for (NSString *strValue in dataDict)
            {
                
                NSMutableDictionary *dataDict = [NSMutableDictionary new];
                self->sellerCount ++;
                
                [dataDict setObject:[NSString stringWithFormat:@"%lu",self->sellerCount] forKey:[self->arrAuctionSellerList objectAtIndex:0]];
                [dataDict setObject:strValue forKey:[self->arrAuctionSellerList objectAtIndex:1]];
                
                [self->arrSupplierData addObject:dataDict];
            }
            [self.myTableView reloadData];
        }
    }
}
@end
