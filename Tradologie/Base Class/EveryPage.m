//
//  EveryPage.m
//  Tradologie
//
//  Created by Chandresh Maurya on 09/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "EveryPage.h"
#import "Constant.h"
#import "SharedManager.h"
#import "MBAPIManager.h"
#import "MBDataBaseHandler.h"
#import "CommonUtility.h"

@interface EveryPage ()
{

}
@end

@implementation EveryPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];
    [self GetCategoryListForNegotiation];
    
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
/******************************************************************************************************************/
#pragma mark ❉===❉=== GET ALL CATEGORY API CALLED HERE ===❉===❉
/******************************************************************************************************************/
-(void)GetCategoryListForNegotiation
{
    if (SharedObject.isNetAvailable)
    {
        MBCall_GetCategoryListForNegotiation(^(id response, NSString *error, BOOL status)
        {
            if (status && [[response valueForKey:@"success"]isEqual:@1])
            {
                if (response != (NSDictionary *)[NSNull null])
                {
                    NSError* Error;
                    ProductCategory *objProduct = [[ProductCategory alloc]initWithDictionary:response error:&Error];
                    [MBDataBaseHandler saveProductCategoryDetail:objProduct];
                }
            }
            else
            {
            }
        });
    }
    else
    {
        [[CommonUtility new] show_ErrorAlertWithTitle:@"" withMessage:@"Internet Not Available Please Try Again..!"];
    }
}
@end
