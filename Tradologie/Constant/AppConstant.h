//
//  AppConstant.h
//  Tradologie
//
//  Created by Macbook Pro 1 on 07/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#ifndef AppConstant_h
#define AppConstant_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MagicalRecord/MagicalRecord.h>
#import <SafariServices/SFSafariViewController.h>

/*********************************************************************************************************/
#pragma Mark- MODEL IMPORT
/*********************************************************************************************************/

#import "ProductCategory.h"
#import "BuyerUserDetail.h"
#import "AuctionDetail.h"
#import "SupplierDetail.h"
#import "NegotiationDetail.h"
#import "AuctionOrderHistory.h"
#import "AuctionDetailForEdit.h"
#import "AuctionItemList.h"
#import "AuctionSupplierList.h"

/*********************************************************************************************************/
#pragma Mark- CUSTOM CELL IMPORT
/*********************************************************************************************************/
#import "TvCellEnquiry.h"
#import "TVCellOrderHistory.h"
#import "TVCellSupplierList.h"
#import "TVcellNotificationlist.h"
#import "TVCellAuctionSeller.h"


#import "LandScapeView.h"
#import "ViewEnquiryState.h"
/*********************************************************************************************************/
#pragma Mark- BASE URL IMPORT
/*********************************************************************************************************/
#define HOST_URL @"http://api.tradologie.com/Buyer/"


/*********************************************************************************************************/
#pragma Mark- Image Name
/*********************************************************************************************************/

static NSString *CHECK_IMAGE = @"IconCheckBox";
static NSString *UNCHECK_IMAGE = @"IconUnCheckBox";

/*********************************************************************************************************/
#pragma Mark- TABLE CELL IDENTIFIERS
/*********************************************************************************************************/

static NSString *COLLECTION_CELL_ID = @"CVcell_Identifier";
static NSString *COMMON_CELL_ID = @"Cell_Identifier";
static NSString *ENQUIRY_LIVE_CELL_ID = @"CellLiveEnquiryIdentifier";

/*********************************************************************************************************/
#pragma Mark - API KEY NAME
/*********************************************************************************************************/
static NSString *REGISTER_API_NAME = @"RegisterV1";
static NSString *REGISTER_WITH_SOCAIL_MEDIA = @"RegisterWithOtherServices";
static NSString *API_DEFAULT_TOKEN = @"2018APR031848";
static NSString *TYPE_OF_ACCOUNT_ID = @"1";
static NSString *CATEGORY_API_NAME = @"CategoryForRegistration";
static NSString *CATEGORY_NEGOTIATION_API = @"category";
static NSString *SUPPLIER_LIST_API = @"SupplierList";
static NSString *ADD_SUPPLIER_SHORTLIST_API = @"AddSupplierShortlist";
static NSString *REMOVE_SUPPLIER_SHORTLIST_API = @"RemoveSupplierShortlist";
static NSString *COMMON_API = @"Commonddl";
static NSString *STATE_LIST_API = @"StateList";
static NSString *City_LIST_API = @"CityList";
static NSString *UPDATE_COMPULSORY_DETAIL_API =@"UpdateCompulsoryDetails";
static NSString *DASHBOARD_NOTIFICATION_API =@"DashboardNotification";
static NSString *AUCTION_LIST_API = @"AuctionList";
static NSString *LOGIN_API_NAME = @"login";

static NSString *CREATE_NEGOTIATION_API = @"createauction";
static NSString *ADD_UPDATE_NEGOTIATION_API = @"AddUpdateAuction";
static NSString *AUCTION_ORDER_HISTORY_API = @"AuctionOrderHistory";
static NSString *SUPPLIER_SHORTLIST_API = @"SupplierList_ByBuyer";
static NSString *AUCTION_DETAIL_FOR_EDIT_API = @"AuctionDetailForEdit";

static NSString *AUCTION_ITEM_LIST_API =@"AuctionItemSubmittedList";
static NSString *AUCTION_SUPPLIER_LIST_API =@"AutionSupplierList";
static NSString *AUCTION_ORDER_PROCESS_API =@"AuctionOrderProcessDetail";


/*********************************************************************************************************/
#pragma CONTROLLER IDENTIFIRES
/*********************************************************************************************************/

static NSString *const kRootViewController                  = @"RootViewController";


#endif /* AppConstant_h */
