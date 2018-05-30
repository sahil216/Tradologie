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

/*********************************************************************************************************/
#pragma Mark- MODEL IMPORT
/*********************************************************************************************************/

#import "ProductCategory.h"
#import "BuyerUserDetail.h"
#import "AuctionDetail.h"
#import "SupplierDetail.h"

/*********************************************************************************************************/
#pragma Mark- CUSTOM CELL IMPORT
/*********************************************************************************************************/
#import "TvCellEnquiry.h"





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



/*********************************************************************************************************/
#pragma CONTROLLER IDENTIFIRES
/*********************************************************************************************************/

static NSString *const kRootViewController                  = @"RootViewController";


#endif /* AppConstant_h */