//
//  TVCellEnquiryRate.h
//  Tradologie
//
//  Created by Chandresh Maurya on 16/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVCellEnquiryRate : UITableViewCell
{
    NSIndexPath *selectedIndex;
}
//@property (nonatomic,strong) NSMutableDictionary * dataDict;
-(void)setDataDict:(NSMutableDictionary *)dataDict WithIndex:(NSInteger)index;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier itemSize:(CGSize)size headerArray:(NSArray*)headerArray;

@end
