//
//  TVCellEnquiryRate.h
//  Tradologie
//
//  Created by Chandresh Maurya on 16/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TVCellEnquiryRateDelegate <NSObject>

- (void)setSelectItemViewWithValue:(NSString *)strTextValue;

@end

@interface TVCellEnquiryRate : UITableViewCell<UITextFieldDelegate>
{
    NSIndexPath *selectedIndex;
}
@property (nonatomic,strong) NSMutableDictionary * dataDict;
@property (nonatomic,strong) id <TVCellEnquiryRateDelegate> delegate;

-(void)setDataDict:(NSMutableDictionary *)dataDict WithIndex:(NSInteger)index;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier itemSize:(CGSize)size headerArray:(NSArray*)headerArray;



@end
