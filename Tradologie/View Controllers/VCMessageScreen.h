//
//  VCMessageScreen.h
//  Tradologie
//
//  Created by Chandresh Maurya on 12/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface VCMessageScreen : UIViewController
{
    __weak IBOutlet UIView *viewBG;
    __weak IBOutlet UIButton *btnVerifyEmail;
     IBOutlet FRHyperLabel *lblVerifyMessage;

}

@end
