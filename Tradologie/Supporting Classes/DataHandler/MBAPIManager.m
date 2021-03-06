//
//  EDServices.m
//  Tradologie
//
//  Created by Chandresh on 8/9/16.
//  Copyright © 2016 Chandresh. All rights reserved.
//

#import "MBAPIManager.h"
#import "MBHTTPClient.h"
#import "MBErrorUtility.h"
#import "AppConstant.h"
#import <AFNetworking/AFURLResponseSerialization.h>

#define getUrlForMethod(v) [[HOST_URL stringByAppendingString:v]stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]

@implementation MBAPIManager : NSObject

void MBCall_CancelAllRequest(){
    [[MBHTTPClient  sharedInstance]cancelAllOperation];
}

NSString* checkIfResponseHasErrorMessage(id response){
    if (!response) {
        return @"Issue with server response. Please contact admin.";
    }
    
    if (![response isKindOfClass:[NSDictionary class]]) {
        return @"Issue with server response. Please contact admin.";
    }
    if (!response) {
        return @"Issue with server response. Please contact admin";
    }
    
    if ([response isKindOfClass:[NSDictionary class]] && ![response[@"status"] boolValue]) {
        return response[@"message"];
    }
    
    
    return nil;
}


#pragma mark - Filter error message

NSString *filterErrorMessageUsingResponseRequestOperation(NSURLSessionDataTask *operation, NSError *error)
{
    NSDictionary *jsonResponse;
    
    //return error.localizedDescription;
    NSData *responseData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
    
    if (responseData) {
        jsonResponse = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
    }
    
    NSInteger errorCode = [[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
    
    
    if (errorCode == 401)
    {
        
        if([jsonResponse[@"message"] isEqualToString:@"You have been logged out, please log in again."]){
            
            //            [MBDataBaseHandler clearAllDataBase];
            //
            //            [MBAppInitializer moveToLoginViewController];
            //
            //            [APP_DELEGATE show_ErrorAlertWithTitle:@"" withMessage:jsonResponse[@"message"]];
        }
        
        return jsonResponse[@"message"];
    }
    
    if(errorCode == 0 && jsonResponse && jsonResponse[@"message"])
    {
        return [MBErrorUtility handlePredefinedErrorCode:error.code andMessage:jsonResponse[@"message"]];
    }
    else if (errorCode == 0)
    {
        return [MBErrorUtility handlePredefinedErrorCode:error.code andMessage:error.localizedDescription];
    }
    
    if (jsonResponse) {
        
        //                if (errorCode==401) {
        //                    [FlowManager presentLoginScreenAnimatedly:YES];
        //                    return @"Your account has been accessed from different device!";
        //
        //                }
        //
        
        if (![jsonResponse[@"message"] isEqualToString:@""]&&jsonResponse[@"message"]!=nil) {
            return jsonResponse[@"message"];
        }
        if (![jsonResponse[@"errors"] isEqualToString:@""]&&jsonResponse[@"errors"]!=nil) {
            return jsonResponse[@"errors"];
        }
    }
    
    return [MBErrorUtility handlePredefinedErrorCode:errorCode andMessage:@"Issue with server response. Please contact admin."];
}

void MBCall_LoginUserUsing(NSDictionary* params,TRApiManagerCompletion completion){
    
    [[MBHTTPClient sharedInstance] requestPOSTServiceOnURL:getUrlForMethod(LOGIN_API_NAME) WithDictionary:params withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response)
     {
         
         if (error)
         {
             completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
             return ;
         }
         else if(response)
         {
             //  NSHTTPURLResponse *responseTask = (NSHTTPURLResponse*)task.response;
             
             //  SAVE_USER_DEFAULTS([[responseTask allHeaderFields] valueForKey:K_ACCESSTOKEN], K_ACCESSTOKEN);
             
             completion(response,checkIfResponseHasErrorMessage(response),YES);
             
         }
     }];
    
}

void MBCall_RegisterUserWithPostData(NSDictionary *params ,NSData *image_data,TRApiManagerCompletion completion)
{
    
    [[MBHTTPClient sharedInstance] requestPOSTServiceOnURL:getUrlForMethod(REGISTER_API_NAME) WithDictionary:params withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response)
     {
         if(!error && response){
             completion(response,checkIfResponseHasErrorMessage(response),YES);
             // NSHTTPURLResponse *responseTask = (NSHTTPURLResponse*)task.response;
             // SAVE_USER_DEFAULTS([[responseTask allHeaderFields] valueForKey:K_ACCESSTOKEN], K_ACCESSTOKEN);
         }
         
         else {
             completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
             return ;
         }
         
     }];
}
void MBCall_RegisterUserWithSocailMedia(NSDictionary *params,NSData *image_data,TRApiManagerCompletion completion)
{
    
    [[MBHTTPClient sharedInstance] requestPOSTServiceOnURL:getUrlForMethod(REGISTER_WITH_SOCAIL_MEDIA) WithDictionary:params withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response)
     {
         if(!error && response){
             completion(response,checkIfResponseHasErrorMessage(response),YES);
             // NSHTTPURLResponse *responseTask = (NSHTTPURLResponse*)task.response;
             // SAVE_USER_DEFAULTS([[responseTask allHeaderFields] valueForKey:K_ACCESSTOKEN], K_ACCESSTOKEN);
         }
         
         else {
             completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
             return ;
         }
         
     }];
}

