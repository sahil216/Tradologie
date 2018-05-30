//
//  SupplierDetail.h
//  Tradologie
//
//  Created by Chandresh Maurya on 29/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol SupplierDetailData <NSObject>
@end

@interface SupplierDetail : JSONModel

@property (nonatomic,strong)NSString *message;
@property (nonatomic,strong)NSMutableArray <SupplierDetailData> *detail;
@property (assign) BOOL success;

@end

@interface SupplierDetailData : JSONModel

@property (nonatomic,strong)NSString <Optional>*AnnualTurnOver;
@property (nonatomic,strong)NSString <Optional>*AreaOfOperation;
@property (nonatomic,strong)NSString <Optional>*Certifications;
@property (nonatomic,strong)NSString *CompanyName;
@property (nonatomic,strong)NSString *CountryID;
@property (nonatomic,strong)NSString *AuctionName;
@property (nonatomic,strong)NSString *CountryName;
@property (nonatomic,strong)NSString <Optional>*FileType;
@property (assign) BOOL Manufacturer;
@property (nonatomic,strong)NSNumber *MembershipTypeID;
@property (nonatomic,strong)NSString *MembershipTypeImage;
@property (nonatomic,strong)NSString *Priority;
@property (nonatomic,strong)NSString *Rating;
@property (nonatomic,strong)NSNumber *ShortlistID;
@property (nonatomic,strong)NSString *Trader;
@property (nonatomic,strong)NSString *VendorCode;
@property (nonatomic,strong)NSString <Optional>*VendorDescription;
@property (nonatomic,strong)NSString <Optional>*VendorDocumentType;
@property (nonatomic,strong)NSString *VendorID;
@property (nonatomic,strong)NSString *VendorLogo;
@property (nonatomic,strong)NSString *VendorName;
@property (nonatomic,strong)NSString *VendorShortName;
@property (nonatomic,strong)NSString *VendorUserID;
@property (assign) BOOL Verified;

@property (nonatomic,strong)NSString <Optional>*WebLink;
@property (nonatomic,strong)NSString <Optional>*WebURL;
@property (nonatomic,strong)NSString <Optional>*YearOfEstablishment;

@end
