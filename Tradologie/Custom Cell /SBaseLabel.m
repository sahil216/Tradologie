//
//  SBaseLabel.m
//  OBCDemo
//
//  Created by Mobikasa on 05/06/18.
//  Copyright © 2018 Mobikasa. All rights reserved.
//

#import "SBaseLabel.h"

@implementation SBaseLabel


-(id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])){
        
        if(self.tag == 1){
            self.font = [UIFont fontWithName:@"Helvetica" size:14];
            self.textColor = [UIColor blackColor];
        }
        else{
            self.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
            self.textColor = [UIColor blackColor];
        }
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        
       
   
        
    }
    return self;
}
@end
