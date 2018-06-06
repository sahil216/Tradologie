//
//  LandScapeView.m
//  Tradologie
//
//  Created by Chandresh Maurya on 06/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "LandScapeView.h"

@implementation LandScapeView

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
    [lblPortDischarge setText:dataDict.detail.PortOfDischarge];
    [lblStateofDelivery setText:dataDict.detail.DeliveryState];
    [lblPaymentTerm setText:dataDict.detail.PaymentTerm];
    [lblCurrency setText:dataDict.detail.CurrencyName];
    [lblStatus setText:dataDict.detail.Status];
    
    ([dataDict.detail.StartDate isEqualToString:@""])?[lblStartDate setText:@"N.A"]
    :[lblStartDate setText:dataDict.detail.StartDate];

    ([dataDict.detail.EndDate isEqualToString:@""])?[lblEndDate setText:@"N.A"]
    :[lblEndDate setText:dataDict.detail.EndDate];
    
   
    NSString *strDeliveryLastDate = [NSString stringWithFormat:@"%@",[self datefromCurrentString:dataDict.detail.DeliveryLastDate]];
    [lblDateofDelivery setText:strDeliveryLastDate];
    
    [lblPartialDelivery setText:dataDict.detail.PartialDelivery];
    
    NSString *strPreferredDate = [NSString stringWithFormat:@"%@",[self dateFromString:dataDict.detail.PreferredDate]];
    [lblPrefferedDate setText:strPreferredDate];
    
    [lblTotalQty setText:dataDict.detail.TotalQuantity];
    [lblMinOrder setText:dataDict.detail.MinQuantity];
    [lblBankName setText:dataDict.detail.AuctionCode];
    [lblDeliveryLocation setText:dataDict.detail.DeliveryAddress];
    [lblInspectionAgency setText:dataDict.detail.AgencyCompanyName];
    [lblRemarks setText:dataDict.detail.Remarks];
    
    [btnAddNegotiation addTarget:self action:@selector(btnAddProductNegotiation:) forControlEvents:UIControlEventTouchUpInside];
}

-(NSString *)dateFromString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    [date descriptionWithLocale: [NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"dd-MMM-yyyy HH:mm"];
    NSString *newDate = [dateFormatter stringFromDate:date];
    
    return newDate;
}
-(NSString *)datefromCurrentString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/mm/dd"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    [date descriptionWithLocale: [NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"dd-MMM-yyyy"];
    NSString *newDate = [dateFormatter stringFromDate:date];
    
    return newDate;
}
-(void)btnAddProductNegotiation:(UIButton *)sender
{
    if([_delegate respondsToSelector:@selector(setSelectItemViewWithData:)])
    {
        [_delegate setSelectItemViewWithData:sender];
    }
}
@end
