//
//  AuctionItemList.h
//  Tradologie
//
//  Created by Chandresh Maurya on 13/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol AuctionItemListData <NSObject>
@end

@interface AuctionItemList : JSONModel
@property (nonatomic,strong)NSString *message;
@property (nonatomic,strong)NSMutableArray <AuctionItemListData> *detail;
@property (assign) BOOL success;
@end


@interface AuctionItemListData : JSONModel

@property (nonatomic,strong)NSNumber *Quantity;
@property (nonatomic,strong)NSString *Unit;
@property (nonatomic,strong)NSNumber *CustomerID;
@property (nonatomic,strong)NSString *AuctionTranID;
@property (nonatomic,strong)NSNumber *GroupID;
@property (nonatomic,strong)NSString *GroupName;
@property (nonatomic,strong)NSString *PackingSize;
@property (nonatomic,strong)NSString *PackingType;
@property (nonatomic,strong)NSString *PackingImage;
@property (nonatomic,strong)NSString *CategoryName;
@property (nonatomic,strong)NSString <Optional>*CustomCategory;
@property (nonatomic,strong)NSString *AttributeValue1;
@property (nonatomic,strong)NSString *AttributeValue2;


@end

