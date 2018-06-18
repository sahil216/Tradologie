//
//  AuctionOrderProcessItem.h
//  Tradologie
//
//  Created by Chandresh Maurya on 16/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@class AuctionOrderProcessItemData;


@protocol AuctionOrderProcessRate <NSObject>
@end

@protocol AuctionOrderDocumentDetail <NSObject>
@end

@interface AuctionOrderProcessItem : JSONModel

@property (nonatomic,strong)NSString *AuctionAttributeName1;
@property (nonatomic,strong)NSString *AuctionAttributeName2;
@property (nonatomic,strong)NSString *AuctionAttributeValue1;
@property (nonatomic,strong)NSString *AuctionAttributeValue2;
@property (nonatomic,strong)NSString *AuctionCategoryName;
@property (nonatomic,strong)NSString *AuctionCode;
@property (nonatomic,strong)NSString <Optional>*AuctionDescription;
@property (nonatomic,strong)NSString *AuctionGroupName;
@property (nonatomic,strong)NSNumber *AuctionID;
@property (nonatomic,strong)NSString <Optional>*AuctionItemCode;
@property (nonatomic,strong)NSString <Optional>*AuctionTranID;
@property (nonatomic,strong)NSString <Optional>*BuyerCounterOfferDate;
@property (nonatomic,strong)NSString <Optional>*BuyerProcessOrderDate;
@property (nonatomic,strong)NSString <Optional>*CurrencyCode;
@property (nonatomic,strong)NSString <Optional>*CurrencyName;
@property (nonatomic,strong)NSString *CurrentDate;
@property (nonatomic,strong)NSString <Optional>*CustomerName;
@property (assign) BOOL IsClosed;
@property (assign) BOOL IsStarted;
@property (nonatomic,strong)NSString *MinQuantity;
@property (nonatomic,strong)NSString *PackingImage;
@property (nonatomic,strong)NSString *PackingSize;
@property (nonatomic,strong)NSString *PackingType;
@property (nonatomic,strong)NSString *PaymentTerm;
@property (nonatomic,strong)NSString *Quantity;
@property (nonatomic,strong)NSMutableArray <AuctionOrderProcessRate> *Rate;
@property (nonatomic,strong)NSString *ServerTime;
@property (nonatomic,strong)NSString *TimeRemaining;
@property (nonatomic,strong)NSString *Unit;


@end

@interface AuctionOrderProcessRate : JSONModel

@property (nonatomic,strong)NSString *AcceptanceStatus;
@property (nonatomic,strong)NSString *AccountName;
@property (nonatomic,strong)NSString *AccountNo;
@property (nonatomic,strong)NSNumber *AuctionRateID;
@property (nonatomic,strong)NSString *BankName;
@property (nonatomic,strong)NSString *Branch;
@property (nonatomic,strong)NSString *BuyerDocumentReplyDate;
@property (nonatomic,strong)NSString *BuyerInspectionReplyDate;
@property (nonatomic,strong)NSString *BuyerReplyDate;
@property (nonatomic,strong)NSString *CounterRate;
@property (nonatomic,strong)NSString *CounterRemarks;
@property (nonatomic,strong)NSString *CounterStatus;
@property (nonatomic,strong)NSNumber *EscrowAmount;
@property (nonatomic,strong)NSString *IFSCCode;
@property (nonatomic,strong)NSString *InspectionReplyDate;
@property (nonatomic,strong)NSNumber <Optional>*LowestRate;
@property (nonatomic,strong)NSMutableArray <AuctionOrderDocumentDetail> *Rate;
@property (nonatomic,strong)NSNumber *OrderQuantity;
@property (nonatomic,strong)NSString <Optional>*OrderStatus;
@property (nonatomic,strong)NSString <Optional>*PONo;
@property (nonatomic,strong)NSString *POReplyDate;
@property (nonatomic,strong)NSNumber *ParticipateQuantity;
@property (nonatomic,strong)NSString *PaymentCorrectionRemarks;
@property (nonatomic,strong)NSString *PaymentReplyDate;
@property (nonatomic,strong)NSNumber *Priority;
@property (nonatomic,strong)NSString <Optional>*Remarks;
@property (nonatomic,strong)NSString *SellerCounterOfferDate;
@property (nonatomic,strong)NSString *SellerPOReplyDate;
@property (nonatomic,strong)NSString *SellerPaymentReplyDate;
@property (nonatomic,strong)NSString *SellerReplyDate;
@property (nonatomic,strong)NSString *SupplierName;
@property (nonatomic,strong)NSNumber *VendorID;
@property (nonatomic,strong)NSString *VendorShortName;

@end

@interface AuctionOrderDocumentDetail : JSONModel

@end