void MBCall_GetAllCategories(TRApiManagerCompletion completion)
{
    [[MBHTTPClient sharedInstance] requestGETServiceOnURL:getUrlForMethod(CATEGORY_API_NAME) WithDictionary:nil withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response) {
        if(error)
        {
            completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
        }
        else
        {
            completion(response,checkIfResponseHasErrorMessage(response),YES);
            
        }
    }];
}
void MBCall_GetTimeZoneWithCountryandBuyerInterested(NSDictionary* params,TRApiManagerCompletion completion)
{
    [[MBHTTPClient sharedInstance] requestPOSTServiceOnURL:getUrlForMethod(COMMON_API) WithDictionary:params withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response)
     {
         if (error)
         {
             completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
             return ;
         }
         else if(response)
         {
             completion(response,checkIfResponseHasErrorMessage(response),YES);
             
         }
     }];
    
}

void MBCall_GetStateListWithCountryName(NSDictionary* params,TRApiManagerCompletion completion)
{
    [[MBHTTPClient sharedInstance] requestPOSTServiceOnURL:getUrlForMethod(STATE_LIST_API) WithDictionary:params withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response)
     {
         if (error)
         {
             completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
             return ;
         }
         else if(response)
         {
             completion(response,checkIfResponseHasErrorMessage(response),YES);
             
         }
     }];
    //
}
void MBCall_GetCityListWithStateName(NSDictionary* params,TRApiManagerCompletion completion)
{
    [[MBHTTPClient sharedInstance] requestPOSTServiceOnURL:getUrlForMethod(City_LIST_API) WithDictionary:params withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response)
     {
         if (error)
         {
             completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
             return ;
         }
         else if(response)
         {
             completion(response,checkIfResponseHasErrorMessage(response),YES);
             
         }
     }];
    //
}
void MBCall_GetUpdateCompulsoryDetails(NSDictionary* params,TRApiManagerCompletion completion)
{
    [[MBHTTPClient sharedInstance] requestPOSTServiceOnURL:getUrlForMethod(UPDATE_COMPULSORY_DETAIL_API) WithDictionary:params withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response)
     {
         if (error)
         {
             completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
             return ;
         }
         else if(response)
         {
             completion(response,checkIfResponseHasErrorMessage(response),YES);
             
         }
     }];
    //
}
void MBCall_GetDashBoardNotificationDetails(NSDictionary* params,TRApiManagerCompletion completion)
{
    [[MBHTTPClient sharedInstance] requestPOSTServiceOnURL:getUrlForMethod(DASHBOARD_NOTIFICATION_API) WithDictionary:params withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response)
     {
         if (error)
         {
             completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
             return ;
         }
         else if(response)
         {
             completion(response,checkIfResponseHasErrorMessage(response),YES);
         }
     }];
}
void MBCall_GetAuctionListUsingDashboardApi(NSDictionary* params,TRApiManagerCompletion completion)
{
    [[MBHTTPClient sharedInstance] requestPOSTServiceOnURL:getUrlForMethod(AUCTION_LIST_API) WithDictionary:params withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response)
     {
         if (error)
         {
             completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
             return ;
         }
         else if(response)
         {
             completion(response,checkIfResponseHasErrorMessage(response),YES);
             
         }
     }];
}

