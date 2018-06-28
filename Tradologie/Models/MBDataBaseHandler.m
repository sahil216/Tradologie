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
+(LiveAuctionData *)getliveAuctionDataUsingDashBoard
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(objType == %@)",[NSNumber numberWithInt:dashboardDetail]];
    
    NSArray *array = [OfflineObject MR_findAllWithPredicate:predicate];
    
    if (array.count>0)
    {
        OfflineObject *object = array[0];
        LiveAuctionData *objCommondata = [[LiveAuctionData alloc] initWithString:object.objData error:nil];
        return objCommondata;
    }
    
    return nil;
}
+(AuctionDetail *)getAuctionDetail
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

+(SupplierDetail *)getSupplierDetailData
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
+(NegotiationDetail *)getNegotiationDetailData
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
+(AuctionOrderHistory *)getAuctionOrderHistory
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
+(AuctionItemList *)getAuctionItemListWithData
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(objType == %@)",[NSNumber numberWithInt:auctionItem]];
    
    NSArray *array = [OfflineObject MR_findAllWithPredicate:predicate];
    
    if (array.count>0)
    {
        OfflineObject *object = array[0];
        AuctionItemList *objAuctionItemList = [[AuctionItemList alloc] initWithString:object.objData error:nil];
        return objAuctionItemList;
    }
    
    return nil;
}
+(AuctionSupplierList *)getAuctionSupplierListWithData
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(objType == %@)",[NSNumber numberWithInt:auctionSupplier]];
    
    NSArray *array = [OfflineObject MR_findAllWithPredicate:predicate];
    
    if (array.count>0)
    {
        OfflineObject *object = array[0];
        AuctionSupplierList *objAuctionItemList = [[AuctionSupplierList alloc] initWithString:object.objData error:nil];
        return objAuctionItemList;
    }
    
    return nil;
}
+(CategoryDetail *)getCategoryDetailItemListWithData
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(objType == %@)",[NSNumber numberWithInt:categoryItemDetail]];
    
    NSArray *array = [OfflineObject MR_findAllWithPredicate:predicate];
    
    if (array.count>0)
    {
        OfflineObject *object = array[0];
        CategoryDetail *objCategoryDetail = [[CategoryDetail alloc] initWithString:object.objData error:nil];
        return objCategoryDetail;
    }
    
    return nil;
}
+(NSString *)getAuctionOrderProcessItemWithData
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(objType == %@)",[NSNumber numberWithInt:auctionOrderProcessItem]];
    
    NSArray *array = [OfflineObject MR_findAllWithPredicate:predicate];
    
    if (array.count>0)
    {
        OfflineObject *object = array[0];
        NSString *listData = object.objData;
        return listData;
    }
    
    return nil;
}
+(NSMutableDictionary *)getAuctionSupplierListData
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(objType == %@)",[NSNumber numberWithInt:auctionSupplierList]];
    
    NSArray *array = [OfflineObject MR_findAllWithPredicate:predicate];
    
    if (array.count>0)
    {
        OfflineObject *object = array[0];
        NSMutableDictionary *listData  = [[NSMutableDictionary alloc]init];
        [listData setValue:object.objData forKey:@"Data"];
        [listData setValue:object.objId forKey:@"AuctionID"];
        return listData;
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
+(void)saveDashBoradLiveAuctionDataDetail:(LiveAuctionData *)Data
{
    [self deleteAllRecordsForType:dashboardDetail];
    
    if (!Data) {
        return;
    }
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext)
     {
         OfflineObject *newUser = [OfflineObject MR_createEntityInContext:localContext];
         newUser.objData = Data.toJSONString;
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
+(void)saveAuctionOrderHistory:(AuctionOrderHistory *)OrderHitoryData
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
+ (void)saveAuctionItemListData:(AuctionItemList *)auctionItemList
{
    [self deleteAllRecordsForType:auctionItem];
    
    if (!auctionItemList) {
        return;
    }
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext)
     {
         OfflineObject *newUser = [OfflineObject MR_createEntityInContext:localContext];
         newUser.objData = auctionItemList.toJSONString;
         newUser.objType = [NSNumber numberWithInt:auctionItem];
         newUser.objClass = NSStringFromClass([AuctionItemList class]);
         
     }];
}
+(void)saveAuctionSupplierListWithData:(AuctionSupplierList *)auctionSupplierList
{
    [self deleteAllRecordsForType:auctionSupplier];
    
    if (!auctionSupplierList) {
        return;
    }
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext)
     {
         OfflineObject *newUser = [OfflineObject MR_createEntityInContext:localContext];
         newUser.objData = auctionSupplierList.toJSONString;
         newUser.objType = [NSNumber numberWithInt:auctionSupplier];
         newUser.objClass = NSStringFromClass([auctionSupplierList class]);
         
     }];
    
}
+(void)saveCategoryDetailItemListWithData:(CategoryDetail *)CategoryDetailItemData
{
    [self deleteAllRecordsForType:categoryItemDetail];
    
    if (!CategoryDetailItemData) {
        return;
    }
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext)
     {
         OfflineObject *newUser = [OfflineObject MR_createEntityInContext:localContext];
         newUser.objData = CategoryDetailItemData.toJSONString;
         newUser.objType = [NSNumber numberWithInt:categoryItemDetail];
         newUser.objClass = NSStringFromClass([CategoryDetailItemData class]);
         
     }];
}
+(void)saveAuctionOrderProcessItemWithData:(NSString *)AuctionOrderProcess
{
    [self deleteAllRecordsForType:auctionOrderProcessItem];
    
    if (!AuctionOrderProcess) {
        return;
    }
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext)
     {
         OfflineObject *newUser = [OfflineObject MR_createEntityInContext:localContext];
         newUser.objData = AuctionOrderProcess;
         newUser.objType = [NSNumber numberWithInt:auctionOrderProcessItem];
         newUser.objClass = NSStringFromClass([AuctionOrderProcess class]);
         
     }];
}
+(void)savegetAuctionSupplierListData:(NSString *)AuctionSupplierList WithID:(NSNumber *)AuctionID
{
   [self deleteAllRecordsForType:auctionSupplierList];
    
    if (!AuctionSupplierList)
    {
        return;
    }
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext)
     {
         OfflineObject *newUser = [OfflineObject MR_createEntityInContext:localContext];
         newUser.objData = AuctionSupplierList;
         newUser.objId = AuctionID;
         newUser.objType = [NSNumber numberWithInt:auctionSupplierList];
         newUser.objClass = NSStringFromClass([AuctionSupplierList class]);
         
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
