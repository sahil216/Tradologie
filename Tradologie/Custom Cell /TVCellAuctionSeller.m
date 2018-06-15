//
//  TVCellAuctionSeller.m
//  Tradologie
//
//  Created by Chandresh Maurya on 15/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "TVCellAuctionSeller.h"
#import "Constant.h"

@implementation TVCellAuctionSeller

{
    UILabel *headLabel;
    UIButton *btnViewRate;
    UIView * bgView;
    NSMutableArray * labelArray;
    NSMutableArray * bgArray;
    CGSize itemSize;
    NSArray * keyArray;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier itemSize:(CGSize)size headerArray:(NSArray*)headerArray
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        itemSize = size;
        keyArray = headerArray;
        labelArray = [NSMutableArray new];
        bgArray = [NSMutableArray new];
        [self setupLabel];
    }
    return self;
}

- (void)setupLabel
{
    int xx = 0;
    
    int width = 150;
    for(int i = 0 ; i < [keyArray count] ; i++)
    {
        
        bgView = [[UIView alloc] initWithFrame:CGRectMake(xx, 0, width, itemSize.height)];
        [bgView setBackgroundColor:[UIColor whiteColor]];
        
        
        headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, bgView.frame.size.width - 30 , bgView.frame.size.height)];
        [headLabel setBackgroundColor:[UIColor clearColor]];
        [headLabel setFont:UI_DEFAULT_FONT(16)];
        [headLabel setNumberOfLines:5];
        [headLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [bgView addSubview:headLabel];
        [labelArray addObject:headLabel];
        
        [self addSubview:bgView];
        
        UILabel *lblline = [[UILabel alloc]init];
        [lblline setFrame:CGRectMake(0, bgView.frame.size.height + 5, width, 1)];
        [lblline setBackgroundColor:[UIColor lightGrayColor]];
        [bgView addSubview:lblline];
        [bgArray addObject:bgView];
        xx = xx + width;
        width = itemSize.width;
    }
}

-(void)setDataDict:(NSMutableDictionary *)dataDict
{
    _dataDict = dataDict;
    
    for (int i = 0; i < [labelArray count]; i++)
    {
        UILabel * tempLabel = [labelArray objectAtIndex:i];
        switch (i)
        {
            case 0:
            {
                [tempLabel setText:[@"  " stringByAppendingString:[dataDict objectForKey:[keyArray objectAtIndex:i]]]];
                [tempLabel setTextAlignment:NSTextAlignmentLeft];
            }
                break;
                
            case 1:
            {
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i]]];
                [tempLabel setTextAlignment:NSTextAlignmentLeft];
            }
                break;
                
            case 2:
            {
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i]]];
                [tempLabel setTextAlignment:NSTextAlignmentLeft];
            }
                break;
                
            default:
                break;
        }
    }
}
@end
