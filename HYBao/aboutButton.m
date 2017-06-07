//
//  aboutButton.m
//  HYBao
//
//  Created by CUIZE on 16/9/2.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "aboutButton.h"

@implementation aboutButton
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    self.lab=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, frame.size.width*0.3 , frame.size.height-20)];
    [self addSubview:self.lab];
    self.right=[[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-40, 0.5*frame.size.height-7.5,   7, 15)];
    self.right.image=[UIImage imageNamed:@"7.png"];
    [self addSubview:self.right];
    self.foot=[[UIImageView alloc]initWithFrame:CGRectMake(20, frame.size.height-1, frame.size.width-40, 1)];
    self.foot.backgroundColor= [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1];
    [self addSubview:self.foot];
    return self;
}
 @end
