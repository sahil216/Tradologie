//
//  LiveAuctionData.h
//  Tradologie
//
//  Created by Chandresh Maurya on 15/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"


@protocol LiveAuctionDetailData <NSObject>
@end
@protocol LiveAuctionDatalist <NSObject>
@end
@protocol SellerDetailList <NSObject>
@end

@interface LiveAuctionData : JSONModel

@property (nonatomic,strong)NSString *message;
@property (nonatomic,strong)NSMutableArray <LiveAuctionDetailData> *detail;
@property (assign) BOOL success;


@end

@interface LiveAuctionDetailData : JSONModel

@property (nonatomic,strong)NSNumber *AuctionNotStartCount;
@property (nonatomic,strong)NSNumber *AuctionDraftCount;
@property (nonatomic,strong)NSMutableArray <LiveAuctionDatalist> *AuctionDetail;

@end

@interface LiveAuctionDatalist : JSONModel

@property (nonatomic,strong)NSString *AuctionCode;
@property (nonatomic,strong)NSNumber *AuctionID;
@property (nonatomic,strong)NSString *AuctionName;
@property (nonatomic,strong)NSNumber *AuctionNegotiationCount;
@property (nonatomic,strong)NSString *CustomerName;
@property (nonatomic,strong)NSString *EndDate;
@property (assign) BOOL IsComplete;
@property (assign) BOOL IsGoingStart;
@property (assign) BOOL IsStarted;

@property (nonatomic,strong)NSNumber *NewSellerInputCount;
@property (nonatomic,strong)NSNumber *OrderPlaceCount;
@property (nonatomic,strong)NSNumber *PaymentDocPendingCount;

@property (nonatomic,strong)NSMutableArray <SellerDetailList> *SellerDetail;
@property (nonatomic,strong)NSString *ServerTime;
@property (nonatomic,strong)NSString *StartDate;
@property (nonatomic,strong)NSString *TimeLeft;
@property (nonatomic,strong)NSString *TimeLeftMili;
@property (nonatomic,strong)NSString *TimeRemaining;

@end

@interface SellerDetailList : JSONModel
@property (nonatomic,strong)NSString <Optional>*OrderStatus;
@property (nonatomic,strong)NSString *POReplyDate;
@property (nonatomic,strong)NSString *POTimeRemaining;
@property (nonatomic,strong)NSNumber *VendorID;

@end


