//
//  TVLoginScreen.h
//  DemoApp
//
//  Created by Chandresh Maurya on 03/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TVLoginScreen : UITableViewController
{
    __weak IBOutlet UIButton   *btnOr;
    __weak IBOutlet UIImageView * imgRice;
    __weak IBOutlet UILabel   *lblCopyRight;

}

@property(nonatomic,weak)IBOutlet UIView * viewHeader;
@property(nonatomic,weak)IBOutlet UIView * viewFooter;

@property (nonatomic,weak) IBOutlet UIButton   *btnAlreadyLogin;
@property (nonatomic,weak) IBOutlet UIButton   *btnCreateAccount;
@property (nonatomic,weak) IBOutlet UIButton *btnFaceBook;
@property (nonatomic,weak) IBOutlet UIButton *btnGooglePlus;
@property (nonatomic,weak) IBOutlet UIButton *btnLinkedIn;
@end
