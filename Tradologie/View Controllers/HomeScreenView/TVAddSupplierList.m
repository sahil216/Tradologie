//
//  TVAddSupplierList.m
//  Tradologie
//
//  Created by Chandresh Maurya on 26/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "TVAddSupplierList.h"
#import "VcNegotiationDetail.h"
#import "AppConstant.h"
#import "Constant.h"
#import "CommonUtility.h"
#import "SharedManager.h"
#import "MBAPIManager.h"
#import "MBDataBaseHandler.h"

@interface TVAddSupplierList ()<INSSearchBarDelegate>
{
    NSMutableArray *arrSupplierName;
    NSMutableArray *arrSelectedSupplier;
    NSMutableArray *arrSelectType;
    NSInteger indexSelected;
    BOOL isselectedAll;
    UIView * viewFooter;
    UIButton *btnAddNegotiation;
}
@property (nonatomic, strong) INSSearchBar *searchBar;

@end

@implementation TVAddSupplierList

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setNavigationTittleWithLogo:@"Add Supplier"];
    [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
    [self.navigationItem SetBackButtonWithID:self withSelectorAction:@selector(btnBackSupplier:)];
    arrSelectType =[[NSMutableArray alloc]init];
    arrSelectedSupplier = [[NSMutableArray alloc]init];
    isselectedAll = NO;
    [self getAuctionSupplierListWithData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== SCROLL VIEW DELEGATE CALLED HERE ===❉===❉
/*****************************************************************************************************************/

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointMake(0, 0);
    }
}

/******************************************************************************************************************/
#pragma mark ❉===❉=== TABLEVIEW DATASOURCE & DELEGATE ❉===❉===
/*****************************************************************************************************************/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self->arrSupplierName.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Cell_ID = @"CellIdSupplier";
    
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:Cell_ID];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:Cell_ID];
    }
    
    cell.textLabel.text = [[self->arrSupplierName objectAtIndex:indexPath.row] capitalizedString];
    
    if (arrSelectType.count > 0)
    {
        if ([arrSelectType containsObject:[NSString stringWithFormat:@"%ld",indexPath.row]])
        {
            cell.imageView.image = [UIImage imageNamed:@"IconCheckBox"];

        }
        else
        {
            if ([arrSelectType containsObject:@"R"])
            {
                if ([[arrSelectType objectAtIndex:indexPath.row] isEqualToString:@"R"])
                {
                    cell.imageView.image = [UIImage imageNamed:@"IconUnCheckBox"];
                }
                else if (![[arrSelectType objectAtIndex:indexPath.row] isEqualToString:@"R"])
                {
                    if (![[arrSelectType objectAtIndex:indexPath.row] isEqualToString:@"T"])
                    {
                        cell.imageView.image = [UIImage imageNamed:@"IconCheckBox"];
                    }
                    else
                    {
                        cell.imageView.image = [UIImage imageNamed:@"IconUnCheckBox"];
                    }
                }
                else
                {
                    if (isselectedAll)
                    {
                        cell.imageView.image = [UIImage imageNamed:@"IconCheckBox"];
                    }
                    else
                    {
                        cell.imageView.image = [UIImage imageNamed:@"IconUnCheckBox"];
                    }
                }
            }
            else{
                cell.imageView.image = [UIImage imageNamed:@"IconUnCheckBox"];
            }
        }
    }
    else
    {
        cell.imageView.image = [UIImage imageNamed:@"IconUnCheckBox"];
    }
    [cell.textLabel setFont:UI_DEFAULT_FONT_MEDIUM(15)];
    [cell.textLabel setTextColor:GET_COLOR_WITH_RGB(29, 65, 106, .85f)];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    indexSelected = indexPath.row;
    if (arrSelectType.count > 0)
    {
        if ([arrSelectType containsObject:[NSString stringWithFormat:@"%ld",indexSelected]])
        {
            [arrSelectType replaceObjectAtIndex:indexPath.row withObject:@"R"];
            isselectedAll = NO;
            [arrSelectedSupplier removeObjectAtIndex:indexSelected];
        }
        else
        {
            [arrSelectType replaceObjectAtIndex:indexSelected withObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
            [arrSelectedSupplier addObject:[arrSupplierName objectAtIndex:indexPath.row]];
        }
    }
    else
    {
        [arrSelectType addObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        [arrSelectedSupplier addObject:[arrSupplierName objectAtIndex:indexPath.row]];
    }
    
   [self.tableView reloadData];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *tableViewHeadView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 55)];
    [tableViewHeadView setBackgroundColor:DefaultThemeColor];
    
    self.searchBar = [[INSSearchBar alloc] initWithFrame:CGRectMake(10, 5, 44.0, 45)];
    self.searchBar.delegate = self;
    [tableViewHeadView addSubview:self.searchBar];
    
    UIView *viewBG=[[UIView alloc]initWithFrame:CGRectMake(0, tableViewHeadView.frame.size.height,SCREEN_WIDTH, 45)];
    [viewBG setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *btnSelectAll = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 115, tableViewHeadView.frame.size.height)];
    [btnSelectAll setTitle:@"  Select All" forState:UIControlStateNormal];
    [btnSelectAll setTitleColor:DefaultThemeColor forState:UIControlStateNormal];
    if (isselectedAll)
    {
        [btnSelectAll setImage:[UIImage imageNamed:@"IconCheckBox"] forState:UIControlStateNormal];
    }
    else
    {
        [btnSelectAll setImage:[UIImage imageNamed:@"IconUnCheckBox"] forState:UIControlStateNormal];
    }
    [btnSelectAll.titleLabel setFont:UI_DEFAULT_FONT_MEDIUM(16)];
    [btnSelectAll addTarget:self action:@selector(btnSelectALLSupplier:) forControlEvents:UIControlEventTouchUpInside];
    [viewBG addSubview:btnSelectAll];
    [tableViewHeadView addSubview:viewBG];
    
    return tableViewHeadView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 100;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    viewFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    btnAddNegotiation = [[UIButton alloc]initWithFrame:viewFooter.frame];
    [btnAddNegotiation setBackgroundColor:DefaultThemeColor];
    [btnAddNegotiation setTitle:@"SAVE SUPPLIER" forState:UIControlStateNormal];
    [btnAddNegotiation.titleLabel setFont:UI_DEFAULT_FONT_MEDIUM(18)];
    [btnAddNegotiation setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnAddNegotiation addTarget:self action:@selector(btnAddSupplierTaped:) forControlEvents:UIControlEventTouchUpInside];
    [viewFooter addSubview:btnAddNegotiation];
    
    return viewFooter;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}
