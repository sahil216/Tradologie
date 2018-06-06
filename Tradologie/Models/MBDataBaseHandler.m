//
//  MBDataBaseHandler.m
//  Florists
//
//  Created by Anil Khanna on 14/02/15.
//  Copyright (c) 2015 Anil Khanna. All rights reserved.
//

#import "MBDataBaseHandler.h"

@implementation MBDataBaseHandler

/*********************************************************************************************/
#pragma mark ❉===❉=== GETTER METHOD TO GET VALUE FROM DATABASE ❉===❉===
/*********************************************************************************************/

+(ProductCategory *)getAllProductCategories
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(objType == %@)",[NSNumber numberWithInt:Category]];
    
    NSArray *array = [OfflineObject MR_findAllWithPredicate:predicate];
    
    if (array.count>0)
    {
        OfflineObject *object = array[0];
        ProductCategory *user = [[ProductCategory alloc] initWithString:object.objData error:nil];
        return user;
    }
    
    return nil;
}
+(BuyerUserDetail *)getBuyerUserDetail
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(objType == %@)",[NSNumber numberWithInt:buyerUserDetail]];
    
    NSArray *array = [OfflineObject MR_findAllWithPredicate:predicate];
    
    if (array.count>0)
    {
        OfflineObject *object = array[0];
        BuyerUserDetail *objCommondata = [[BuyerUserDetail alloc] initWithString:object.objData error:nil];
        return objCommondata;
    }
    
    return nil;
}
+(NSString *)getAuctionDataUsingDashBoard
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(objType == %@)",[NSNumber numberWithInt:dashboardDetail]];
    
    NSArray *array = [OfflineObject MR_findAllWithPredicate:predicate];
    
    if (array.count>0)
    {
        OfflineObject *object = array[0];
        NSString *listData = object.objData;
        return listData;
    }
    
    return nil;
}
+(AuctionDetail *)getAuctionDetail;
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(objType == %@)",[NSNumber numberWithInt:auctionData]];
    
    NSArray *array = [OfflineObject MR_findAllWithPredicate:predicate];
    
    if (array.count>0)
    {
        OfflineObject *object = array[0];
        AuctionDetail *objAuctionDetail = [[AuctionDetail alloc] initWithString:object.objData error:nil];
        return objAuctionDetail;
    }
    
    return nil;
}
+(AuctionDetailForEdit *)getAuctionDetailForEditNegotiation
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(objType == %@)",[NSNumber numberWithInt:auctionDetailForEdit]];
    
    NSArray *array = [OfflineObject MR_findAllWithPredicate:predicate];
    
    if (array.count>0)
    {
        OfflineObject *object = array[0];
        AuctionDetailForEdit *objAuctionDetail = [[AuctionDetailForEdit alloc] initWithString:object.objData error:nil];
        return objAuctionDetail;
    }
    return nil;
}

+(SupplierDetail *)getSupplierDetailData;
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(objType == %@)",[NSNumber numberWithInt:supplierDetail]];
    
    NSArray *array = [OfflineObject MR_findAllWithPredicate:predicate];
    
    if (array.count>0)
    {
        OfflineObject *object = array[0];
        SupplierDetail *objSupplierDetail = [[SupplierDetail alloc] initWithString:object.objData error:nil];
        return objSupplierDetail;
    }
    
    return nil;
}
+(NegotiationDetail *)getNegotiationDetailData;
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(objType == %@)",[NSNumber numberWithInt:negotiationDetail]];
    
    NSArray *array = [OfflineObject MR_findAllWithPredicate:predicate];
    
    if (array.count>0)
    {
        OfflineObject *object = array[0];
        NegotiationDetail *objNegotiationDetaill = [[NegotiationDetail alloc] initWithString:object.objData error:nil];
        return objNegotiationDetaill;
    }
    
    return nil;
}
+(AuctionOrderHistory *)getAuctionOrderHistory;
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(objType == %@)",[NSNumber numberWithInt:OrderHistory]];
    
    NSArray *array = [OfflineObject MR_findAllWithPredicate:predicate];
    
    if (array.count>0)
    {
        OfflineObject *object = array[0];
        AuctionOrderHistory *objOrderHistory = [[AuctionOrderHistory alloc] initWithString:object.objData error:nil];
        return objOrderHistory;
    }
    
    return nil;
}

/*********************************************************************************************/
#pragma mark ❉===❉=== SETTER METHOD TO SET VALUE IN DATABASE ❉===❉===
/*********************************************************************************************/

