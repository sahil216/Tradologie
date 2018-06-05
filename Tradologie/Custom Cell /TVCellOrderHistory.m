//
//  TVCellOrderHistory.m
//  Tradologie
//
//  Created by Chandresh Maurya on 04/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "TVCellOrderHistory.h"
#import"AppConstant.h"
#import "Constant.h"
#import "CommonUtility.h"

@implementation TVCellOrderHistory
{
    UILabel *headLabel;
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
    if (self) {
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
    
    int width = 80;
    for(int i = 0 ; i < [keyArray count] ; i++)
    {
        if (i == 5)
        {
            bgView = [[UIView alloc] initWithFrame:CGRectMake(xx, 20, width, itemSize.height - 40)];
        }
        else
        {
            bgView = [[UIView alloc] initWithFrame:CGRectMake(xx, 0, width, itemSize.height)];
        }
        [bgView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:bgView];
        
        headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, bgView.frame.size.width , bgView.frame.size.height)];
        [headLabel setBackgroundColor:[UIColor clearColor]];
        [headLabel setFont:UI_DEFAULT_FONT(16)];
        [headLabel setNumberOfLines:5];
        [headLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [bgView addSubview:headLabel];
        [labelArray addObject:headLabel];
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
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i]]];
                [tempLabel setTextAlignment:NSTextAlignmentCenter];
            }
                break;
                
            case 1:
            {
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i]]];
                [tempLabel setTextAlignment:NSTextAlignmentCenter];
            }
                break;
                
            case 2:
            {
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i]]];
                [tempLabel setTextAlignment:NSTextAlignmentCenter];
            }
                break;
                
            case 3:
            {
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i]]];
                [tempLabel setTextAlignment:NSTextAlignmentCenter];
            }
                break;
                
            case 4:
            {
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i]]];
                [tempLabel setTextAlignment:NSTextAlignmentCenter];
            }
                break;
            case 5:
            {
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i]]];
                [tempLabel setBackgroundColor:DefaultThemeColor];
                [tempLabel setTextColor:[UIColor whiteColor]];
                [tempLabel setTextAlignment:NSTextAlignmentCenter];
            }
                break;
            
            case 6:
            {
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i]]];
                [tempLabel setTextAlignment:NSTextAlignmentCenter];
            }
                break;
            
            case 7:
            {
                NSString *strValue = [NSString stringWithFormat:@"%@",[dataDict objectForKey:[keyArray objectAtIndex:i]]];
                [tempLabel setText:strValue];
                [tempLabel setTextAlignment:NSTextAlignmentCenter];
            }
                
                break;
            case 8:
            {
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i]]];
                [tempLabel setTextAlignment:NSTextAlignmentCenter];
            }
                break;
            case 9:
            {
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i]]];
                [tempLabel setTextAlignment:NSTextAlignmentCenter];
            }
                break;
                
            default:
                break;
        }
    }
}
@end
