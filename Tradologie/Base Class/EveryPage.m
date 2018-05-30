//
//  EveryPage.m
//  Tradologie
//
//  Created by Chandresh Maurya on 09/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "EveryPage.h"
#import "Constant.h"
#import "CommonUtility.h"

@interface EveryPage ()

@end

@implementation EveryPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)getContactDialNumber
{
    NSString *phNo = @"+911204803600";
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

@end