+ (void)saveProductCategoryDetail:(ProductCategory *)Categories
{
    [self deleteAllRecordsForType:Category];
    
    if (!Categories) {
        return;
    }
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        OfflineObject *newUser = [OfflineObject MR_createEntityInContext:localContext];
        newUser.objData = Categories.toJSONString;
        newUser.objType = [NSNumber numberWithInt:Category];
        newUser.objClass = NSStringFromClass([Categories class]);
        
    }];
}
+ (void)saveCommonDataDetail:(BuyerUserDetail *)objBuyerUserDetail
{
    [self deleteAllRecordsForType:buyerUserDetail];
    
    if (!objBuyerUserDetail) {
        return;
    }
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext)
    {
        OfflineObject *newUser = [OfflineObject MR_createEntityInContext:localContext];
        newUser.objData = objBuyerUserDetail.toJSONString;
        newUser.objId = objBuyerUserDetail.detail.UserID;
        newUser.objType = [NSNumber numberWithInt:buyerUserDetail];
        newUser.objClass = NSStringFromClass([objBuyerUserDetail class]);
        
    }];
}
+(void)saveDashBoradAuctionDataDetail:(NSString*)Data;
{
    [self deleteAllRecordsForType:dashboardDetail];
    
    if (!Data) {
        return;
    }
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext)
     {
         OfflineObject *newUser = [OfflineObject MR_createEntityInContext:localContext];
         newUser.objData = Data;
         newUser.objType = [NSNumber numberWithInt:dashboardDetail];
         newUser.objClass = NSStringFromClass([Data class]);
         
     }];
}
+(void)saveAuctionDetailData:(AuctionDetail *)Data
{
    [self deleteAllRecordsForType:auctionData];
    
    if (!Data) {
        return;
    }
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext)
     {
         OfflineObject *newUser = [OfflineObject MR_createEntityInContext:localContext];
         newUser.objData = Data.toJSONString;
         newUser.objType = [NSNumber numberWithInt:auctionData];
         newUser.objClass = NSStringFromClass([Data class]);
         
     }];
}
+(void)saveSupplierDetailData:(SupplierDetail *)Data
{
    [self deleteAllRecordsForType:supplierDetail];
    
    if (!Data) {
        return;
    }
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext)
     {
         OfflineObject *newUser = [OfflineObject MR_createEntityInContext:localContext];
         newUser.objData = Data.toJSONString;
         newUser.objType = [NSNumber numberWithInt:supplierDetail];
         newUser.objClass = NSStringFromClass([Data class]);
         
     }];
}
+(void)saveNegotiationDetailData:(NegotiationDetail *)Data
{
    [self deleteAllRecordsForType:negotiationDetail];
    
    if (!Data) {
        return;
    }
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext)
     {
         OfflineObject *newUser = [OfflineObject MR_createEntityInContext:localContext];
         newUser.objData = Data.toJSONString;
         newUser.objType = [NSNumber numberWithInt:negotiationDetail];
         newUser.objClass = NSStringFromClass([Data class]);
         
     }];
}
+(void)saveAuctionOrderHistory:(AuctionOrderHistory *)OrderHitoryData;
{
    [self deleteAllRecordsForType:OrderHistory];
    
    if (!OrderHitoryData) {
        return;
    }
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext)
     {
         OfflineObject *newUser = [OfflineObject MR_createEntityInContext:localContext];
         newUser.objData = OrderHitoryData.toJSONString;
         newUser.objType = [NSNumber numberWithInt:OrderHistory];
         newUser.objClass = NSStringFromClass([OrderHitoryData class]);
         
     }];
    
}
+ (void)saveAuctionDetailForEditNegotiation:(AuctionDetailForEdit *)editNegotiation
{
    [self deleteAllRecordsForType:auctionDetailForEdit];
    
    if (!editNegotiation) {
        return;
    }
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext)
     {
         OfflineObject *newUser = [OfflineObject MR_createEntityInContext:localContext];
         newUser.objData = editNegotiation.toJSONString;
         newUser.objId = editNegotiation.detail.AuctionID;
         newUser.objType = [NSNumber numberWithInt:auctionDetailForEdit];
         newUser.objClass = NSStringFromClass([editNegotiation class]);
         
     }];
}

/*********************************************************************************************/
#pragma mark ❉===❉=== DELETE ALL RECORD"S FROM DATABASE ❉===❉===
/*********************************************************************************************/

+ (void) deleteAllRecordsForType:(OFFLINEMODE)type{
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(objType == %@)",[NSNumber numberWithInt:type]];
        [OfflineObject MR_deleteAllMatchingPredicate:predicate inContext:localContext];
    }];
    
}


+(void)clearAllDataBase
{
    [OfflineObject MR_truncateAll];
    
//    [self deleteAllRecordsForType:LoggedInUser];
//    [self deleteAllRecordsForType:homePosts];
//    [self deleteAllRecordsForType:publicPosts];
}
@end
