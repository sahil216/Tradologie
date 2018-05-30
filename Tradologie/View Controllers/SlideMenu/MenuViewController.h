//
//  MenuViewController.h
//  CherryPop
//
//  Created by Shiv Kumar on 21/12/16.
//  Copyright © 2016 Shiv Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewCell.h"
#import "RESideMenu.h"

@interface MenuViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,RESideMenuDelegate,UIAlertViewDelegate>
{
    __weak IBOutlet UITableView *tblView;
    __weak IBOutlet UIImageView *imgViewProfile;
    __weak IBOutlet UILabel *lblUserName;
    __weak IBOutlet UILabel *lblEmailJoin;
    __weak IBOutlet UIView *viewProfile;
    __weak IBOutlet UIButton *btnLogout;
    __weak IBOutlet UIActivityIndicatorView *indicator;
}


@end
