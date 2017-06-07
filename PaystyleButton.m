//
//  PaystyleButton.m
//  HYB
//
//  Created by CUIZE on 16/8/29.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "PaystyleButton.h"

@implementation PaystyleButton
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    self.imageleft=[[UIImageView alloc]initWithFrame:CGRectMake(2,2 ,frame.size.height-4, frame.size.height-4)];
    [self addSubview:self.imageleft];
    self.lab=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.height+10, frame.size.height/2.0-13,0.3*frame.size.width, 26)];
    [self addSubview:self.lab];
    self.imagerihght =[[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-60, frame.size.height/2.0-15, 30, 30)];
    [self addSubview:self.imagerihght];
    return self;
}
@end
