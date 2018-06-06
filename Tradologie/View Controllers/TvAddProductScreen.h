//
//  TvAddProductScreen.h
//  Tradologie
//
//  Created by Chandresh Maurya on 06/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TvAddProductScreen : UITableViewController
{
    __weak IBOutlet UITextField *txtProductName;
    __weak IBOutlet UITextField *txtGrade;
    __weak IBOutlet UITextField *txtQuality;
    __weak IBOutlet UITextField *txtProductType;
    __weak IBOutlet UITextField *txtProductUnit;
    __weak IBOutlet UITextField *txtPackingType;
    __weak IBOutlet UITextField *txtPackingSize;
    __weak IBOutlet UITextField *txtTotalQty;
    __weak IBOutlet UITextField *txtSpecification;
    
    __weak IBOutlet UIButton *btnSubmit;
    __weak IBOutlet UIButton *btnImagePickUp;
    
}
@end
