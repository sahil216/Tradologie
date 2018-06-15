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
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
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
        
        if (i == 5)
        {
            imgPacking = [[UIImageView alloc]initWithFrame:CGRectMake(25, 5, bgView.frame.size.width - 50 , bgView.frame.size.height -10)];
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

                UIImageView * imgProfilepic = [labelArray objectAtIndex:i];
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
@end
