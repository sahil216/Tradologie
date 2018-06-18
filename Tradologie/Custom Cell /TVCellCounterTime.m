//
//  TVCellCounterTime.m
//  Tradologie
//
//  Created by Chandresh Maurya on 18/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "TVCellCounterTime.h"
#import "Constant.h"

@implementation TVCellCounterTime
{
    UILabel *headLabel;
    UIButton *btnViewRate;
    UIView * bgView;
    NSMutableArray * labelArray;
    NSMutableArray * bgArray;
    NSMutableArray *arrlabel;
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
    
    int width = 80;
    for(int i = 0 ; i < [keyArray count] ; i++)
    {
        
        bgView = [[UIView alloc] initWithFrame:CGRectMake(xx, 0, width, itemSize.height)];
        [bgView setBackgroundColor:[UIColor whiteColor]];
       
        if (i == 0)
        {
            headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, bgView.frame.size.width , bgView.frame.size.height)];
            [headLabel setBackgroundColor:[UIColor clearColor]];
            [bgView addSubview:headLabel];
            [labelArray addObject:headLabel];
        }
        else if (i == 1)
        {
            headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, bgView.frame.size.width , bgView.frame.size.height)];
            [headLabel setBackgroundColor:[UIColor clearColor]];
            [bgView addSubview:headLabel];
            [labelArray addObject:headLabel];
        }
        else if (i == 2)
        {
            headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, bgView.frame.size.width , bgView.frame.size.height)];
            [headLabel setBackgroundColor:[UIColor clearColor]];
            [bgView addSubview:headLabel];
            [labelArray addObject:headLabel];
        }
        else
        {
            arrlabel = [[NSMutableArray alloc]init];
            
            [self setlabelwithIndex:bgView withFrame:CGRectMake(0, 5, 150 , 30) withIndex:0];
            [self setlabelwithIndex:bgView withFrame:CGRectMake(0, 50, 150, 30) withIndex:1];
            [labelArray insertObject:arrlabel atIndex:labelArray.count];
        }
       
        
        [headLabel setFont:UI_DEFAULT_FONT(14)];
        [headLabel setNumberOfLines:5];
        [headLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [self addSubview:bgView];
        
        UILabel *lblline = [[UILabel alloc]init];
        [lblline setFrame:CGRectMake(0, bgView.frame.size.height + 5, width, 1)];
        [lblline setBackgroundColor:[UIColor lightGrayColor]];
        [bgView addSubview:lblline];
        [bgArray addObject:bgView];
        
        xx = xx + width;
        
        if (i == 0)
        {
            width = 150;
        }
        else if (i == 1)
        {
            width = 120;
        }
        else if (i == keyArray.count - 1)
        {
            width = 100;
        }
        else
        {
            width = itemSize.width;
        }
    }
}
-(void)setlabelwithIndex:(UIView *)viewBG withFrame:(CGRect)frame withIndex:(NSInteger)Index
{
    UILabel *lblTittle = [[UILabel alloc]initWithFrame:frame];
    [lblTittle setBackgroundColor:[UIColor grayColor]];
    [lblTittle setFont:UI_DEFAULT_FONT_BOLD(14)];
    [lblTittle setNumberOfLines:5];
    [lblTittle setTextAlignment:NSTextAlignmentCenter];
    [lblTittle setLineBreakMode:NSLineBreakByWordWrapping];
    [viewBG addSubview:lblTittle];
    [arrlabel insertObject:lblTittle atIndex:Index];
    
}
-(void)setDataDict:(NSMutableDictionary *)dataDict WithIndex:(NSInteger)index
{
//    NSMutableArray *arrRate = [[NSMutableArray alloc]init];
//    for (NSMutableDictionary * dicRate in [dataDict valueForKey:@"RATE"])
//    {
//        [arrRate addObject:[dicRate valueForKey:@"Rate"]];
//    }
//    for (int i = 0; i < [labelArray count]; i++)
//    {
//        if (i == 0)
//        {
//            UILabel * tempLabel = [labelArray objectAtIndex:0];
//            [tempLabel setText:@""];
//            [tempLabel setTextAlignment:NSTextAlignmentLeft];
//        }
//        else if (i == 1)
//        {
//            UILabel * tempLabel = [labelArray objectAtIndex:1];
//            [tempLabel setText:@""];
//            [tempLabel setTextAlignment:NSTextAlignmentLeft];
//        }
//        else if (i == 2)
//        {
//            UILabel * tempLabel = [labelArray objectAtIndex:2];
//            [tempLabel setText:@""];
//            [tempLabel setTextAlignment:NSTextAlignmentCenter];
//        }
//        else
//        {
//            NSMutableArray *arrObject = [labelArray objectAtIndex:i];
//
//            for (int j = 0; j < arrObject.count; j++)
//            {
//                UILabel * tempLabel = [arrObject objectAtIndex:j];
//                if (j == 0)
//                {
//                    [tempLabel setText:@"Rate"];
//                    [tempLabel setTextAlignment:NSTextAlignmentLeft];
//                }
//                else if (j == 1)
//                {
//                    [tempLabel setText:[NSString stringWithFormat:@"%@",[arrRate objectAtIndex:i - 3]]];
//                    [tempLabel setTextAlignment:NSTextAlignmentLeft];
//                }
//                else if (j == 2)
//                {
//                    [tempLabel setText:@"Counter Rate"];
//                    [tempLabel setTextAlignment:NSTextAlignmentLeft];
//                }
//                else
//                {
//                    [tempLabel setText:@"Quantity"];
//                    [tempLabel setTextAlignment:NSTextAlignmentLeft];
//                }
            //}
//        }
//    }
    
}

@end
