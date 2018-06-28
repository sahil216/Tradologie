//
//  MBErrorUtility.m
//  Tradologie
//
//  Created by Chandresh on 8/9/16.
//  Copyright © 2016 Chandresh. All rights reserved.
//


#import "MBErrorUtility.h"

@implementation MBErrorUtility

+(NSString *)handlePredefinedErrorCode:(NSInteger) errorcode andMessage:(NSString*)message
{
    if(message.length==0)
    {
        message=@"We are sorry! Due to an internal problem your request has failed. Please try again";
        
    }
    switch (errorcode) {
        case MBBadRequest:
            return @"Parameter Missing";
            break;
            
        case MBUnAuthorized:
//            [MBDataBaseHandler deleteAllRecordsForType:LoggedInUser];
//            [MBAppInitializer moveToLoginViewController];
            return message;
            break;

        case MBForbidden:
                return @"Forbidden";
            break;
            
        case MBNotFound:
                return @"Not Found";
            break;
            
        case MBParameterMissing:
            return @"Parameter Missing";
            break;
            
        case MBUserAlreadyExists:
            return @"User Already Exists";
            break;
            
        case MBServerError:
            return @"Server could not fullfill the request.";
            break;
            
        case MBNoInternetConnection:
            return @"Please check your internet connection or try again later.";
            break;
            
        case MBNoInternetConnectionAgain:
                return @"We are experiencing technical difficulties. Please try again later.";
            break;
            
        case MBNotModified:
            break;
         case MBRequestTimeOut:
            return @"We could not process your request. Please try again.";
            break;
            
        default:
            return message;
            break;
    }
    return 0;
}

@end
