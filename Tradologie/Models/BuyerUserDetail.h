//
//  BuyerUserDetail.h
//  Tradologie
//
//  Created by Chandresh Maurya on 17/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@class BuyerDetail;
@protocol BuyerDetail <NSObject>
@end

@interface BuyerUserDetail : JSONModel

@property (nonatomic,strong)NSString *message;
@property (nonatomic,strong)BuyerDetail *detail;
@property (assign) BOOL success;


@end

@interface BuyerDetail : JSONModel
@property (nonatomic,strong)NSString *APIVerificationCode;
@property (nonatomic,strong)NSString <Optional>*BusinessNo;
@property (nonatomic,strong)NSString <Optional>*CompanyName;
@property (nonatomic,strong)NSNumber *CustomerID;
@property (nonatomic,strong)NSString <Optional>*DOB;
@property (nonatomic,strong)NSString *Email;
@property (nonatomic,strong)NSString *FullName;
@property (nonatomic,strong)NSString *Gender;
@property (nonatomic,strong)NSString *RegistrationStatus;
@property (nonatomic,strong)NSNumber *UserID;
@property (nonatomic,strong)NSString <Optional>*UserTimeZone;
@property (nonatomic,strong)NSString *mobileNo;
@property (assign) BOOL IsComplete;
@property (assign) BOOL VerificationStatus;


@end
