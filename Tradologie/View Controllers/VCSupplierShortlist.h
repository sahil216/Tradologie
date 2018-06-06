//
//  VCSupplierShortlist.h
//  Tradologie
//
//  Created by Chandresh Maurya on 05/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstant.h"
#import "EveryPage.h"

@interface VCSupplierShortlist : EveryPage <UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    __weak IBOutlet UITextField *txtCategory;
    __weak IBOutlet UIButton *btnFilter;
    
}
@property (strong, nonatomic) IBOutlet UITableView *tbtSupplierShortlist;

@end




