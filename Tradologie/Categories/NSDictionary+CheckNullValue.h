//
//  NSDictionary+CheckNullValue.h
//  DriveMate
//
//  Created by mac on 23/11/15.
//  Copyright (c) 2015 mapmyindia. All rights reserved.


#import <Foundation/Foundation.h>

@interface NSDictionary (CheckNullValue)

+(BOOL)valueForKeyInDict :(NSDictionary *)dict WithKey:(NSString *)key ;
@property (NS_NONATOMIC_IOSONLY, getter=isDictionaryExist, readonly) BOOL dictionaryExist;
-(id)objectForKeyWithNullCheck:(id)key;
-(id)valueForKeyWithNullCheck:(NSString*)key;

@end
