//
//  NegotiationDetail.m
//  Tradologie
//
//  Created by Chandresh Maurya on 31/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "NegotiationDetail.h"

@implementation NegotiationDetail

+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end

/************************ NegotiationDetail Data *********************************************/

@implementation NegotiationDetailData

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    
    return YES;
}
@end

/************************ InspectionAgencyList *********************************************/
@implementation InspectionAgencyList

+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}


@end

/************************ CustomerAddressList  *********************************************/

@implementation CustomerAddressList

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    
    return YES;
}
@end

/************************ CustomerAddressList  *********************************************/

@implementation CurrencyList

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    
    return YES;
}
@end
