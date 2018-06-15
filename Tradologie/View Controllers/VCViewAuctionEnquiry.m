//
//  VCViewAuctionEnquiry.m
//  Tradologie
//
//  Created by Chandresh Maurya on 15/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "VCViewAuctionEnquiry.h"
#import "AppConstant.h"

@interface VCViewAuctionEnquiry ()

@end

@implementation VCViewAuctionEnquiry

- (void)viewDidLoad
{
    [super viewDidLoad];
            NSURL *url = [[NSURL alloc] initWithString:_strUrl];
            SFSafariViewController *sfcontroller = [[SFSafariViewController alloc] initWithURL:url];
    [self.navigationController presentViewController:sfcontroller animated:YES completion:^{
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
