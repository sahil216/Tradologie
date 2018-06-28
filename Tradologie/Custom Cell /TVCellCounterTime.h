//
//  TVCellCounterTime.h
//  Tradologie
//
//  Created by Chandresh Maurya on 18/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TVCellCounterTimeDelegate <NSObject>

- (void)setSelectItemViewWithData:(NSIndexPath *)selectedIndex;

@end

@interface TVCellCounterTime : UITableViewCell
{
    NSIndexPath *selectedIndex;
}
@property (nonatomic,strong) NSMutableDictionary * dicdata;
@property (nonatomic,assign) id<TVCellCounterTimeDelegate> delegate;

//-(void)setDataDict:(NSMutableDictionary *)dataDict WithIndex:(NSInteger)index;
-(void)setDataDict:(NSMutableDictionary *)dataDict WithIndex:(NSInteger)index WithCounterValue:(NSString *)strCounterValue
    withServerTime:(NSString *)strServertime withTotalQuantity:(NSString *)Quantity;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier itemSize:(CGSize)size headerArray:(NSArray*)headerArray;

@end
