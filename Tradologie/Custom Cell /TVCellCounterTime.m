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
    BOOL isCounterSelected;
    NSString *strValue;
    UIButton *btnCounter;
    UIButton *btnProcessOrder;
    NSString *strServerValue;
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
                                                 selector:@selector(receiveCounterNotification:)
                                                     name:@"CounterTimer"
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveServerTimeNotify:)
                                                     name:@"ServerTimerTime"
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
        else
        {
            arrlabel = [[NSMutableArray alloc]init];
            
            [self setlabelwithIndex:bgView withFrame:CGRectMake(0, 5, bgView.frame.size.width - 30, 30) withIndex:0];
            [self setButtonwithIndex:bgView withFrame:CGRectMake(0, 40,bgView.frame.size.width -20, 35) withIndex:1];
            [self setButtonwithIndex:bgView withFrame:CGRectMake(0, 85,bgView.frame.size.width -20, 35) withIndex:2];
            [self setButtonwithIndex:bgView withFrame:CGRectMake(60,150,bgView.frame.size.width- 120,45) withIndex:3];

//            [self setlabelwithIndex:bgView withFrame:CGRectMake((bgView.frame.size.width/2), 100,(bgView.frame.size.width/2)- 30, 30) withIndex:3];
            [labelArray insertObject:arrlabel atIndex:labelArray.count];
        }
       
        [headLabel setFont:UI_DEFAULT_FONT(15)];
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
    [lblTittle setFont:UI_DEFAULT_FONT_BOLD(15)];
    [lblTittle setNumberOfLines:5];
    [lblTittle setTextAlignment:NSTextAlignmentCenter];
    [lblTittle setLineBreakMode:NSLineBreakByWordWrapping];
    [viewBG addSubview:lblTittle];
    [arrlabel insertObject:lblTittle atIndex:Index];
    
}
-(void)setButtonwithIndex:(UIView *)viewBG withFrame:(CGRect)frame withIndex:(NSInteger)Index
{
    UIButton *btnOffer = [[UIButton alloc]initWithFrame:frame];
    [btnOffer setBackgroundColor:[UIColor clearColor]];
    [btnOffer.titleLabel setFont:UI_DEFAULT_FONT_BOLD(15)];
    [btnOffer.titleLabel setTextAlignment:NSTextAlignmentLeft];
    btnOffer.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [viewBG addSubview:btnOffer];
    [arrlabel insertObject:btnOffer atIndex:Index];
    
}
-(void)setDataDict:(NSMutableDictionary *)dataDict WithIndex:(NSInteger)index WithCounterValue:(NSString *)strCounterValue
    withServerTime:(NSString *)strServertime
{
    _dicdata = dataDict;
    
    NSMutableArray *arrRate = [[NSMutableArray alloc]init];
    //NSMutableArray *arrCounterValue = [[NSMutableArray alloc] init];
    
    for (NSMutableDictionary * dicRate in [dataDict valueForKey:@"RATE"])
    {
        [arrRate addObject:[dicRate valueForKey:@"ParticipateQuantity"]];
    }
    
    for (int i = 0; i < [labelArray count]; i++)
    {
        if (i == 0)
        {
            UILabel * tempLabel = [labelArray objectAtIndex:0];
            [tempLabel setText:@""];
            [tempLabel setTextAlignment:NSTextAlignmentLeft];
        }
        else if (i == 1)
        {
            UILabel * tempLabel = [labelArray objectAtIndex:1];
            [tempLabel setText:@""];
            [tempLabel setTextAlignment:NSTextAlignmentLeft];
        }
        else if (i == 2)
        {
            UILabel * tempLabel = [labelArray objectAtIndex:2];
            [tempLabel setText:@""];
            [tempLabel setTextAlignment:NSTextAlignmentLeft];
        }
        else
        {
    
            NSMutableArray *arrObject = [labelArray objectAtIndex:i];
            
            for (int j = 0; j < arrObject.count; j++)
            {
                if (j == 0)
                {
                    UILabel * tempLabel = [arrObject objectAtIndex:0];
                    [tempLabel setText:[NSString stringWithFormat:@"Participate Qty :- %@",[arrRate objectAtIndex:index]]];
                    [tempLabel setTextAlignment:NSTextAlignmentLeft];
                }
                else
                {
                    if ([strCounterValue isEqualToString:@""] || strCounterValue == nil)
                    {
                        if ([strServertime isEqualToString:@""] || strServertime == nil)
                        {
                            if (j == 1)
                            {
                                UIButton * btnCounterOffer = [arrObject objectAtIndex:1];
                                [btnCounterOffer setTitle:@"Counter Offer TimeOut " forState:UIControlStateNormal];
                                [btnCounterOffer.titleLabel setTextAlignment:NSTextAlignmentRight];
                                [btnCounterOffer setImage:nil forState:UIControlStateNormal];
                                btnCounterOffer.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
                                [btnCounterOffer setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                            }
                            else if (j == 2)
                            {
                                UIButton * btnProceessOrder = [arrObject objectAtIndex:2];
                                [btnProceessOrder setTitle:@"Order Closed " forState:UIControlStateNormal];
                                [btnProceessOrder setImage:nil forState:UIControlStateNormal];
                                [btnProceessOrder.titleLabel setTextAlignment:NSTextAlignmentRight];
                                btnProceessOrder.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
                                [btnProceessOrder setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                            }
                        }
                        else
                        {
                            if (j == 1)
                            {
                                UIButton * btnCounterOffer = [arrObject objectAtIndex:1];
                                [btnCounterOffer setTitle:@"Counter Offer TimeOut " forState:UIControlStateNormal];
                                [btnCounterOffer.titleLabel setTextAlignment:NSTextAlignmentRight];
                                [btnCounterOffer setImage:nil forState:UIControlStateNormal];
                                btnCounterOffer.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
                                [btnCounterOffer setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                            }
                            else if (j == 2)
                            {
                                UIButton * btnProceessOrder = [arrObject objectAtIndex:2];
                                [btnProceessOrder setTitle:[NSString stringWithFormat:@"%@  ",strServertime] forState:UIControlStateNormal];
                                [btnProceessOrder setImage:nil forState:UIControlStateNormal];
                                [btnProceessOrder.titleLabel setTextAlignment:NSTextAlignmentRight];
                                btnProceessOrder.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
                                [btnProceessOrder setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                            }
                            else if (j == 3)
                            {
                                UIButton *btnSubmitOrder = [arrObject objectAtIndex:3];
                                [btnSubmitOrder setTitle:@"PROCESS ORDER" forState:UIControlStateNormal];
                                [btnSubmitOrder.titleLabel setTextAlignment:NSTextAlignmentCenter];
                                btnSubmitOrder.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                                [btnSubmitOrder addTarget:self action:@selector(btnSubmitOrderSelected:) forControlEvents:UIControlEventTouchUpInside];
                                [btnSubmitOrder setDefaultButtonShadowStyle:DefaultThemeColor];
                                [btnSubmitOrder.titleLabel setFont:UI_DEFAULT_FONT_BOLD(16)];
                                
                            }
                        }
                        
                    }
                
                    else
                    {
                        if (j == 1)
                        {
                            UIButton * btnCounterOffer = [arrObject objectAtIndex:1];

                            [btnCounterOffer setTitle:[NSString stringWithFormat:@"   Counter Offer                      %@",strCounterValue] forState:UIControlStateNormal];
                            [btnCounterOffer.titleLabel setTextAlignment:NSTextAlignmentLeft];
                           
                            [btnCounterOffer setImage:IMAGE(@"IconRadioUncheck") forState:UIControlStateNormal];
                            [btnCounterOffer addTarget:self action:@selector(btnCounterSelected:) forControlEvents:UIControlEventTouchUpInside];
                            [btnCounterOffer setTag:1001];
                             btnCounterOffer.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                            [btnCounterOffer setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                        }
                        else if (j == 2)
                        {
                            UIButton * btnProceessOrder = [arrObject objectAtIndex:2];
                            [btnProceessOrder setTitle:[NSString stringWithFormat:@"   Process Order                     %@",strServertime] forState:UIControlStateNormal];
                            [btnProceessOrder setImage:IMAGE(@"IconRadioUncheck") forState:UIControlStateNormal];
                            [btnProceessOrder.titleLabel setTextAlignment:NSTextAlignmentLeft];
                            [btnProceessOrder addTarget:self action:@selector(btnProcessOrderSelected:) forControlEvents:UIControlEventTouchUpInside];
                            [btnProceessOrder setTag:1002];
                            btnProceessOrder.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                            [btnProceessOrder setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                        }
                        else if (j == 3)
                        {
                            UIButton *btnSubmitOrder = [arrObject objectAtIndex:3];
                            if(isCounterSelected == NO)
                            {
                                [btnSubmitOrder setTitle:@"SUBMIT" forState:UIControlStateNormal];
                            }
                            else
                            {
                                [btnSubmitOrder setTitle:@"PROCESS ORDER" forState:UIControlStateNormal];
                            }
                            [btnSubmitOrder.titleLabel setTextAlignment:NSTextAlignmentCenter];
                            btnSubmitOrder.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                            [btnSubmitOrder addTarget:self action:@selector(btnSubmitOrderSelected:) forControlEvents:UIControlEventTouchUpInside];
                            [btnSubmitOrder setDefaultButtonShadowStyle:DefaultThemeColor];
                            [btnSubmitOrder.titleLabel setFont:UI_DEFAULT_FONT_BOLD(16)];
                            
                        }
                    }
                }
            }
        }
    }
}
- (void) receiveCounterNotification:(NSNotification *) notification
{
    strValue = [NSString stringWithFormat:@"%@",notification.object];
    [self setDataDict:_dicdata WithIndex:0 WithCounterValue:strValue withServerTime:strServerValue];
}
- (void) receiveServerTimeNotify:(NSNotification *) notification
{
   strServerValue = [NSString stringWithFormat:@"%@",notification.object];
    [self setDataDict:_dicdata WithIndex:0 WithCounterValue:strValue withServerTime:strServerValue];
}
-(IBAction)btnCounterSelected:(id)sender
{
    btnCounter = (UIButton *)sender;
    [btnCounter setSelected:YES];
    if ([btnCounter.titleLabel.text containsString:@"Counter"])
    {
        [btnCounter setImage:IMAGE(@"IconRadioCheck") forState:UIControlStateSelected];
        isCounterSelected = NO;
        [btnProcessOrder setSelected:NO];

        NSMutableDictionary *dicValue = [[NSMutableDictionary alloc]init];
        [dicValue setObject:@0 forKey:@"Quanitity"];
        [dicValue setObject:@1 forKey:@"CounterOffer"];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"IsTextFieldEnable" object:dicValue];
    }
}

-(IBAction)btnProcessOrderSelected:(id)sender
{
    btnProcessOrder = (UIButton *)sender;
    [btnProcessOrder setSelected:YES];

    if ([btnProcessOrder.titleLabel.text containsString:@"Process"])
    {
        [btnProcessOrder setImage:IMAGE(@"IconRadioCheck") forState:UIControlStateSelected];
        isCounterSelected = YES;
        [btnCounter setSelected:NO];

        NSMutableDictionary *dicValue = [[NSMutableDictionary alloc]init];
        [dicValue setObject:@1 forKey:@"Quanitity"];
        [dicValue setObject:@0 forKey:@"CounterOffer"];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"IsTextFieldEnable" object:dicValue];
       
    }
}

-(IBAction)btnSubmitOrderSelected:(UIButton *)sender
{
    
}

    
@end
