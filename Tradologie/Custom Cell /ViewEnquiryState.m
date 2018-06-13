//
//  ViewEnquiryState.m
//  Tradologie
//
//  Created by Chandresh Maurya on 13/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "ViewEnquiryState.h"
#import "CommonUtility.h"

@implementation ViewEnquiryState
- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        
    }
    return self;
}
-(void)setDataDict:(AuctionDetailForEdit *)dataDict
{
    [lblNegotiationCode setText:dataDict.detail.AuctionCode];
    [lblNegotiationName setText:dataDict.detail.AuctionName];
    ([dataDict.detail.PortOfDischarge isEqualToString:@""])?[lblPortDischarge setText:@"N.A"]
    :[lblPortDischarge setText:dataDict.detail.PortOfDischarge];
    [lblStateofDelivery setText:dataDict.detail.DeliveryState];
    [lblPaymentTerm setText:dataDict.detail.PaymentTerm];
    [lblCurrency setText:dataDict.detail.CurrencyName];
    [lblStatus setText:dataDict.detail.Status];
    
    ([dataDict.detail.StartDate isEqualToString:@""])?[lblStartDate setText:@"N.A"]
    :[lblStartDate setText:dataDict.detail.StartDate];
    
    ([dataDict.detail.EndDate isEqualToString:@""])?[lblEndDate setText:@"N.A"]
    :[lblEndDate setText:dataDict.detail.EndDate];
    
    
//    NSString *strDeliveryLastDate = [NSString stringWithFormat:@"%@",[self datefromCurrentString:dataDict.detail.DeliveryLastDate]];
    
    NSString *strDeliveryLastDate = [CommonUtility getDateFromSting:dataDict.detail.DeliveryLastDate fromFromate:@"yyyy/mm/dd" withRequiredDateFormate:@"dd-MMM-yyyy"];
    [lblDateofDelivery setText:strDeliveryLastDate];
    
    [lblPartialDelivery setText:dataDict.detail.PartialDelivery];
    
    NSString *strPreferredDate = [CommonUtility getDateFromSting:dataDict.detail.PreferredDate fromFromate:@"MM/dd/yyyy hh:mm:ss a" withRequiredDateFormate:@"dd-MMM-yyyy HH:mm"];
    [lblPrefferedDate setText:strPreferredDate];
    
    [lblTotalQty setText:dataDict.detail.TotalQuantity];
    [lblMinOrder setText:dataDict.detail.MinQuantity];
    [lblBankName setText:dataDict.detail.AuctionCode];
    [lblDeliveryLocation setText:dataDict.detail.DeliveryAddress];
    [lblInspectionAgency setText:dataDict.detail.AgencyCompanyName];
    NSString * newReplacedString = [dataDict.detail.Remarks stringByReplacingOccurrencesOfString:@"\r\n" withString:@". "];
    
    [lblRemarks setText:newReplacedString];
    
}

@end
