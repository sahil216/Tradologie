//
//  EDServices.h
//  Tradologie
//
//  Created by Chandresh on 8/9/16.
//  Copyright © 2016 Chandresh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TRApiManagerCompletion)(id response,NSString *error,BOOL status);
typedef void(^EDApiPageCompletion)(id response,NSString *error,NSInteger pageCount);
typedef void(^TRApiPageRequestCompletion)(id response,NSString *error);

@interface MBAPIManager : NSObject

void MBCall_LoginUserUsing(NSDictionary* params,TRApiManagerCompletion completion);
void MBCall_RegisterUserWithPostData(NSDictionary *dict ,NSData *image_data,TRApiManagerCompletion completion);
void MBCall_GetAllCategories(TRApiManagerCompletion completion);
void MBCall_GetTimeZoneWithCountryandBuyerInterested(NSDictionary* params,TRApiManagerCompletion completion);
void MBCall_GetStateListWithCountryName(NSDictionary* params,TRApiManagerCompletion completion);
void MBCall_GetCityListWithStateName(NSDictionary* params,TRApiManagerCompletion completion);
void MBCall_GetUpdateCompulsoryDetails(NSDictionary* params,TRApiManagerCompletion completion);
void MBCall_RegisterUserWithSocailMedia(NSDictionary *params,NSData *image_data,TRApiManagerCompletion completion);
void MBCall_GetDashBoardNotificationDetails(NSDictionary* params,TRApiManagerCompletion completion);
void MBCall_GetAuctionListUsingDashboardApi(NSDictionary* params,TRApiManagerCompletion completion);
void MBCall_GetCategoryListForNegotiation(TRApiManagerCompletion completion);
void MBCall_GetSuplierlistWithCategoryID(NSDictionary* params,TRApiManagerCompletion completion);
void MBCall_AddSupplierShortlist(NSDictionary* params,TRApiManagerCompletion completion);
void MBCall_RemoveSupplierShortlist(NSDictionary* params,TRApiManagerCompletion completion);
void MBCall_CreateNegotiationWithAuction(NSDictionary* params,TRApiManagerCompletion completion);
void MBCall_AddUpdateAuctionforNegotiation(NSDictionary* params,TRApiManagerCompletion completion);
void MBCall_GetAuctionOrderHistoryWithID(NSDictionary* params,TRApiManagerCompletion completion);
void MBCall_GetSupplierShortListedWithGroupID(NSDictionary* params,TRApiManagerCompletion completion);
void MBCall_AuctionDetailForEditNegotiation(NSDictionary* params,TRApiManagerCompletion completion);
//void MBCall_AuctionItemListWithProductList(NSDictionary* params,TRApiManagerCompletion completion);
void MBCall_AuctionItemListWithProductList(NSDictionary* params,BOOL btnValue,TRApiManagerCompletion completion);

void MBCall_AuctionSupplierWithAuctionID(NSDictionary* params,TRApiManagerCompletion completion);
void MBCall_GetAuctionOrderProcessDetailWithAuctionCode(NSDictionary* params,TRApiManagerCompletion completion);
void MBCall_GetAuctionOrderProcessItemListWithAuctionCodeandPONO(NSDictionary* params,TRApiManagerCompletion completion);
void MBCall_GetAuctionItemDetailAccordingtoCategoryID(NSDictionary* params,TRApiManagerCompletion completion);
void MBCall_AddAuctionItemProductAPI(NSDictionary* params,TRApiManagerCompletion completion);
void MBCall_AddPackingImageUploadAPI(NSDictionary *params , NSData *image_data ,TRApiManagerCompletion completion);
void MBCall_GETAddAuctionSupplierAPI(NSString *strGroupID ,TRApiManagerCompletion completion);
void MBCall_DeleteAuctionItemWithData(NSDictionary* params,TRApiManagerCompletion completion);
void MBCall_AddAuctionSupplierWithNegotiationCustomerIdAPI(NSDictionary* params,TRApiManagerCompletion completion);
void MBCall_AuctionChargesDetailAPI(NSDictionary* params,TRApiManagerCompletion completion);
void MBCall_AuctionOffLinePaymentWithCustomerIdAPI(NSDictionary* params,TRApiManagerCompletion completion);

@end
