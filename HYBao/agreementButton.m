//
//  agreementButton.m
//  HYBao
//
//  Created by CUIZE on 16/9/8.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "agreementButton.h"

@implementation agreementButton


- (id)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    self.pic=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.height,frame.size.height)];
    self.lab=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.height, 0,frame.size.width-frame.size.height, frame.size.height)];
    self.lab.adjustsFontSizeToFitWidth=YES;
    self.lab.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.lab];
    [self addSubview:self.pic];
    return self;
}

@end
