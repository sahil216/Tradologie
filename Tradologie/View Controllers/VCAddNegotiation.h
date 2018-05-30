//
//  VCAddNegotiation.h
//  Tradologie
//
//  Created by Chandresh Maurya on 26/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EveryPage.h"
#import "AppConstant.h"

@interface VCAddNegotiation : EveryPage<UITextFieldDelegate>
{
    __weak IBOutlet UIButton *btnContactUs;
    __weak IBOutlet UITextField *txtCategory;
    __weak IBOutlet UIView *viewFooter;
}
@property (strong, nonatomic) IBOutlet UITableView *tbtNegotiation;

@end


@protocol SupplierCellDelegate <NSObject>

-(void)setSelectItemViewWithData:(UIButton *)sender;
-(void)setbtnMicroSiteWithURL:(UIButton *)sender;

@end

@interface SupplierCell : UITableViewCell

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *btnWidth;
@property (strong, nonatomic) IBOutlet UIView *viewBG;
@property (strong, nonatomic) IBOutlet UILabel *lblCompanyName;
@property (strong, nonatomic) IBOutlet UILabel *lblyearOfEstablish;
@property (strong, nonatomic) IBOutlet UILabel *lblAnualTurnOver;
@property (strong, nonatomic) IBOutlet UILabel *lblAreaofOperation;
@property (strong, nonatomic) IBOutlet UILabel *lblCertification;
@property (strong, nonatomic) IBOutlet UIButton *btnAddShort;
@property (strong, nonatomic) IBOutlet UIButton *btnMicroSite;
@property (assign, nonatomic) IBOutlet UIImageView *imgSupplier;
@property (assign, nonatomic) IBOutlet UIImageView *imgMembershipType;
@property (nonatomic,assign) id<SupplierCellDelegate> delegate;


- (void)ConfigureSupplierCellwithData:(SupplierDetailData *)objSupplierDetail withIsselected:(BOOL)isSelected;

@end
