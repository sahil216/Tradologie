//
//  TVCompanyRegister.h
//  Tradologie
//
//  Created by Chandresh Maurya on 15/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVCompanyRegister : UITableViewController
{
    __weak IBOutlet UITextField * txtCompanyName;
    __weak IBOutlet UITextField * txtPANNo;
    __weak IBOutlet UITextField * txtGSTIN;
    __weak IBOutlet UITextField * txtTimeZone;
    __weak IBOutlet UITextField * txtCountry;
    __weak IBOutlet UITextField * txtStateProvince;
    __weak IBOutlet UITextField * txtCity;
    __weak IBOutlet UITextField * txtInterestedIn;
    __weak IBOutlet UIButton    *btnAgreeTerms;
    __weak IBOutlet UIButton    *btnSubmit;
    UIPickerView *pickerViewType;
    __weak IBOutlet UILabel * lbl_logoname;
    __weak IBOutlet UIButton    *btnback;

}
@property(nonatomic,weak)IBOutlet UIView * viewHeader;
@end
