//
//  MBErrorUtility.h
//  Tradologie
//
//  Created by Chandresh on 8/9/16.
//  Copyright © 2016 Chandresh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBErrorUtility : NSObject

typedef NS_ENUM(NSInteger, MBErrorCodes)
{
    MBBadRequest = 400,
    MBUnAuthorized=401,
    MBForbidden=403,
    MBNotFound=404,
    MBParameterMissing=406,
    MBUserAlreadyExists=409,
    MBServerError=500,
    MBNotModified=304,
    MBNoInternetConnection=-1009,
    MBNoInternetConnectionAgain=-1004,
    MBRequestTimeOut = -1001
    
};

+(NSString *)handlePredefinedErrorCode:(NSInteger) errorcode andMessage:(NSString*)message;


@end
