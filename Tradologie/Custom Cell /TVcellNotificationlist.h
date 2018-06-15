//
//  TVcellNotificationlist.h
//  Tradologie
//
//  Created by Chandresh Maurya on 13/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVcellNotificationlist : UITableViewCell
{
    NSIndexPath *selectedIndex;
}
@property (nonatomic,strong) NSMutableDictionary * dataDict;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier itemSize:(CGSize)size headerArray:(NSArray*)headerArray;
@end