void MBCall_GetCategoryListForNegotiation(TRApiManagerCompletion completion)
{
    [[MBHTTPClient sharedInstance] requestGETServiceOnURL:getUrlForMethod(CATEGORY_NEGOTIATION_API) WithDictionary:nil withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response) {
        if(error)
        {
            completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
        }
        else
        {
            completion(response,checkIfResponseHasErrorMessage(response),YES);
            
        }
    }];
}
void MBCall_GetSuplierlistWithCategoryID(NSDictionary* params,TRApiManagerCompletion completion)
{
    NSString *strvalue = [NSString stringWithFormat:@"%@",[params valueForKey:@"categoryID"]];
    NSString *strCategoryID = [NSString stringWithFormat:@"%@",[params valueForKey:@"CustomerID"]];
    
    NSString *strParameters = [[[[SUPPLIER_LIST_API stringByAppendingString:@"/"] stringByAppendingString:strvalue] stringByAppendingString:@"/"] stringByAppendingString:strCategoryID];
    
    
    [[MBHTTPClient sharedInstance] requestGETServiceOnURL:getUrlForMethod(strParameters) WithDictionary:nil withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response) {
        if(error)
        {
            completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
        }
        else
        {
            completion(response,checkIfResponseHasErrorMessage(response),YES);
            
        }
    }];
}

void MBCall_AddSupplierShortlist(NSDictionary* params,TRApiManagerCompletion completion)
{
    [[MBHTTPClient sharedInstance] requestPOSTServiceOnURL:getUrlForMethod(ADD_SUPPLIER_SHORTLIST_API) WithDictionary:params withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response)
     {
         if (error)
         {
             completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
             return ;
         }
         else if(response)
         {
             completion(response,checkIfResponseHasErrorMessage(response),YES);
             
         }
     }];
}
void MBCall_RemoveSupplierShortlist(NSDictionary* params,TRApiManagerCompletion completion)
{
    [[MBHTTPClient sharedInstance] requestPOSTServiceOnURL:getUrlForMethod(REMOVE_SUPPLIER_SHORTLIST_API) WithDictionary:params withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response)
     {
         if (error)
         {
             completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
             return ;
         }
         else if(response)
         {
             completion(response,checkIfResponseHasErrorMessage(response),YES);
             
         }
     }];
}
//http://api.tradologie.com/Buyer/createauction
void MBCall_CreateNegotiationWithAuction(NSDictionary* params,TRApiManagerCompletion completion)
{
    [[MBHTTPClient sharedInstance] requestPOSTServiceOnURL:getUrlForMethod(CREATE_NEGOTIATION_API) WithDictionary:params withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response)
     {
         if (error)
         {
             completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
             return;
         }
         else if(response)
         {
             completion(response,checkIfResponseHasErrorMessage(response),YES);
             
         }
     }];
}
void MBCall_AddUpdateAuctionforNegotiation(NSDictionary* params,TRApiManagerCompletion completion)
{
    [[MBHTTPClient sharedInstance] requestPOSTServiceOnURL:getUrlForMethod(ADD_UPDATE_NEGOTIATION_API) WithDictionary:params withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response)
     {
         if (error)
         {
             completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
             return;
         }
         else if(response)
         {
             completion(response,checkIfResponseHasErrorMessage(response),YES);
             
         }
     }];
}

