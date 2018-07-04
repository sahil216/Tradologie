//
//  TVPaymentScreen.h
//  Tradologie
//
//  Created by Chandresh Maurya on 28/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVPaymentScreen : UITableViewController
{
    
}
@property (strong, nonatomic) NSString *strAuctionID;

@end



@interface TVPaymentCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblRefundPayment;
@property (strong, nonatomic) IBOutlet UILabel *lblConvienceFees;
@property (strong, nonatomic) IBOutlet UILabel *lblTotalCharges;
@property (strong, nonatomic) IBOutlet UIButton *btnPayment;
@property (strong, nonatomic) IBOutlet UIButton *btnAccept;


- (void)ConfigurePaymentCellwithData:(NSMutableDictionary *)dicValue;
@end

@interface TVPaymentBankDetailCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblCompanyName;
@property (strong, nonatomic) IBOutlet UILabel *lblAccountNumber;
@property (strong, nonatomic) IBOutlet UILabel *lblIFSCcode;
@property (strong, nonatomic) IBOutlet UILabel *lblBankName;
@property (strong, nonatomic) IBOutlet UILabel *lblBranch;
@property (strong, nonatomic) IBOutlet UILabel *lblRefundAmount;

@property (strong, nonatomic) IBOutlet UIButton *btnSubmit;
@property (strong, nonatomic) IBOutlet UIButton *btnAccept;

- (void)ConfigurePaymentBankDetailCellwithData:(NSString *)strValue;

@end



@interface TVPaymentDetailCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UITextField *txtBankName;
@property (strong, nonatomic) UIDatePicker *ObjdatePicker;

- (void)ConfigurePaymentDetailCellWithData:(NSString *)strValue withIndex:(NSIndexPath *)indexPath;

@end


@protocol TVPaymentPolicyDetailCellDelegate <NSObject>

-(void)setPaymentInformationDetailWithData:(UIButton *)sender;

@end

@interface TVPaymentPolicyDetail : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *btnSubmit;
@property (strong, nonatomic) IBOutlet UIButton *btnAccept;

@property (nonatomic,assign) id<TVPaymentPolicyDetailCellDelegate> delegate;

- (void)ConfigurePaymentPolicyDetailwithData:(NSString *)strValue;
@end
