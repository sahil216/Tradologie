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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setNaviagtionStyleWithStatusbar:[UIColor whiteColor]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)getContactDialNumber
{
    NSString *phNo = @"+911204803600";
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl])
    {
        if([[UIDevice currentDevice].systemVersion floatValue] >= 10.0)
        {
            if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)])
            {
                [[UIApplication sharedApplication] openURL:phoneUrl options:@{}
                                         completionHandler:^(BOOL success)
                 {
                 }];
            }
        }
        else
        {
            BOOL success = [[UIApplication sharedApplication] openURL:phoneUrl];
            if(success){
                [[UIApplication sharedApplication] openURL:phoneUrl];
            }
        }
    }
    else
    {
        [CommonUtility ShowAlertwithTittle:@"Call facility is not available!!!" withID:self];
    }
}

//-(void)getCellIndex:(UIButton *)sender withCell:(UITableViewCell *)cell
//{
//    UIView *parentCell = sender.superview;
//    while (![parentCell isKindOfClass:[cell class]])
//    {
//        parentCell = parentCell.superview;
//    }
//    UIView *parentView = parentCell.superview;
//    while (![parentView isKindOfClass:[UITableView class]])
//    {
//        parentView = parentView.superview;
//    }
//    
//    UITableView *tableView = (UITableView *)parentView;
//    NSIndexPath *indexPath = [tableView indexPathForCell:(UITableViewCell *)parentCell];
//    NSLog(@"%ld",(long)indexPath.row);
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
