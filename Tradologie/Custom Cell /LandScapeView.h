//
//  LandScapeView.h
//  Tradologie
//
//  Created by Chandresh Maurya on 06/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstant.h"

@protocol LandScapeViewDelegate <NSObject>

- (void)setSelectItemViewWithData:(UIButton *)sender;

@end

@interface LandScapeView : UIView
{
    __weak IBOutlet UILabel *lblNegotiationCode;
    __weak IBOutlet UILabel *lblNegotiationName;
    __weak IBOutlet UILabel *lblPortDischarge;
    __weak IBOutlet UILabel *lblStateofDelivery;
    __weak IBOutlet UILabel *lblPaymentTerm;
    __weak IBOutlet UILabel *lblCurrency;
    __weak IBOutlet UILabel *lblStatus;
    __weak IBOutlet UILabel *lblStartDate;
    __weak IBOutlet UILabel *lblEndDate;
    __weak IBOutlet UILabel *lblDateofDelivery;
    __weak IBOutlet UILabel *lblPartialDelivery;
    __weak IBOutlet UILabel *lblPrefferedDate;
    __weak IBOutlet UILabel *lblTotalQty;
    __weak IBOutlet UILabel *lblMinOrder;
    __weak IBOutlet UILabel *lblBankName;
    __weak IBOutlet UILabel *lblDeliveryLocation;
    __weak IBOutlet UILabel *lblInspectionAgency;
    __weak IBOutlet UILabel *lblRemarks;
    __weak IBOutlet UIButton *btnAddNegotiation;
    __weak IBOutlet UIButton *btnEditNegotiation;
}
@property (nonatomic,assign) id<LandScapeViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame;
-(void)setDataDict:(AuctionDetailForEdit *)dataDict;
@end
