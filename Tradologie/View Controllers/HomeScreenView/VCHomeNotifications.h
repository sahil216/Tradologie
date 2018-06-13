//
//  VCHomeNotifications.h
//  Tradologie
//
//  Created by Chandresh Maurya on 09/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EveryPage.h"

@interface VCHomeNotifications : EveryPage<UITableViewDelegate,UITableViewDataSource>
{
    __weak IBOutlet UIButton *btnAddNegotiation;
    __weak IBOutlet UIButton *btnContactUs;

}
@property(nonatomic,weak)IBOutlet UIView * viewHeader;
@property (strong, nonatomic) IBOutlet UITableView *tbtNotify;

@end
@interface NotificationList : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblNotifyName;
@property (strong, nonatomic) IBOutlet UILabel *lblEnquiry;
@property (strong, nonatomic) IBOutlet UIButton *btnplaceOrder;
- (void)ConfigureNotificationListbyCellwithData:(NSString *)strValue;
- (void)ConfigureCellWithLiveDataEnquiry:(NSString *)strValue;

@end
