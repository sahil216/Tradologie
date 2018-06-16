//
//  TVCellSupplierList.m
//  Tradologie
//
//  Created by Chandresh Maurya on 05/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "TVCellSupplierList.h"
#import "Constant.h"
#import "CommonUtility.h"

@implementation TVCellSupplierList

/******************************************************************************************************************/
#pragma mark ❉===❉=== TABLEVIEW CELL METHOD CALLED HERE ===❉===❉
/*****************************************************************************************************************/
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [CommonUtility GetShadowWithBorder:_viewBG];
    
    [_lblCompanyName setNumberOfLines:0];
    [_lblCompanyName setLineBreakMode:NSLineBreakByWordWrapping];
    [_btnAddShort addTarget:self action:@selector(btnAddShortTapped:) forControlEvents:UIControlEventTouchUpInside];
    [_btnMicroSite setDefaultButtonShadowStyle:[UIColor redColor]];
    [_btnMicroSite.titleLabel setFont:IS_IPHONE5? UI_DEFAULT_FONT_MEDIUM(12):UI_DEFAULT_FONT_MEDIUM(14)];
    [_btnMicroSite addTarget:self action:@selector(btnMicroSiteTapped:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)ConfigureSupplierCellwithData:(SupplierDetailData *)objSupplierDetail withIsselected:(BOOL)isSelected
{
    [_lblCompanyName setText:objSupplierDetail.CompanyName];
    
    [_lblAreaofOperation setText:[objSupplierDetail.AreaOfOperation isEqualToString:@""] ?[NSString stringWithFormat:@"Area of Operation : N/A"]:[NSString stringWithFormat:@"Area of Operation : %@",objSupplierDetail.AreaOfOperation]];
    
    [_lblyearOfEstablish setText:[objSupplierDetail.YearOfEstablishment isEqualToString:@""]?[NSString stringWithFormat:@"Year of Establishment : N/A"]:[NSString stringWithFormat:@"Year of Establishment : %@",objSupplierDetail.YearOfEstablishment]];
    
    [_lblAnualTurnOver setText:[objSupplierDetail.AnnualTurnOver isEqualToString:@""] ?[NSString stringWithFormat:@"Annual TurnOver : N/A"]:[NSString stringWithFormat:@"Annual TurnOver : %@",objSupplierDetail.AnnualTurnOver]];
    
    [_lblCertification setText:[objSupplierDetail.Certifications isEqualToString:@""]?[NSString stringWithFormat:@"Certifications : N/A"]:[NSString stringWithFormat:@"Certifications : %@",objSupplierDetail.Certifications]];
    
    if (objSupplierDetail.WebURL == (id)[NSNull null] || objSupplierDetail.WebURL.length == 0)
    {
        [_btnMicroSite setHidden:YES];
    }
    else{
        [_btnMicroSite setHidden:NO];
    }
    
    if (isSelected)
    {
        [_btnAddShort setTitle:@"Remove from Shortlist" forState:UIControlStateNormal];
        [_btnAddShort setDefaultButtonShadowStyle:[UIColor redColor]];
        _btnWidth.constant = 170;
    }
    else
    {
        [_btnAddShort setTitle:@"Add to Shortlist" forState:UIControlStateNormal];
        [_btnAddShort setDefaultButtonShadowStyle:GET_COLOR_WITH_RGB(0, 145, 147, 1)];
        _btnWidth.constant = 130;
    }
    
    [_imgMembershipType setImageWithURL:[NSURL URLWithString:[objSupplierDetail.MembershipTypeImage checkIfEmpty]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         [self->_imgMembershipType setImage:image];
     }usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    
    [_imgSupplier setImageWithURL:[NSURL URLWithString:[objSupplierDetail.VendorLogo checkIfEmpty]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         if (!error)
         {
             if(cacheType == SDImageCacheTypeNone)
             {
                 self->_imgSupplier.alpha = 0;
                 
                 [UIView transitionWithView:self->_imgSupplier
                                   duration:1.0
                                    options:UIViewAnimationOptionTransitionCrossDissolve
                                 animations:^{
                                     if (image==nil)
                                     {
                                         [self->_imgSupplier setImage:[UIImage imageNamed:@"IconNoImageAvailable"]];
                                     }
                                     else
                                     {
                                         [self->_imgSupplier setImage:image];
                                     }
                                     
                                     self->_imgSupplier.alpha = 1.0;
                                 } completion:NULL];
             }
             else
             {
                 self->_imgSupplier.alpha = 1;
             }
         }
         else
         {
             [self->_imgSupplier setImage:[UIImage imageNamed:@"IconNoImageAvailable"]];
         }
     } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
}

- (void)ConfigureSupplierCellwithData:(SupplierDetailData *)objSupplierDetail withIndex:(NSIndexPath *)index
{
    [_lblCompanyName setText:objSupplierDetail.CompanyName];
    
    [_lblAreaofOperation setText:[objSupplierDetail.AreaOfOperation isEqualToString:@""] ?[NSString stringWithFormat:@"Area of Operation : N/A"]:[NSString stringWithFormat:@"Area of Operation : %@",objSupplierDetail.AreaOfOperation]];
    
    [_lblyearOfEstablish setText:[objSupplierDetail.YearOfEstablishment isEqualToString:@""]?[NSString stringWithFormat:@"Year of Establishment : N/A"]:[NSString stringWithFormat:@"Year of Establishment : %@",objSupplierDetail.YearOfEstablishment]];
    
    [_lblAnualTurnOver setText:[objSupplierDetail.AnnualTurnOver isEqualToString:@""] ?[NSString stringWithFormat:@"Annual TurnOver : N/A"]:[NSString stringWithFormat:@"Annual TurnOver : %@",objSupplierDetail.AnnualTurnOver]];
    
    [_lblCertification setText:[objSupplierDetail.Certifications isEqualToString:@""]?[NSString stringWithFormat:@"Certifications : N/A"]:[NSString stringWithFormat:@"Certifications : %@",objSupplierDetail.Certifications]];
    
    if (objSupplierDetail.WebURL == (id)[NSNull null] || objSupplierDetail.WebURL.length == 0)
    {
        [_btnMicroSite setHidden:YES];
    }
    else{
        [_btnMicroSite setHidden:NO];
    }
    
    [_btnAddShort setTitle:@"Remove from Shortlist" forState:UIControlStateNormal];
    [_btnAddShort setDefaultButtonShadowStyle:[UIColor redColor]];
    _btnWidth.constant = 170;
    
    [_imgMembershipType setImageWithURL:[NSURL URLWithString:[objSupplierDetail.MembershipTypeImage checkIfEmpty]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         [self->_imgMembershipType setImage:image];
     }usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    
    [_imgSupplier setImageWithURL:[NSURL URLWithString:[objSupplierDetail.VendorLogo checkIfEmpty]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         if (!error)
         {
             if(cacheType == SDImageCacheTypeNone)
             {
                 self->_imgSupplier.alpha = 0;
                 [UIView transitionWithView:self->_imgSupplier
                                   duration:1.0
                                    options:UIViewAnimationOptionTransitionCrossDissolve
                                 animations:^{
                                     if (image==nil)
                                     {
                                         [self->_imgSupplier setImage:[UIImage imageNamed:@"IconNoImageAvailable"]];
                                     }
                                     else
                                     {
                                         [self->_imgSupplier setImage:image];
                                     }
                                     
                                     self->_imgSupplier.alpha = 1.0;
                                 } completion:NULL];
             }
             else
             {
                 self->_imgSupplier.alpha = 1;
             }
         }
         else
         {
             [self->_imgSupplier setImage:[UIImage imageNamed:@"IconNoImageAvailable"]];
         }
     } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
}
/******************************************************************************************************************/
#pragma mark ❉===❉===  BUTTON ACTION EVENT CALLED HERE ===❉===❉
/******************************************************************************************************************/
-(IBAction)btnAddShortTapped:(UIButton *)sender
{
    if([_delegate respondsToSelector:@selector(setSelectItemViewWithData:)])
    {
        [_delegate setSelectItemViewWithData:sender];
    }
}
-(IBAction)btnMicroSiteTapped:(UIButton *)sender
{
    if([_delegate respondsToSelector:@selector(setbtnMicroSiteWithURL:)])
    {
        [_delegate setbtnMicroSiteWithURL:sender];
    }
}
@end

