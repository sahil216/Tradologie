//
//  VCTradePolicyScreen.h
//  Tradologie
//
//  Created by Chandresh Maurya on 14/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCTradePolicyScreen : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tbtPolicyList;

@end
