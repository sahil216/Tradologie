//
//  AuctionOrderHistory.h
//  Tradologie
//
//  Created by Chandresh Maurya on 05/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol OrderHistoryData <NSObject>
@end


@interface AuctionOrderHistory : JSONModel

@property (nonatomic,strong)NSString *message;
@property (nonatomic,strong)NSMutableArray <OrderHistoryData> *detail;
@property (assign) BOOL success;

@end


@interface OrderHistoryData : JSONModel

@property (nonatomic,strong)NSString *AuctionCode;
@property (nonatomic,strong)NSString *VendorName;
@property (nonatomic,strong)NSString <Optional>*ReferenceNo;
@property (nonatomic,strong)NSString *PONo;
@property (nonatomic,strong)NSString *AccountDocumentCount;
@property (nonatomic,strong)NSString *OrderStatus;
@property (nonatomic,strong)NSNumber *TotalOrderQty;
@property (nonatomic,strong)NSString *StartDate;
@property (nonatomic,strong)NSString *EndDate;


@end
