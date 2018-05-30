//
//  NSDictionary+CheckNullValue.m
//  DriveMate
//
//  Created by mac on 23/11/15.
//  Copyright (c) 2015 mapmyindia. All rights reserved.
//

#import "NSDictionary+CheckNullValue.h"

@implementation NSDictionary (CheckNullValue)

+(BOOL)valueForKeyInDict :(NSDictionary *)dict WithKey:(NSString *)key {
    BOOL result = YES;
    if ([[dict valueForKey:key] isEqual:[NSNull null]] || [dict valueForKey:key] == nil) {
        result = NO;
    }
    return result;
}
-(BOOL)isDictionaryExist {
    
    if (self!=nil || !([self isKindOfClass:[NSNull class]])) {
        
        return YES;
    }
    else {
        return NO;
    }
}


-(id)objectForKeyWithNullCheck:(id)key {
    
    if (self[key] == [NSNull null] || self[key] == NULL) {
        return nil;
    }
    return self[key];
}

-(id)valueForKeyWithNullCheck:(NSString*)key {
    
    if ([self valueForKey:key] == [NSNull null] || [self valueForKey:key] == NULL) {
        return nil;
    }
    return [self valueForKey:key];
    
}

@end
