//
//  AuctionDetail.h
//  Tradologie
//
//  Created by Chandresh Maurya on 25/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"


@protocol AuctionData <NSObject>
@end

@interface AuctionDetail : JSONModel
@property (nonatomic,strong)NSString *message;
@property (nonatomic,strong)NSMutableArray <AuctionData> *detail;
@property (assign) BOOL success;
@end


@interface AuctionData : JSONModel
@property (nonatomic,strong)NSString *AuctionCode;
@property (nonatomic,strong)NSNumber *AuctionID;
@property (nonatomic,strong)NSNumber *CustomerID;
@property (nonatomic,strong)NSString *AuctionName;
@property (nonatomic,strong)NSString *DeliveryAddress;
@property (nonatomic,strong)NSString *DeliveryState;
@property (nonatomic,strong)NSString *EndDate;
@property (assign) BOOL Isclosed;
@property (assign) BOOL IsStarted;
@property (nonatomic,strong)NSString *PartialDelivery;
@property (nonatomic,strong)NSString *PaymentTerm;
@property (nonatomic,strong)NSString *PreferredDate;
@property (nonatomic,strong)NSString *StartDate;
@property (nonatomic,strong)NSString *Status;
@end

