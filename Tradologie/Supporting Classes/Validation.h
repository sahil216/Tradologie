//
//  Validation.h
//  GonzApp
//
//  Created by Chandresh on 8/2/16.
//  Copyright © 2016 Chandresh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Validation : NSObject
{

}
+(BOOL) validateEmail: (NSString *) candidate;
+(BOOL) textFieldLength: (NSString*) txtField;
+(BOOL) validatePhoneNumber: (NSString*) mobile;
+(BOOL) validateURL :(NSString*)URLAddress;
+(BOOL) validateTextField:(UITextField *)txtField;
+(BOOL) ValidatePassword:(NSString *)StrPassword;
+(BOOL)isAlphaNumericAndContainsAtLeastSixDigit:(NSString *)str;
+(BOOL) validatePassword:(UITextField *)txtPassword ConfirmPassword:(UITextField *)txtConfPass;
@end