/******************************************************************************************************************/
#pragma mark ❉===❉===  BUTTON ACTION EVENT CALLED HERE ===❉===❉
/******************************************************************************************************************/

-(IBAction)btnBackSupplier:(UIButton *)sender
{
    [arrSelectedSupplier removeAllObjects];
     [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationLandscapeRight] forKey:@"orientation"];
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(IBAction)btnSelectALLSupplier:(UIButton *)sender
{
    isselectedAll  = ! isselectedAll;
    [arrSelectedSupplier removeAllObjects];
    [arrSelectType removeAllObjects];

    if (isselectedAll)
    {
        [arrSelectedSupplier addObjectsFromArray:arrSupplierName];
        
        for (int i = 0; i <= arrSupplierName.count - 1; i++)
        {
            NSString *strValue = [NSString stringWithFormat:@"%d",i];
            [arrSelectType addObject:strValue];
        }
        [sender setImage:[UIImage imageNamed:@"IconCheckBox"] forState:UIControlStateNormal];
    }
    else
    {
        for (int i = 0; i <= arrSupplierName.count - 1; i++)
        {
            [self->arrSelectType addObject:@"T"];
        }
        [sender setImage:[UIImage imageNamed:@"IconUnCheckBox"] forState:UIControlStateNormal];
    }
    
    [self.tableView reloadData];
}
-(IBAction)btnAddSupplierTaped:(UIButton *)sender
{
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIInterfaceOrientationLandscapeRight] forKey:@"orientation"];
    
    VcNegotiationDetail *objScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"VcNegotiationDetail"];
    objScreen.isfromViewEnquiry =  NO;
    objScreen.AuctionID =  _strAuctionID;
    
    NSString *data = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:arrSelectedSupplier options:0 error:nil] encoding:NSUTF8StringEncoding];
    [MBDataBaseHandler savegetAuctionSupplierListData:data WithID:[NSNumber numberWithInteger:[_strAuctionID integerValue]]];
    
    [self.navigationController pushViewController:objScreen animated:YES];
}


/******************************************************************************************************************/
#pragma mark ❉===❉=== SEARCH -- BAR DELEGATE CALLED HERE ===❉===❉
/*****************************************************************************************************************/
- (CGRect)destinationFrameForSearchBar:(INSSearchBar *)searchBar
{
    return CGRectMake(10, 5,SCREEN_WIDTH - 20, 45);
}

- (void)searchBar:(INSSearchBar *)searchBar willStartTransitioningToState:(INSSearchBarState)destinationState
{
    // Do whatever you deem necessary.
}

- (void)searchBar:(INSSearchBar *)searchBar didEndTransitioningFromState:(INSSearchBarState)previousState
{
    // Do whatever you deem necessary.
}

- (void)searchBarDidTapReturn:(INSSearchBar *)searchBar
{
    // Do whatever you deem necessary.
    // Access the text from the search bar like searchBar.searchField.text
}

- (void)searchBarTextDidChange:(INSSearchBar *)searchBar
{
    // Do whatever you deem necessary.
    // Access the text from the search bar like searchBar.searchField.text
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== GET AUCTION LIST ITEM API ===❉===❉
/******************************************************************************************************************/
-(void)getAuctionSupplierListWithData
{
    if (SharedObject.isNetAvailable)
    {
        [CommonUtility showProgressWithMessage:@"Please Wait.."];
        
        MBCall_GETAddAuctionSupplierAPI(_strGroupID, ^(id response, NSString *error, BOOL status)
       {
           [CommonUtility HideProgress];
          
           if (status && [[response valueForKey:@"success"]isEqual:@1])
           {
               self->arrSupplierName  = [[NSMutableArray alloc]init];
               if (response != (NSDictionary *)[NSNull null])
               {
                   for (NSMutableDictionary *dicValue in [response valueForKey:@"detail"])
                   {
                       [self->arrSupplierName addObject:[dicValue valueForKey:@"VendorName"]];
                       [self->arrSelectType addObject:@"T"];
                   }
                   [self.tableView reloadData];
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


@end
