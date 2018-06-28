//
//  CategoryDetail.h
//  Tradologie
//
//  Created by Chandresh Maurya on 25/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@class CategoryDetailItem;

@protocol CategoryDetailItem <NSObject>
@end
@protocol CategoryItemList <NSObject>
@end

@protocol Attribute1List <NSObject>
@end

@protocol Attribute2List <NSObject>
@end

@protocol ItemUnitList <NSObject>
@end
@protocol PackingTypeList <NSObject>
@end
@protocol PackingSizeList <NSObject>
@end

@interface CategoryDetail : JSONModel
@property (assign)BOOL status;
@property (nonatomic, strong)NSString <Optional>*message;
@property (nonatomic, strong)CategoryDetailItem *detail;

@end

@interface CategoryDetailItem : JSONModel

@property (nonatomic,strong)NSMutableArray <CategoryItemList >*CategoryList;
@property (nonatomic,strong)NSString <Optional>*Attribute1Header;
@property (nonatomic,strong)NSMutableArray <Attribute1List >*Attribute1List;
@property (nonatomic,strong)NSString <Optional>*Attribute2Header;
@property (nonatomic,strong)NSMutableArray <Attribute2List >*Attribute2List;
@property (nonatomic,strong)NSMutableArray <ItemUnitList >*ItemUnitList;
@property (nonatomic,strong)NSMutableArray <PackingTypeList >*PackingTypeList;
@property (nonatomic,strong)NSMutableArray <PackingSizeList >*PackingSizeList;

@end

@interface CategoryItemList : JSONModel
@property (nonatomic, strong)NSNumber <Optional>*CategoryID;
@property (nonatomic, strong)NSString <Optional>*CategoryName;

@end

@interface Attribute1List : JSONModel
@property (nonatomic, strong)NSNumber <Optional>*AttributeValueID;
@property (nonatomic, strong)NSString <Optional>*AttributeValue;
@end

@interface Attribute2List : JSONModel
@property (nonatomic, strong)NSNumber <Optional>*AttributeValueID;
@property (nonatomic, strong)NSString <Optional>*AttributeValue;
@end

@interface ItemUnitList : JSONModel
@property (nonatomic, strong)NSString <Optional>*UnitName;
@end

@interface PackingTypeList : JSONModel
@property (nonatomic, strong)NSNumber <Optional>*PackingTypeID;
@property (nonatomic, strong)NSString <Optional>*PackingValue;
@end

@interface PackingSizeList : JSONModel
@property (nonatomic, strong)NSNumber <Optional>*PackingSizeID;
@property (nonatomic, strong)NSString <Optional>*PackingSizeValue;

@end
