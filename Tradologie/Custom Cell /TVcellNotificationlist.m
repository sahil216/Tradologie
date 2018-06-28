//
//  TVcellNotificationlist.m
//  Tradologie
//
//  Created by Chandresh Maurya on 13/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "TVcellNotificationlist.h"
#import "AppConstant.h"
#import "Constant.h"
#import "CommonUtility.h"

@implementation TVcellNotificationlist
{
    UILabel *headLabel;
    UIImageView *imgPacking;
    UIView * bgView;
    NSMutableArray * labelArray;
    NSMutableArray * bgArray;
    CGSize itemSize;
    NSArray * keyArray;
    NSMutableArray *arrlabel;
    NSInteger IsNegotiation;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier itemSize:(CGSize)size headerArray:(NSArray*)headerArray isWithBoolValue:(NSInteger)IsfromNegotiation
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        itemSize = size;
        keyArray = headerArray;
        labelArray = [NSMutableArray new];
        bgArray = [NSMutableArray new];
        IsNegotiation = IsfromNegotiation;
        [self setupLabel];
    }
    return self;
}

- (void)setupLabel
{
    int xx = 0;
    
    int width = 120;
    for(int i = 0 ; i < [keyArray count] ; i++)
    {
        bgView = [[UIView alloc] initWithFrame:CGRectMake(xx, 0, width, itemSize.height)];
        [bgView setBackgroundColor:[UIColor whiteColor]];
        
        if (IsNegotiation == 1)
        {
            if (i == 5)
            {
                imgPacking = [[UIImageView alloc]initWithFrame:CGRectMake(25, 10, 100 , itemSize.height - 20)];
                [imgPacking setBackgroundColor:[UIColor redColor]];
                [bgView addSubview:imgPacking];
                [labelArray addObject:imgPacking];
            }
            else if (i == 0)
            {
                arrlabel = [[NSMutableArray alloc]init];
                [self setlabelwithIndex:bgView withFrame:CGRectMake(10, 5, 50 , 30) withIndex:0];
                UIButton *btnDelete = [[UIButton alloc]initWithFrame:CGRectMake(65, 0, 45 , 45)];
                [btnDelete setBackgroundColor:[UIColor clearColor]];
                [bgView addSubview:btnDelete];
                [arrlabel insertObject:btnDelete atIndex:1];
                [labelArray addObject:arrlabel];
            }
            else
            {
                headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, bgView.frame.size.width , bgView.frame.size.height)];
                [headLabel setBackgroundColor:[UIColor clearColor]];
                [headLabel setFont:UI_DEFAULT_FONT(16)];
                [headLabel setNumberOfLines:5];
                [headLabel setLineBreakMode:NSLineBreakByWordWrapping];
                [bgView addSubview:headLabel];
                [labelArray addObject:headLabel];
                
            }
        }
        else
        {
            if (i == 5)
            {
                imgPacking = [[UIImageView alloc]initWithFrame:CGRectMake(25, 10, 100 , itemSize.height - 20)];
                [imgPacking setBackgroundColor:[UIColor redColor]];
                [bgView addSubview:imgPacking];
                [labelArray addObject:imgPacking];
            }
            else
            {
                headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, bgView.frame.size.width , bgView.frame.size.height)];
                [headLabel setBackgroundColor:[UIColor clearColor]];
                [headLabel setFont:UI_DEFAULT_FONT(16)];
                [headLabel setNumberOfLines:5];
                [headLabel setLineBreakMode:NSLineBreakByWordWrapping];
                [bgView addSubview:headLabel];
                [labelArray addObject:headLabel];
                
            }
        }
        [self addSubview:bgView];
        
        UILabel *lblline = [[UILabel alloc]init];
        [lblline setFrame:CGRectMake(0, bgView.frame.size.height + 5, width + 50, 1)];
        [lblline setBackgroundColor:[UIColor lightGrayColor]];
        [bgView addSubview:lblline];
        [bgArray addObject:bgView];
        xx = xx + width;
        width = itemSize.width;
    }
}
-(void)setlabelwithIndex:(UIView *)viewBG withFrame:(CGRect)frame withIndex:(NSInteger)Index
{
    UILabel *lblTittle = [[UILabel alloc]initWithFrame:frame];
    [lblTittle setBackgroundColor:[UIColor clearColor]];
    [lblTittle setFont:UI_DEFAULT_FONT(16)];
    [lblTittle setNumberOfLines:5];
    [lblTittle setTextAlignment:NSTextAlignmentCenter];
    [lblTittle setLineBreakMode:NSLineBreakByWordWrapping];
    [viewBG addSubview:lblTittle];
    [arrlabel insertObject:lblTittle atIndex:Index];
    
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
                if (IsNegotiation == 1)
                {
                    NSMutableArray *arrlbl = [labelArray objectAtIndex:0];
                    
                    UILabel * lblCount = [arrlbl objectAtIndex:0];
                    [lblCount setText:[dataDict objectForKey:[keyArray objectAtIndex:i]]];
                    [lblCount setTextAlignment:NSTextAlignmentCenter];
                    
                    UIButton *btnDelete = [arrlbl objectAtIndex:1];
                    [btnDelete setTintColor:[UIColor whiteColor]];
                    [btnDelete setDefaultButtonShadowStyle:[UIColor whiteColor]];
                    [btnDelete setImage:[UIImage imageNamed:@"IconDeleteNegotiation"] forState:UIControlStateNormal];
                    [btnDelete addTarget:self action:@selector(btnDeleteTapped:) forControlEvents:UIControlEventTouchUpInside];
                    [btnDelete.titleLabel setTextAlignment:NSTextAlignmentRight];
                }
                else
                {
                    [tempLabel setText:[@"    "stringByAppendingString:[dataDict objectForKey:[keyArray objectAtIndex:i]]]];
                    [tempLabel setTextAlignment:NSTextAlignmentLeft];
                }
            }
                
                break;
                
            case 1:
                [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:i]]];
                [tempLabel setNumberOfLines:5];
                [tempLabel setLineBreakMode:NSLineBreakByWordWrapping];
                [tempLabel setTextAlignment:NSTextAlignmentCenter];
                break;
                
            case 2:
                [tempLabel setText:[NSString stringWithFormat:@"%@",[dataDict objectForKey:[keyArray objectAtIndex:i]]]];
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
            {
               __weak UIImageView * imgProfilepic = [labelArray objectAtIndex:i];
                [imgProfilepic setBackgroundColor:[UIColor clearColor]];
                [imgProfilepic setImageWithURL:[NSURL URLWithString:[[dataDict objectForKey:[keyArray objectAtIndex:i]] checkIfEmpty]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
                 {
                     if (!error)
                     {
                         if(cacheType == SDImageCacheTypeNone)
                         {
                             imgProfilepic.alpha = 0;
                             [UIView transitionWithView:imgProfilepic
                                               duration:1.0
                                                options:UIViewAnimationOptionTransitionCrossDissolve
                                             animations:^{
                                                 if (image==nil)
                                                 {
                                                     [imgProfilepic setImage:[UIImage imageNamed:@"IconNoImageAvailable"]];
                                                 }
                                                 else
                                                 {
                                                     [imgProfilepic setImage:image];
                                                 }
                                                 
                                                imgProfilepic.alpha = 1.0;
                                             } completion:NULL];
                         }
                         else
                         {
                            imgProfilepic.alpha = 1;
                         }
                     }
                     else
                     {
                         [imgProfilepic setImage:[UIImage imageNamed:@"IconNoImageAvailable"]];
                     }
                 } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                
            }
                break;
                
            default:
                break;
        }
    }
}
-(IBAction)btnDeleteTapped:(UIButton *)sender
{
    if([_delegate respondsToSelector:@selector(setSelectItemViewCodeWithData:)])
    {
        NSIndexPath *indexPath = [CommonUtility MB_IndexPathForCellContainingView:sender];
        [_delegate setSelectItemViewCodeWithData:indexPath];
    }
}
@end
