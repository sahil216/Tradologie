//
//  TVcellNotificationlist.h
//  Tradologie
//
//  Created by Chandresh Maurya on 13/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TVcellNotificationDelegate <NSObject>

- (void)setSelectItemViewCodeWithData:(NSIndexPath *)selectedIndex;

@end

@interface TVcellNotificationlist : UITableViewCell
{
    NSIndexPath *selectedIndex;
}
@property (nonatomic,strong) NSMutableDictionary * dataDict;
@property (nonatomic,assign) id<TVcellNotificationDelegate> delegate;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier itemSize:(CGSize)size headerArray:(NSArray*)headerArray isWithBoolValue:(NSInteger)IsfromNegotiation;
@end
