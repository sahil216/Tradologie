//
//  TVCreateNeogotiation.h
//  Tradologie
//
//  Created by Chandresh Maurya on 31/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVCreateNeogotiation : UITableViewController<UITextFieldDelegate>
{
    __weak IBOutlet UILabel *lblReferenceCode;
      UIButton *btnAddNegotiation;
    
    __weak IBOutlet UITextField *txtNegotiationName;
    __weak IBOutlet UITextField *txtInspectionAgency;
    __weak IBOutlet UITextField *txtLocationDelivery;
    __weak IBOutlet UITextField *txtPaymentTerm;
    __weak IBOutlet UITextField *txtAgencyName;
    __weak IBOutlet UITextField *txtAgencyAddress;
    __weak IBOutlet UITextField *txtAgencyPhone;
    __weak IBOutlet UITextField *txtAgencyEmail;
    __weak IBOutlet UITextField *txtCurrency;
    __weak IBOutlet UITextField *txtPartialDelivery;
    __weak IBOutlet UITextField *txtPeferedDate;
    __weak IBOutlet UITextField *txtTotlaQuality;
    __weak IBOutlet UITextField *txtMinOrder;
    __weak IBOutlet UITextField *txtLastDate;
    __weak IBOutlet UITextField *txtDeliveryTerms;

    
}
@property(nonatomic,weak)IBOutlet UIView * viewHeader;
@property(nonatomic,strong) UIView * viewFooter;
@property(nonatomic,strong) NSString * strAuctionGroupID;

@end
