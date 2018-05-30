//
//  EDServices.h
//  Florists
//
//  Created by Anil Khanna on 14/02/15.
//  Copyright (c) 2015 Anil Khanna. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RMApiManagerCompletion)(id response,NSString *error,BOOL status);
typedef void(^EDApiPageCompletion)(id response,NSString *error,NSInteger pageCount);
typedef void(^RMApiPageRequestCompletion)(id response,NSString *error);

@interface MBAPIManager : NSObject

void MBCall_LoginUserUsing(NSDictionary* params,RMApiManagerCompletion completion);
void MBCall_RegisterUserWithPostData(NSDictionary *dict ,NSData *image_data,RMApiManagerCompletion completion);
void MBCall_GetAllCategories(RMApiManagerCompletion completion);
void MBCall_GetTimeZoneWithCountryandBuyerInterested(NSDictionary* params,RMApiManagerCompletion completion);
void MBCall_GetStateListWithCountryName(NSDictionary* params,RMApiManagerCompletion completion);
void MBCall_GetCityListWithStateName(NSDictionary* params,RMApiManagerCompletion completion);
void MBCall_GetUpdateCompulsoryDetails(NSDictionary* params,RMApiManagerCompletion completion);
void MBCall_RegisterUserWithSocailMedia(NSDictionary *params,NSData *image_data,RMApiManagerCompletion completion);
void MBCall_GetDashBoardNotificationDetails(NSDictionary* params,RMApiManagerCompletion completion);
void MBCall_GetAuctionListUsingDashboardApi(NSDictionary* params,RMApiManagerCompletion completion);
void MBCall_GetCategoryListForNegotiation(RMApiManagerCompletion completion);
void MBCall_GetSuplierlistWithCategoryID(NSDictionary* params,RMApiManagerCompletion completion);
void MBCall_AddSupplierShortlist(NSDictionary* params,RMApiManagerCompletion completion);
void MBCall_RemoveSupplierShortlist(NSDictionary* params,RMApiManagerCompletion completion);
void MBCall_CreateNegotiationWithAuction(NSDictionary* params,RMApiManagerCompletion completion);


@end
