//
//  VCMessageScreen.m
//  Tradologie
//
//  Created by Chandresh Maurya on 12/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "VCMessageScreen.h"

@interface VCMessageScreen ()

@end

@implementation VCMessageScreen

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [viewBG SetDefaultShadowBackGround];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationItem setHidesBackButton:YES animated:YES];
    [self.navigationItem setHidesBackButton:YES];
    
    [self.navigationItem setNavigationTittleWithLogo:@"tradologie.com"];
    [self.navigationItem SetBackButtonWithID:self withSelectorAction:@selector(btnBackItemTapped:)];

    [btnVerifyEmail setDefaultButtonStyle];
    [lblVerifyMessage setText:[[@"By clicking on the verification link as sent through email on you registered email ID: " stringByAppendingString:GET_USER_DEFAULTS(@"emailID")] stringByAppendingString:@" if you did not receive the e-mail, please click re-send e-mail"]];
    [lblVerifyMessage setFont:UI_DEFAULT_FONT(16)];
    void(^handler)(FRHyperLabel *label, NSString *substring) = ^(FRHyperLabel *label, NSString *substring)
    {
    };
    [lblVerifyMessage setLinksForSubstrings:@[GET_USER_DEFAULTS(@"emailID")] withLinkHandler:handler];

    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)btnBackItemTapped:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
