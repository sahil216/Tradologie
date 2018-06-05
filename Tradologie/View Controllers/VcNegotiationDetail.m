//
//  VcNegotiationDetail.m
//  Tradologie
//
//  Created by Chandresh Maurya on 02/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "VcNegotiationDetail.h"
#import "Constant.h"
#import "AppConstant.h"
#import "VCHomeNotifications.h"

@interface VcNegotiationDetail ()<UITableViewDataSource,UITableViewDelegate>
{
    CGFloat headerTotalWidth;
    CGFloat height;

}

@end

@implementation VcNegotiationDetail

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setNavigationTittleWithLogoforLanscapeMode:@"Negotiation Details"];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationItem setHidesBackButton:YES animated:YES];
    [self.navigationItem setHidesBackButton:YES];
    
    [self SetInitialSetup];
    [self.navigationItem SetBackButtonWithID:self withSelectorAction:@selector(btnBackItem:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if([self respondsToSelector:@selector(edgesForExtendedLayout)])
            [self setEdgesForExtendedLayout:UIRectEdgeNone];
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.myTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    });
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO animated:YES];
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== SET INITIAL SETUP ===❉===❉
/*****************************************************************************************************************/
-(void)SetInitialSetup
{
    [_contentView setFrame:CGRectMake(0,0, SCREEN_WIDTH * 3, SCREEN_HEIGHT + 20)];
    [_contentView setBackgroundColor:[UIColor grayColor]];
//
//    headerTotalWidth =  SCREEN_HEIGHT * 2;
//
//    height = ([SDVersion deviceSize] > Screen4Dot7inch)?_contentView.frame.size.height - 75:([SDVersion deviceSize] < Screen4Dot7inch)?_contentView.frame.size.height - 65:_contentView.frame.size.height - 70;
//
//    [self.myTableView setFrame:CGRectMake(0, 0, headerTotalWidth, height)];
//
   [_myScrollView setFrame:CGRectMake(0, 0, _contentView.frame.size.width * 3, _contentView.frame.size.height)];
    _myScrollView.bounces=NO;
    [_myScrollView setShowsHorizontalScrollIndicator:NO];
    _myScrollView.contentSize = CGSizeMake(headerTotalWidth * 20, 0);
    [_myScrollView setBackgroundColor:[UIColor redColor]];
    //[_contentView addSubview:_myScrollView];
    
  //  [self.view addSubview:_contentView];


}
/******************************************************************************************************************/
#pragma mark ❉===❉=== TABLEVIEW DELEGATE & DATA SOURCE CALLED HERE ===❉===❉
/*****************************************************************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier=@"cell_Identifier";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        CGFloat hue = ( arc4random() % 256 / 256.0 );
        CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
        CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
        UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
        [cell.textLabel setBackgroundColor:color];
    }
   
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60 + 10;
}
/******************************************************************************************************************/
#pragma mark ❉===❉=== BUTTON ACTION EVENT CALLED HERE ===❉===❉
/*****************************************************************************************************************/
-(IBAction)btnBackItem:(UIButton *)sender
{
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait] forKey:@"orientation"];
    [self.navigationItem setNavigationTittleWithLogo:@"tradologie.com"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        RootViewController * rootVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RootViewController"];
        AppDelegate *delegateClass = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        [delegateClass setRootViewController:rootVC];
    });

}
@end
