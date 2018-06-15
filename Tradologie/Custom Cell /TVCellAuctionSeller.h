//
//  TVCellAuctionSeller.h
//  Tradologie
//
//  Created by Chandresh Maurya on 15/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVCellAuctionSeller : UITableViewCell
{
    NSIndexPath *selectedIndex;
}
@property (nonatomic,strong) NSMutableDictionary * dataDict;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier itemSize:(CGSize)size headerArray:(NSArray*)headerArray;
@end

