//
//  AuctionOrderHistory.m
//  Tradologie
//
//  Created by Chandresh Maurya on 05/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "AuctionOrderHistory.h"

@implementation AuctionOrderHistory

+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}


@end
/************************ SupplierDetail Data *********************************************/
@implementation OrderHistoryData

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    
    return YES;
}
@end
