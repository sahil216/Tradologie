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
} OFFLINEMODE;


@interface MBDataBaseHandler : NSObject

+(void)clearAllDataBase;

+(void) deleteAllRecordsForType:(OFFLINEMODE)type;

#pragma Mark - GETTERS

+(ProductCategory *)getAllProductCategories;
+(BuyerUserDetail *)getBuyerUserDetail;
+(NSString *)getAuctionDataUsingDashBoard;
+(AuctionDetail *)getAuctionDetail;
+(SupplierDetail *)getSupplierDetailData;




#pragma Mark - SETTERS

+(void)saveProductCategoryDetail:(ProductCategory *)Categories;
+(void)saveCommonDataDetail:(BuyerUserDetail *)objBuyerUserDetail;
+(void)saveDashBoradAuctionDataDetail:(NSString*)Data;
+(void)saveAuctionDetailData:(AuctionDetail *)Data;
+(void)saveSupplierDetailData:(SupplierDetail *)Data;





@end
