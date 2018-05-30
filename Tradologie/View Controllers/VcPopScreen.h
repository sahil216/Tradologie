//
//  VcPopScreen.h
//  Tradologie
//
//  Created by Chandresh Maurya on 07/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopupViewDelegate <NSObject>

-(void)popupViewSelectedData:(NSMutableArray *)array;

@end

@interface VcPopScreen : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    __weak IBOutlet UIView *viewBG;
    __weak IBOutlet UIButton *btnClose;
}
@property (strong, nonatomic) IBOutlet UITableView *tbtProductCat;
@property (weak, nonatomic) id <PopupViewDelegate>delegate;
@end




@interface ProductsList : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblProductName;
@property (strong, nonatomic) IBOutlet UIImageView *imgCheckBox;

- (void)ConfigureProductsListbyCell;
@end

