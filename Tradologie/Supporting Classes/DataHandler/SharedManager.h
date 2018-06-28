//
//  SharedManager.h
//  Tradologie
//
//  Created by Chandresh on 8/9/16.
//  Copyright © 2016 Chandresh. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface SharedManager : NSObject
{
    
}

@property(assign,readwrite) BOOL isLoggedIn;
@property(assign,readwrite) BOOL isNetAvailable;
@property(nonatomic,retain) NSUserDefaults *userDefaults;
@property(nonatomic,retain) NSString *deviceToken;
@property(nonatomic,retain) NSMutableArray *arrTimeZone;
@property(nonatomic,retain) NSMutableArray *arrCountry;
@property(nonatomic,retain) NSMutableArray *arrBuyerInterestedIn;
@property(nonatomic,retain) NSMutableDictionary *dicDefaultCommonData;

+(SharedManager *)sharedInstance;
+(void)releaseSharedManager;

@end
