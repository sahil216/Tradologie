//
//  MBDataBaseHandler.h
//  Florists
//
//  Created by Anil Khanna on 14/02/15.
//  Copyright (c) 2015 Anil Khanna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OfflineObject.h"
#import "AppConstant.h"

typedef enum
{
    LoggedInUser = 0,
    Category,
    buyerUserDetail,
    country,
    buyerInterestedIn,
    dashboardDetail,
    auctionData,
    supplierDetail,
    negotiationDetail,
    OrderHistory,
    auctionDetailForEdit,
    auctionItem,
    auctionSupplier,
    
} OFFLINEMODE;


@interface MBDataBaseHandler : NSObject

+(void)clearAllDataBase;

+(void) deleteAllRecordsForType:(OFFLINEMODE)type;

#pragma Mark - GETTERS

+(ProductCategory *)getAllProductCategories;
+(BuyerUserDetail *)getBuyerUserDetail;
+(LiveAuctionData *)getliveAuctionDataUsingDashBoard;
+(AuctionDetail *)getAuctionDetail;
+(AuctionOrderHistory *)getAuctionOrderHistory;

+(SupplierDetail *)getSupplierDetailData;
+(NegotiationDetail *)getNegotiationDetailData;
+(AuctionDetailForEdit *)getAuctionDetailForEditNegotiation;
+(AuctionItemList *)getAuctionItemListWithData;
+(AuctionSupplierList *)getAuctionSupplierListWithData;


#pragma Mark - SETTERS

+(void)saveProductCategoryDetail:(ProductCategory *)Categories;
+(void)saveCommonDataDetail:(BuyerUserDetail *)objBuyerUserDetail;
+(void)saveDashBoradLiveAuctionDataDetail:(LiveAuctionData *)Data;
+(void)saveAuctionDetailData:(AuctionDetail *)Data;
+(void)saveSupplierDetailData:(SupplierDetail *)Data;
+(void)saveNegotiationDetailData:(NegotiationDetail *)Data;
+(void)saveAuctionOrderHistory:(AuctionOrderHistory *)OrderHitoryData;
+(void)saveAuctionDetailForEditNegotiation:(AuctionDetailForEdit *)editNegotiation;
+(void)saveAuctionItemListData:(AuctionItemList *)auctionItemList;
+(void)saveAuctionSupplierListWithData:(AuctionSupplierList *)auctionSupplierList;



@end
