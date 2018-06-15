//
//  AuctionSupplierList.h
//  Tradologie
//
//  Created by Chandresh Maurya on 15/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"


@protocol AuctionSupplierListData <NSObject>
@end


@interface AuctionSupplierList : JSONModel
@property (nonatomic,strong)NSString *message;
@property (nonatomic,strong)NSMutableArray <AuctionSupplierListData> *detail;
@property (assign) BOOL success;
@end



@interface AuctionSupplierListData : JSONModel
@property (nonatomic,strong)NSNumber *VendorID;
@property (nonatomic,strong)NSString *VendorName;
@property (nonatomic,strong)NSString *CompanyName;

@end
