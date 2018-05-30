//
//  TVForgotPassword.h
//  Tradologie
//
//  Created by Chandresh Maurya on 07/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVForgotPassword : UITableViewController
{
    __weak IBOutlet UITextField * txtEmailID;
    __weak IBOutlet UIButton    *btnback;
    __weak IBOutlet UIButton    *btnSubmit;
    __weak IBOutlet UILabel * lbl_logoname;

}

@property(nonatomic,weak)IBOutlet UIView * viewHeader;

@end
