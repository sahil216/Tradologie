//
//  CategoryDetail.m
//  Tradologie
//
//  Created by Chandresh Maurya on 25/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "CategoryDetail.h"

@implementation CategoryDetail
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    
    return YES;
}
@end
/************************ CategoryDetailItem DETAIL *********************************************/

@implementation CategoryDetailItem

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    
    return YES;
}
@end
/************************ CategoryItemList  *********************************************/
@implementation CategoryItemList

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    
    return YES;
}
@end
/************************ Attribute1List Category *********************************************/
@implementation Attribute1List

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    
    return YES;
}
@end/************************ Attribute2List Category *********************************************/
@implementation Attribute2List

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    
    return YES;
}
@end/************************ ItemUnitList Category *********************************************/
@implementation ItemUnitList

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    
    return YES;
}
@end/************************ PackingTypeList Category *********************************************/
@implementation PackingTypeList

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    
    return YES;
}

@end/************************ PackingSizeList Category *********************************************/
@implementation PackingSizeList

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    
    return YES;
}
@end