void MBCall_GetAuctionOrderHistoryWithID(NSDictionary* params,TRApiManagerCompletion completion)
{
    [[MBHTTPClient sharedInstance] requestPOSTServiceOnURL:getUrlForMethod(AUCTION_ORDER_HISTORY_API) WithDictionary:params withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response)
     {
         if (error)
         {
             completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
             return;
         }
         else if(response)
         {
             completion(response,checkIfResponseHasErrorMessage(response),YES);
             
         }
     }];
}

void MBCall_GetSupplierShortListedWithGroupID(NSDictionary* params,TRApiManagerCompletion completion)
{
    NSString *strvalue = [NSString stringWithFormat:@"%@",[params valueForKey:@"GroupID"]];
    NSString *strCategoryID = [NSString stringWithFormat:@"%@",[params valueForKey:@"CustomerID"]];
    
    NSString *strParameters = [[[[SUPPLIER_SHORTLIST_API stringByAppendingString:@"/"] stringByAppendingString:strvalue] stringByAppendingString:@"/"] stringByAppendingString:strCategoryID];
    
    
    [[MBHTTPClient sharedInstance] requestGETServiceOnURL:getUrlForMethod(strParameters) WithDictionary:nil withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response) {
        if(error)
        {
            completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
        }
        else
        {
            completion(response,checkIfResponseHasErrorMessage(response),YES);
            
        }
    }];
}

void MBCall_AuctionDetailForEditNegotiation(NSDictionary* params,TRApiManagerCompletion completion)
{
    [[MBHTTPClient sharedInstance] requestPOSTServiceOnURL:getUrlForMethod(AUCTION_DETAIL_FOR_EDIT_API) WithDictionary:params withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response)
     {
         if (error)
         {
             completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
             return;
         }
         else if(response)
         {
             completion(response,checkIfResponseHasErrorMessage(response),YES);
             
         }
     }];
}
void MBCall_AuctionItemListWithProductList(NSDictionary* params,BOOL btnValue,TRApiManagerCompletion completion)
{
    NSString *strURL;
    
    if(btnValue == YES)
    {
        strURL = AUCTION_ITEM_LIST_EDIT_API;
    }
    else{
        strURL = AUCTION_ITEM_LIST_API;
    }
    [[MBHTTPClient sharedInstance] requestPOSTServiceOnURL:getUrlForMethod(strURL) WithDictionary:params withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response)
     {
         if (error)
         {
             completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
             return;
         }
         else if(response)
         {
             completion(response,checkIfResponseHasErrorMessage(response),YES);
             
         }
     }];
}

void MBCall_AuctionSupplierWithAuctionID(NSDictionary* params,TRApiManagerCompletion completion)
{
    [[MBHTTPClient sharedInstance] requestPOSTServiceOnURL:getUrlForMethod(AUCTION_SUPPLIER_LIST_API) WithDictionary:params withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response)
     {
         if (error)
         {
             completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
             return;
         }
         else if(response)
         {
             completion(response,checkIfResponseHasErrorMessage(response),YES);
             
         }
     }];
}
void MBCall_GetAuctionOrderProcessDetailWithAuctionCode(NSDictionary* params,TRApiManagerCompletion completion)
{
    [[MBHTTPClient sharedInstance] requestPOSTServiceOnURL:getUrlForMethod(AUCTION_ORDER_PROCESS_API) WithDictionary:params withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response)
     {
         if (error)
         {
             completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
             return;
         }
         else if(response)
         {
             completion(response,checkIfResponseHasErrorMessage(response),YES);
             
         }
     }];
}

