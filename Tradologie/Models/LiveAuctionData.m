//
//  LiveAuctionData.m
//  Tradologie
//
//  Created by Chandresh Maurya on 15/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "LiveAuctionData.h"

@implementation LiveAuctionData

+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
@end

/************************ LiveAuctionDetailData  *********************************************/
@implementation LiveAuctionDetailData

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    
    return YES;
}
@end

/************************ Auction Data *********************************************/
@implementation LiveAuctionDatalist

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    
    return YES;
}
@end


/************************ Auction Data *********************************************/
@implementation SellerDetailList

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    
    return YES;
}
@end


