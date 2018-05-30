//
//  TvCellEnquiry.m
//  Tradologie
//
//  Created by Chandresh Maurya on 18/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "TvCellEnquiry.h"
#import "AppConstant.h"
#import "Constant.h"
#import "CommonUtility.h"

@implementation TvCellEnquiry
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
        if (i == 2)
        {
             bgView = [[UIView alloc] initWithFrame:CGRectMake(xx, 20, width, itemSize.height - 40)];
        }
        else
        {
             bgView = [[UIView alloc] initWithFrame:CGRectMake(xx, 0, width, itemSize.height)];
        }
        [bgView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:bgView];
        
        if (i ==  1)
        {
            btnViewRate = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, bgView.frame.size.width , bgView.frame.size.height)];
            [btnViewRate setBackgroundColor:[UIColor clearColor]];
            [bgView addSubview:btnViewRate];
            [labelArray addObject:btnViewRate];
        }
        else{
            headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, bgView.frame.size.width , bgView.frame.size.height)];
            [headLabel setBackgroundColor:[UIColor clearColor]];
            [headLabel setFont:UI_DEFAULT_FONT(16)];
            [headLabel setNumberOfLines:5];
            [headLabel setLineBreakMode:NSLineBreakByWordWrapping];
            [bgView addSubview:headLabel];
            [labelArray addObject:headLabel];
        }
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
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i]]];
                [tempLabel setTextAlignment:NSTextAlignmentCenter];
                break;
                
            case 1:
            {
                UIButton *btnRate = [labelArray objectAtIndex:i];
                [btnRate.titleLabel setFont:UI_DEFAULT_FONT(16)];
                [btnViewRate setTintColor:[UIColor clearColor]];
                [btnViewRate setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                [btnRate setTitle:[dataDict objectForKey:[keyArray objectAtIndex:i]] forState:UIControlStateNormal];
                [btnRate addTarget:self action:@selector(btnViewRateTapped:) forControlEvents:UIControlEventTouchUpInside];
                [btnViewRate.titleLabel setTextAlignment:NSTextAlignmentCenter];
            }
                break;
                
            case 2:
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i]]];
                [tempLabel setBackgroundColor:DefaultThemeColor];
                [tempLabel setFont:UI_DEFAULT_FONT(17)];
                [tempLabel setTextColor:[UIColor whiteColor]];
                [tempLabel setTextAlignment:NSTextAlignmentCenter];
                break;
                
            case 3:
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i]]];
                [tempLabel setTextAlignment:NSTextAlignmentCenter];
                break;
                
            case 4:
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i]]];
                [tempLabel setTextAlignment:NSTextAlignmentCenter];
                break;
            case 5:
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i]]];
                [tempLabel setTextAlignment:NSTextAlignmentCenter];
                break;
            case 6:
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i]]];
                [tempLabel setTextAlignment:NSTextAlignmentCenter];
                break;
            case 7:
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i]]];
                [tempLabel setTextAlignment:NSTextAlignmentCenter];
                break;
            case 8:
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i]]];
                [tempLabel setTextAlignment:NSTextAlignmentLeft];
                break;
            case 9:
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i]]];
                [tempLabel setTextAlignment:NSTextAlignmentCenter];
                break;
                
            default:
                break;
        }
    }
}
-(IBAction)btnViewRateTapped:(UIButton *)sender{
    if([_delegate respondsToSelector:@selector(setSelectItemViewWithData:withTittle:)])
    {
        NSIndexPath *indexPath = [CommonUtility MB_IndexPathForCellContainingView:sender];
        [_delegate setSelectItemViewWithData:indexPath withTittle:sender.titleLabel.text];
    }
}

@end
