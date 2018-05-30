//
//  ProductCategory.h
//  Tradologie
//
//  Created by Chandresh Maurya on 15/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "JSONModel.h"

@protocol detail <NSObject>
@end

@interface ProductCategory : JSONModel
@property (assign)BOOL status;
@property (nonatomic, strong)NSString <Optional>*message;
@property (nonatomic, strong)NSMutableArray <detail> *detail;

@end
@interface detail : JSONModel

@property (nonatomic, strong)NSNumber <Optional>*GroupID;
@property (nonatomic, strong)NSString  *GroupName;
@end
