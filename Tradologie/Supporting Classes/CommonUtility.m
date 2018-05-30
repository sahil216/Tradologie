//
//  CommonUtility.h
//  SetlrApp
//
//  Created by Chandresh on 8/9/16.
//  Copyright © 2016 Chandresh. All rights reserved.
//


#import "CommonUtility.h"

@implementation CommonUtility
//=======================================================================================================
#pragma mark- CUSTOM ALERTVIEW CALLED HERE
//=======================================================================================================
//-(void)ErrorWithString:(NSString*)strError WithID:(id)TargetId
//{
//    showAlert = [[Alert alloc] initWithTitle:strError duration:(float)1.9 completion:^{}];
//    [showAlert setDelegate:TargetId];
//    [showAlert setAlertType:AlertTypeError];
//    [showAlert setIncomingTransition:AlertIncomingTransitionTypeSlideFromTop];
//    [showAlert setOutgoingTransition:AlertOutgoingTransitionTypeSlideToTop];
//    [showAlert setBounces:YES];
//    [showAlert showAlert];
//}
- (void)show_ErrorAlertWithTitle:(NSString*)title withMessage:(NSString*)message
{
    ISMessages* alert = [ISMessages cardAlertWithTitle:title
                                               message:message
                                             iconImage:IMAGE(@"IconError")
                                              duration:2.0f
                                           hideOnSwipe:YES
                                             hideOnTap:YES
                                             alertType:ISAlertTypeCustom
                                         alertPosition:ISAlertPositionTop];

    alert.messageLabelTextColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    alert.messageLabelFont = UI_DEFAULT_FONT_MEDIUM(15);
    alert.alertViewBackgroundColor = [UIColor redColor];
    [alert show:nil didHide:nil];
    
}


-(void)show_SuccessAlertWithTitle:(NSString*)title withMessage:(NSString*)message
{
    ISMessages* alert = [ISMessages cardAlertWithTitle:title
                                               message:message
                                             iconImage:IMAGE(@"Icon Logo")
                                              duration:2.0f
                                           hideOnSwipe:YES
                                             hideOnTap:YES
                                             alertType:ISAlertTypeCustom
                                         alertPosition:ISAlertPositionTop];
    
    alert.titleLabelTextColor = [UIColor whiteColor];
    alert.messageLabelFont = UI_DEFAULT_FONT_MEDIUM(16);
    alert.messageLabelTextColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    alert.alertViewBackgroundColor = [UIColor greenColor];
    [alert show:nil didHide:nil];
    
}
+(void)showProgressWithMessage:(NSString *)message
{
    [SVProgressHUD setBackgroundColor:[[UIColor orangeColor]colorWithAlphaComponent:.80f]];
    [SVProgressHUD setRingThickness:4.0f];
    [SVProgressHUD setFont:UI_DEFAULT_FONT_BOLD(14)];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD showWithStatus:message];

}
/******************************************************************************************************************/
#pragma mark ❉===❉===  SHOW ALERT  ===❉===❉
/*****************************************************************************************************************/
+(void)ShowAlertwithTittle:(NSString *)strMessage withID:(id)Controller
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"TRADOLOGIE"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:strMessage];
    [hogan addAttribute:NSFontAttributeName
                  value:UI_DEFAULT_FONT_MEDIUM(20)
                  range:NSMakeRange(0, strMessage.length)];
    [hogan addAttribute:NSForegroundColorAttributeName
                  value:DefaultThemeColor
                  range:NSMakeRange(0, strMessage.length)];
    [alert setValue:hogan forKey:@"attributedTitle"];
    [alert.view setTintColor:[UIColor redColor]];
    [alert addAction:defaultAction];
    [Controller presentViewController:alert animated:YES completion:nil];
}
+(void)HideProgress
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}
+(void)setTooBarOnTextfield:(UITextField *)txtField withTargetId:(id)targetID withActionEvent:(SEL)ActionEvent
{
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,IS_IPAD?50:45)];
    toolBar.barStyle = UIBarStyleDefault;
    [toolBar setBackgroundColor: [UIColor whiteColor]];
    
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *barBtnDone = [[UIBarButtonItem alloc]initWithTitle:@"DONE" style:UIBarButtonItemStyleDone target:targetID  action:ActionEvent];
    
    [barBtnDone setTitleTextAttributes:@{NSFontAttributeName: UI_DEFAULT_FONT_BOLD(16),
                                         NSForegroundColorAttributeName: DefaultThemeColor} forState:UIControlStateNormal];
    toolBar.items = [NSArray arrayWithObjects:flex,barBtnDone,nil];
    [txtField setInputAccessoryView:toolBar];
}

//=======================================================================================================
#pragma mark- Remove Duplicate Item List
//=======================================================================================================

+(NSMutableArray *) removeDuplicateFromList:(NSArray *)  groups withKey: (NSString *)key {
    
    NSMutableArray * listFiltered = [NSMutableArray new];
    NSMutableArray * listNamesEncountered = [NSMutableArray new];
    
    NSString * code;
    for (NSDictionary * group in groups) {
        
        code =[group objectForKey:key];
        
        if ([listNamesEncountered indexOfObject: code] == NSNotFound) {
            
            [listNamesEncountered addObject:code];
            [listFiltered addObject:group];
        }
    }
    return listFiltered;
}



+(NSInteger)getCurrentYear
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    NSLog(@"response is :Year:%ld, month %ld, day: %ld,",(long)year,(long)month,(long)day);
    
    return year;
}

+ (void) setMaxAndMinDateForAppInPickerView : (UIDatePicker *)datePicker {
    
    NSCalendar * gregorian = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    NSDate * currentDate = [NSDate date];
    NSDateComponents * comps = [[NSDateComponents alloc] init];
    [comps setYear: -18];
    NSDate * maxDate = [gregorian dateByAddingComponents: comps toDate: currentDate options: 0];
    [comps setYear: -100];
    NSDate * minDate = [gregorian dateByAddingComponents: comps toDate: currentDate options: 0];
    
    [datePicker setMaximumDate:maxDate];
    [datePicker setMinimumDate:minDate];
}

#pragma mark- Image CollorChange
+ (UIImage *) changeImage : (UIImage *)image color:(UIColor *)color {
    
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage
                                                scale:1.0 orientation: UIImageOrientationDownMirrored];
    
    return flippedImage;
}
/*-(CGFloat)heightForLabel:(NSIndexPath *)index
 {
 NSMutableArray *array = [NSMutableArray new];
 for (NSDictionary *dic in arrData)
 {
 [array addObject:[dic valueForKey:@"Address"]];
 }
 NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:[array objectAtIndex:index.row] attributes:@{NSFontAttributeName:UI_DEFAULT_FONT(16)}];
 
 CGRect rect = [attributedText boundingRectWithSize:(CGSize){K_CUSTOM_WIDTH, CGFLOAT_MAX}
 options:NSStringDrawingUsesLineFragmentOrigin
 context:nil];
 NSLog(@"lblHeight== >%f",rect.size.height);
 
 return ceil(rect.size.height);
 }*/
@end
