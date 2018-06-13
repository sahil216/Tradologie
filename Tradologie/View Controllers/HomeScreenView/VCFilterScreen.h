//
//  VCFilterScreen.h
//  Tradologie
//
//  Created by Chandresh Maurya on 01/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCFilterScreen : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    __weak IBOutlet UIButton *btnSelectCountry;
    __weak IBOutlet UIButton *btnSelectType;

}
@property (strong, nonatomic) IBOutlet UITableView *tbtFiltterList;




@end
