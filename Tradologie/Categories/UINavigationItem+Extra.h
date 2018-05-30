//
//  UINavigationItem+Extra.h
//  Tradologie
//
//  Created by Chandresh Maurya on 09/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (Extra)
-(void)setNavigationTittleWithLogo:(NSString *)strTittle;
-(void)SetBackButtonWithID:(id)targetID withSelectorAction:(SEL)sector;
-(void)setNavigationTittleWithLogoforLanscapeMode:(NSString *)strTittle;
-(void)SetRightButtonWithID:(id)targetID withSelectorAction:(SEL)sector;
@end
