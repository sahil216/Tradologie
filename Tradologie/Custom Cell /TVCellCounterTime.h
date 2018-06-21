//
//  TVCellCounterTime.h
//  Tradologie
//
//  Created by Chandresh Maurya on 18/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TVCellCounterTime : UITableViewCell
{
    NSIndexPath *selectedIndex;
}
@property (nonatomic,strong) NSMutableDictionary * dicdata;

//-(void)setDataDict:(NSMutableDictionary *)dataDict WithIndex:(NSInteger)index;
-(void)setDataDict:(NSMutableDictionary *)dataDict WithIndex:(NSInteger)index WithCounterValue:(NSString *)strCounterValue
    withServerTime:(NSString *)strServertime;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier itemSize:(CGSize)size headerArray:(NSArray*)headerArray;

@end
