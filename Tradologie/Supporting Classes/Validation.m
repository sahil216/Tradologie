//
//  Validation.m
//  GigGuideLive
//
//  Created by Mac-1 on 10/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Validation.h"

@implementation Validation

+ (BOOL) validateEmail: (NSString *) candidate
{
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	return [emailTest evaluateWithObject:candidate];
}
+ (BOOL) textFieldLength: (NSString*) txtField
{
	if([txtField length] <= 0)
    {
		return NO;
	}
	return YES;
	
}

+ (BOOL) validatePhoneNumber: (NSString*) mobile
{
    NSString *phoneRegex = @"^((\\+)|(91))[0-9]{6,14}$";

    if (mobile.length > 13) {
        return false;
    }
    else if ([mobile rangeOfString:@" "].location != NSNotFound) {
        return false;
    }
    else if (![mobile containsString:phoneRegex])
    {
        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
        return [phoneTest evaluateWithObject:mobile];
    }
    return TRUE;
  
}
+ (BOOL) validateURL :(NSString*)URLAddress
{
	NSString *urlRegex = @"(?:(?:(?:^(?:ht|f)tps?://)|^)(?:(?:(?:(?:(?:[a-zA-Z0-9](?:(?:[a-zA-Z0-9]|-)*[a-zA-Z0-9])?)\\.)+(?:[a-zA-Z](?:(?:[a-zA-Z0-9]|-)*[a-zA-Z0-9])?))|(?:(?:[0-9]{1,3})(?:\\.(?:[0-9]{1,3})){3}))(?::(?:[0-9]{1,5}))?)(?:(?:/(?:(?:(?:(?:[a-zA-Z0-9$\\-_.+!*'(),]|(?:%[a-fA-F0-9]{2}))|[;:@&=])*)(?:/(?:(?:(?:[a-zA-Z0-9$\\-_.+!*'(),]|(?:%[a-fA-F0-9]{2}))|[;:@&=])*))*))?(?:\\?(?:(?:(?:[a-zA-Z0-9$\\-_.+!*'(),]|(?:%[a-fA-F0-9]{2}))|[;:@&=])*))?)?$)";
	NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegex];
	return [urlTest evaluateWithObject:URLAddress];
}

+(BOOL)validateTextField:(UITextField *)txtField
{
    if(txtField == nil)
    {
        return YES;
    }
    else if([txtField.text length]<=0)
    {
        return YES;
    }
    
    return NO;
}
+(BOOL)ValidatePassword:(NSString *)StrPassword
{
    NSString    *regex     = @"^(?=.*)[a-zA-Z\\d]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:StrPassword];
}
+(BOOL)isAlphaNumericAndContainsAtLeastSixDigit:(NSString *)str
{
    
    if (str.length >4 && str.length<10 && ([str rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location != NSNotFound) && ( [str rangeOfCharacterFromSet:[NSCharacterSet lowercaseLetterCharacterSet]].location != NSNotFound ||  [str rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet]].location != NSNotFound)) {
        
        return YES;
    }
    
    return NO;
}
+(BOOL)validatePassword:(UITextField *)txtPassword ConfirmPassword:(UITextField *)txtConfPass
{
    if ([txtPassword.text isEqualToString:txtConfPass.text])
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}

+(BOOL)validatePasswordLength: (NSString*) passwordLength
{
    if([passwordLength length] >= 6)
    {
        return YES;
    }
    return NO;
}

@end
