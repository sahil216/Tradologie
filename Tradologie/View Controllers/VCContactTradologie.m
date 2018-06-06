//
//  VCContactTradologie.m
//  Tradologie
//
//  Created by Chandresh Maurya on 05/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "VCContactTradologie.h"
#import "Constant.h"
#import "CommonUtility.h"
#import <MessageUI/MessageUI.h>


@interface VCContactTradologie ()<MFMailComposeViewControllerDelegate>

@end

@implementation VCContactTradologie

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
    [self.navigationItem setNavigationTittleWithLogo:@"Contact Tradologie"];
    
    [CommonUtility GetShadowWithBorder:viewBG];
    [btnContact addTarget:self action:@selector(btnContactTapped:) forControlEvents:UIControlEventTouchUpInside];
    [btnEmail addTarget:self action:@selector(btnEmailTapped:) forControlEvents:UIControlEventTouchUpInside];

   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/******************************************************************************************************************/
#pragma mark ❉===❉===  BUTTON ACTION EVENT CALLED HERE ===❉===❉
/******************************************************************************************************************/
-(IBAction)btnContactTapped:(UIButton *)sender
{
    NSString *phNo = @"+911202427242";
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl])
    {
        [CommonUtility OpenURLAccordingToUse:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    }
    else
    {
        [CommonUtility ShowAlertwithTittle:@"Call facility is not available!!!" withID:self];
    }
}

-(IBAction)btnEmailTapped:(UIButton *)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:@"FeedBack"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"info@tradologie.com",nil];
        [mailer setToRecipients:toRecipients];
        
        NSString *emailBody = @"If you want to avail tradologie Service Just Send this E-Mail & we will contact you as soon as possible";
        [mailer setMessageBody:emailBody isHTML:NO];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            [self presentViewController:mailer animated:YES completion:nil];
        }
    }
    else
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Failure! Your device doesn't support the composer sheet"];
        return;
    }
    
}
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(nullable NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultSent:
        {
            [self dismissViewControllerAnimated:YES completion:^{
                
                [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Meesage has been sent Sucessfully"];
            }];
        }
            break;
            
        case MFMailComposeResultSaved:
        {
            [self dismissViewControllerAnimated:YES completion:^{
                [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"You saved a draft of this email"];
            }];
        }
            break;
        case MFMailComposeResultCancelled:
        {
            [self dismissViewControllerAnimated:YES completion:^{
                [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"You cancelled sending this email."];
            }];
        }
            break;
            
        default:
        {
            [self dismissViewControllerAnimated:YES completion:^{
                [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"You cancelled sending this email."];
            }];
        }
            
            break;
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
