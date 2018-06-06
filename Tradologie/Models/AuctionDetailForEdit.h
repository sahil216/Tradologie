//
//  AuctionDetailForEdit.h
//  Tradologie
//
//  Created by Chandresh Maurya on 06/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@class AuctionDetailForEditData;
@protocol AuctionDetailForEditData <NSObject>
@end


@interface AuctionDetailForEdit : JSONModel
@property (nonatomic,strong)NSString *message;
@property (nonatomic,strong)AuctionDetailForEditData *detail;
@property (assign) BOOL success;
@end


@interface AuctionDetailForEditData : JSONModel

@property (nonatomic,strong)NSString *AuctionCode;
@property (nonatomic,strong)NSString *AuctionName;
@property (nonatomic,strong)NSString *Status;
@property (nonatomic,strong)NSString *PreferredDate;
@property (nonatomic,strong)NSString <Optional>*StartDate;
@property (nonatomic,strong)NSString <Optional>*EndDate;
@property (nonatomic,strong)NSString *DeliveryAddressID;
@property (nonatomic,strong)NSNumber *AgencyID;
@property (nonatomic,strong)NSString *AgencyCompanyName;
@property (nonatomic,strong)NSString *DeliveryAddress;
@property (nonatomic,strong)NSString *DeliveryState;
@property (nonatomic,strong)NSString *PortOfDischarge;
@property (nonatomic,strong)NSString *PaymentTerm;
@property (nonatomic,strong)NSString <Optional>*LCFileType;
@property (nonatomic,strong)NSString <Optional>*LCFileUrl;
@property (nonatomic,strong)NSString *BankerName;
@property (nonatomic,strong)NSNumber *CurrencyID;
@property (nonatomic,strong)NSString *CurrencyName;
@property (nonatomic,strong)NSString *PartialDelivery;
@property (nonatomic,strong)NSNumber *AuctionID;
@property (nonatomic,strong)NSNumber *AuctionGroupID;
@property (nonatomic,strong)NSString *TotalQuantity;
@property (nonatomic,strong)NSString *MinQuantity;
@property (nonatomic,strong)NSString *DeliveryLastDate;
@property (nonatomic,strong)NSString *AgencyName;
@property (nonatomic,strong)NSString *AgencyAddress;
@property (nonatomic,strong)NSString *AgencyPhone;
@property (nonatomic,strong)NSString *AgencyEmail;
@property (nonatomic,strong)NSString *Remarks;
@property (nonatomic,strong)NSNumber *CustomerID;

@end