void MBCall_GetAuctionOrderProcessItemListWithAuctionCodeandPONO(NSDictionary* params,TRApiManagerCompletion completion)
{
    [[MBHTTPClient sharedInstance] requestPOSTServiceOnURL:getUrlForMethod(AUCTION_ORDER_PROCESS_ITEM_API) WithDictionary:params withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response)
     {
         if (error)
         {
             completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
             return;
         }
         else if(response)
         {
             completion(response,checkIfResponseHasErrorMessage(response),YES);
             
         }
     }];
}
void MBCall_GetAuctionItemDetailAccordingtoCategoryID(NSDictionary* params,TRApiManagerCompletion completion)
{
    [[MBHTTPClient sharedInstance] requestPOSTServiceOnURL:getUrlForMethod(AUCTION_ITEM_DETAIL_CATEGORYID) WithDictionary:params withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response)
     {
         if (error)
         {
             completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
             return;
         }
         else if(response)
         {
             completion(response,checkIfResponseHasErrorMessage(response),YES);
             
         }
     }];
}
void MBCall_AddAuctionItemProductAPI(NSDictionary* params,TRApiManagerCompletion completion)
{
    [[MBHTTPClient sharedInstance] requestPOSTServiceOnURL:getUrlForMethod(ADD_AUCTION_PRODUCT_ITEM) WithDictionary:params withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response)
     {
         if (error)
         {
             completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
             return;
         }
         else if(response)
         {
             completion(response,checkIfResponseHasErrorMessage(response),YES);
             
         }
     }];
}


void MBCall_AddPackingImageUploadAPI(NSDictionary *params , NSData *image_data ,TRApiManagerCompletion completion)
{
    [[MBHTTPClient sharedInstance] requestPOSTMultipartServiceOnURL:getUrlForMethod(ADD_AUCTION_PACKING_IMAGE) withData:image_data withParametes:params withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response)
     {
         if (error)
         {
             completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
             return;
         }
         else if(response)
         {
             completion(response,checkIfResponseHasErrorMessage(response),YES);
         }
     }];
}

void MBCall_GETAddAuctionSupplierAPI(NSString *strGroupID ,TRApiManagerCompletion completion)
{
    NSString *strParameters = [[ADD_AUCTION_SUPPLIER stringByAppendingString:@"/"] stringByAppendingString:strGroupID];
    
    [[MBHTTPClient sharedInstance] requestGETServiceOnURL:getUrlForMethod(strParameters) WithDictionary:nil withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response) {
        if(error)
        {
            completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
        }
        else
        {
            completion(response,checkIfResponseHasErrorMessage(response),YES);
            
        }
    }];
    
}
void MBCall_DeleteAuctionItemWithData(NSDictionary* params,TRApiManagerCompletion completion)
{
    [[MBHTTPClient sharedInstance] requestPOSTServiceOnURL:getUrlForMethod(DELETE_AUCTION_ITEM) WithDictionary:params withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response)
     {
         if (error)
         {
             completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
             return;
         }
         else if(response)
         {
             completion(response,checkIfResponseHasErrorMessage(response),YES);
             
         }
     }];
}
void MBCall_AuctionChargesDetailAPI(NSDictionary* params,TRApiManagerCompletion completion)
{
    [[MBHTTPClient sharedInstance] requestPOSTServiceOnURL:getUrlForMethod(AUCTION_CHARGE_DETAIL_API) WithDictionary:params withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response)
     {
         if (error)
         {
             completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
             return;
         }
         else if(response)
         {
             completion(response,checkIfResponseHasErrorMessage(response),YES);
             
         }
     }];
}
//
void MBCall_AddAuctionSupplierWithNegotiationCustomerIdAPI(NSDictionary* params,TRApiManagerCompletion completion)
{
    [[MBHTTPClient sharedInstance] requestPOSTServiceOnURL:getUrlForMethod(ADD_AUCTION_SUPPLIERID_API) WithDictionary:params withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response)
     {
         if (error)
         {
             completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
             return;
         }
         else if(response)
         {
             completion(response,checkIfResponseHasErrorMessage(response),YES);
             
         }
     }];
}

void MBCall_AuctionOffLinePaymentWithCustomerIdAPI(NSDictionary* params,TRApiManagerCompletion completion)
{
    [[MBHTTPClient sharedInstance] requestPOSTServiceOnURL:getUrlForMethod(ADD_AUCTION_OFFLINE_PAYMENT_API) WithDictionary:params withCompletion:^(NSURLSessionDataTask *task, NSError *error, id response)
     {
         if (error)
         {
             completion(nil,filterErrorMessageUsingResponseRequestOperation(task, error),NO);
             return;
         }
         else if(response)
         {
             completion(response,checkIfResponseHasErrorMessage(response),YES);
             
         }
     }];
}
@end
