//
//  NegotiationDetail.h
//  Tradologie
//
//  Created by Chandresh Maurya on 31/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@class NegotiationDetailData;

@protocol NegotiationDetailData <NSObject>
@end

@protocol InspectionAgencyList <NSObject>
@end

@protocol CustomerAddressList <NSObject>
@end

@protocol CurrencyList <NSObject>
@end

@interface NegotiationDetail : JSONModel
@property (nonatomic,strong)NSString *message;
@property (nonatomic,strong)NegotiationDetailData *detail;
@property (assign) BOOL success;
@end

@interface NegotiationDetailData : JSONModel
@property (nonatomic,strong)NSString *AuctionGroup;
@property (nonatomic,strong)NSString *AuctionCode;
@property (nonatomic,strong)NSNumber *MinAuctionQty;
@property (nonatomic,strong)NSNumber *MinDaysDiffDeliveryLastDate;
@property (nonatomic,strong)NSNumber *MaxDaysDiffDeliveryLastDate;
@property (nonatomic,strong)NSMutableArray <InspectionAgencyList>*InspectionAgencyList;
@property (nonatomic,strong)NSMutableArray <CustomerAddressList>*CustomerAddressList;
@property (nonatomic,strong)NSMutableArray <CurrencyList>*CurrencyList;

@end

@interface InspectionAgencyList : JSONModel
@property (nonatomic,strong)NSNumber *InspectionAgencyID;
@property (nonatomic,strong)NSString *InspectionCompanyName;
@end

@interface CustomerAddressList : JSONModel
@property (nonatomic,strong)NSString *Address;
@property (nonatomic,strong)NSString *AddressValue;
@end

@interface CurrencyList : JSONModel
@property (nonatomic,strong)NSNumber *CurrencyID;
@property (nonatomic,strong)NSString *CurrencyName;
@end
