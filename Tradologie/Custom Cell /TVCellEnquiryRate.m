//
//  TVCellEnquiryRate.m
//  Tradologie
//
//  Created by Chandresh Maurya on 16/06/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import "TVCellEnquiryRate.h"
#import "Constant.h"

@implementation TVCellEnquiryRate
{
    UILabel *headLabel;
    UIButton *btnViewRate;
    UIView * bgView;
    NSMutableArray * labelArray;
    NSMutableArray * bgArray;
    NSMutableArray *arrlabel;
    CGSize itemSize;
    NSArray * keyArray;
    BOOL IsEnableTextField ,IsCounterRate;
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
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveIsTextFieldEnable:)
                                                     name:@"IsTextFieldEnable"
                                                   object:nil];
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
        else if (i == keyArray.count - 1)
        {
            arrlabel = [[NSMutableArray alloc]init];
            
            [self setlabelwithIndex:bgView withFrame:CGRectMake(0, 5, 100 , 30) withIndex:0];
            [self setlabelwithIndex:bgView withFrame:CGRectMake(0, 50, 100, 30) withIndex:1];
            
            [labelArray insertObject:arrlabel atIndex:labelArray.count];

        }
        else
        {
           arrlabel = [[NSMutableArray alloc]init];
           
           [self setlabelwithIndex:bgView withFrame:CGRectMake(0, 5, 80 , 30) withIndex:0];
           [self setlabelwithIndex:bgView withFrame:CGRectMake(0, 50, 80, 30) withIndex:1];
           
           [self setlabelwithIndex:bgView withFrame:CGRectMake(90, 5, 110 , 30) withIndex:2];
           [self setlabelwithIndex:bgView withFrame:CGRectMake(90 + 110 + 20, 5, 110 , 30) withIndex:3];

           UITextField *txtCounterRate = [[UITextField alloc]initWithFrame:CGRectMake(90, 50, 110 , 30)];
           [txtCounterRate.layer setBorderWidth:.50f];
           [txtCounterRate setBackgroundColor:[UIColor lightGrayColor]];
           [txtCounterRate setUserInteractionEnabled:NO];
           [bgView addSubview:txtCounterRate];
           [arrlabel insertObject:txtCounterRate atIndex:4];
           
           UITextField *txtQuantity = [[UITextField alloc]initWithFrame:CGRectMake(txtCounterRate.frame.size.width + txtCounterRate.frame.origin.x + 20, txtCounterRate.frame.origin.y, 110 , 30)];
           [txtQuantity.layer setBorderWidth:.50f];
           [txtQuantity setUserInteractionEnabled:NO];
           [txtQuantity setBackgroundColor:[UIColor lightGrayColor]];
           [bgView addSubview:txtQuantity];
          
           [arrlabel insertObject:txtQuantity atIndex:5];
           
          
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
    [lblTittle setBackgroundColor:[UIColor clearColor]];
    [lblTittle setFont:UI_DEFAULT_FONT_BOLD(14)];
    [lblTittle setNumberOfLines:5];
    [lblTittle setTextAlignment:NSTextAlignmentCenter];
    [lblTittle setLineBreakMode:NSLineBreakByWordWrapping];
    [viewBG addSubview:lblTittle];
    [arrlabel insertObject:lblTittle atIndex:Index];
   
}
-(void)setDataDict:(NSMutableDictionary *)dataDict WithIndex:(NSInteger)index
{
    _dataDict = dataDict;
    
    NSMutableArray *arrRate = [[NSMutableArray alloc]init];
    for (NSMutableDictionary * dicRate in [dataDict valueForKey:@"RATE"])
    {
        [arrRate addObject:[dicRate valueForKey:@"Rate"]];
    }
    
    for (int i = 0; i < [labelArray count]; i++)
    {
        if (i == 0)
        {
            UILabel * tempLabel = [labelArray objectAtIndex:0];
            [tempLabel setText:[NSString stringWithFormat:@"      %@",[dataDict objectForKey:[keyArray objectAtIndex:i]]]];
            [tempLabel setTextAlignment:NSTextAlignmentLeft];
        }
        else if (i == 1)
        {
            UILabel * tempLabel = [labelArray objectAtIndex:1];
            [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:1]]];
            [tempLabel setTextAlignment:NSTextAlignmentLeft];
        }
        else if (i == 2)
        {
            UILabel * tempLabel = [labelArray objectAtIndex:2];
            [tempLabel setText:[dataDict objectForKey:[keyArray objectAtIndex:2]]];
            [tempLabel setTextAlignment:NSTextAlignmentCenter];
        }
        else if (i == labelArray.count - 1)
        {
            NSMutableArray *arrObject = [labelArray objectAtIndex:labelArray.count - 1];
            
            for (int j = 0; j < arrObject.count; j++)
            {
                UILabel * tempLabel = [arrObject objectAtIndex:j];
                
                if (j == 0)
                {
                    [tempLabel setText:@"Total"];
                    [tempLabel setTextAlignment:NSTextAlignmentCenter];
                    [tempLabel setFont:UI_DEFAULT_FONT_BOLD(14)];
                }
                else if (j == 1)
                {
                    [tempLabel setText:@"0"];
                    [tempLabel setTextAlignment:NSTextAlignmentCenter];
                    [tempLabel setFont:UI_DEFAULT_FONT_BOLD(14)];
                    
                }
            }
        }
        else
        {
            NSMutableArray *arrObject = [labelArray objectAtIndex:i];
            
            for (int j = 0; j < arrObject.count; j++)
            {
                if (j == 4)
                {
                    UITextField * txtCounterRate = [arrObject objectAtIndex:4];
                    if (IsCounterRate == YES)
                    {
                        [txtCounterRate setUserInteractionEnabled:YES];
                    }
                    else
                    {
                        [txtCounterRate setUserInteractionEnabled:NO];
                    }
                    [txtCounterRate setTextAlignment:NSTextAlignmentLeft];
                }
                else if (j == 5)
                {
                    UITextField * txtQuantity = [arrObject objectAtIndex:5];
                    if (IsEnableTextField == YES)
                    {
                        [txtQuantity setUserInteractionEnabled:YES];
                    }
                    else
                    {
                        [txtQuantity setUserInteractionEnabled:NO];
                    }
                    [txtQuantity setTextAlignment:NSTextAlignmentLeft];
                }
                else
                {
                    UILabel * tempLabel = [arrObject objectAtIndex:j];
                    if (j == 0)
                    {
                        [tempLabel setText:@"Rate"];
                        [tempLabel setTextAlignment:NSTextAlignmentLeft];
                    }
                    else if (j == 1)
                    {
                        [tempLabel setText:[NSString stringWithFormat:@"%@",[arrRate objectAtIndex:i - 3]]];
                        [tempLabel setTextAlignment:NSTextAlignmentLeft];
                    }
                    else if (j == 2)
                    {
                        [tempLabel setText:@"Counter Rate"];
                        [tempLabel setTextAlignment:NSTextAlignmentLeft];
                    }
                    else
                    {
                        [tempLabel setText:@"Quantity"];
                        [tempLabel setTextAlignment:NSTextAlignmentLeft];
                    }
                }
            }
        }
    }
}
- (void)receiveIsTextFieldEnable:(NSNotification *) notification
{
    NSMutableDictionary *dicValue = [[NSMutableDictionary alloc]init];
    dicValue = notification.object;
    
    IsCounterRate = [[dicValue valueForKey:@"CounterOffer"] boolValue];
    IsEnableTextField  = [[dicValue valueForKey:@"Quanitity"] boolValue];
    
    [self setDataDict:_dataDict WithIndex:0];
}

@end
