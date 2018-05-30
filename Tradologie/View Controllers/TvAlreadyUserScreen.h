//
//  TvAlreadyUserScreen.h
//  Tradologie
//
//  Created by Chandresh Maurya on 04/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface TvAlreadyUserScreen : UITableViewController<UITextFieldDelegate>
{
   __weak IBOutlet UITextField * txtUserID;
   __weak IBOutlet UITextField * txtPassword;
   __weak IBOutlet UIButton    *btnback;
     IBOutlet FRHyperLabel *lblVisitUs;
    __weak IBOutlet UIButton * btnForgotPwd;
    __weak IBOutlet UILabel * lbl_logoname;


}
@property(nonatomic,weak)IBOutlet UIView * viewLogo;
@property(nonatomic,weak)IBOutlet UIView * viewBottom;
@property (nonatomic,weak) IBOutlet UIButton *btnLogin;

@end
