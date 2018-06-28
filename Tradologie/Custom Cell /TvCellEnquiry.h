//
//  TvCellEnquiry.h
//  Tradologie
//
//  Created by Chandresh Maurya on 18/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TvCellEnquiryDelegate <NSObject>

- (void)setSelectItemViewWithData:(NSIndexPath *)selectedIndex withTittle:(NSString *)btnState;
- (void)setSelectItemViewCodeWithData:(NSIndexPath *)selectedIndex;

@end


@interface TvCellEnquiry : UITableViewCell
{
    NSIndexPath *selectedIndex;
}
@property (nonatomic,strong) NSMutableDictionary * dataDict;
@property (nonatomic,assign) id<TvCellEnquiryDelegate> delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier itemSize:(CGSize)size headerArray:(NSArray*)headerArray;
@end
