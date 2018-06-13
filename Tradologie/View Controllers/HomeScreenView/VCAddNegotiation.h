//
//  VCAddNegotiation.h
//  Tradologie
//
//  Created by Chandresh Maurya on 26/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EveryPage.h"

@interface VCAddNegotiation : EveryPage <UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    __weak IBOutlet UIButton *btnContactUs;
    __weak IBOutlet UITextField *txtCategory;
    __weak IBOutlet UIView *viewFooter;
    __weak IBOutlet UIButton *btnCreateNegotiation;
    __weak IBOutlet UIButton *btnFilter;

}
@property (strong, nonatomic) IBOutlet UITableView *tbtNegotiation;

@end

