//
//  CardButton.m
//  HYBao
//
//  Created by CUIZE on 16/9/7.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "CardButton.h"

@implementation CardButton
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    self.pic=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5,frame.size.width*0.2,frame.size.width*0.16)];
    self.pic1=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5,frame.size.width*0.2,frame.size.width*0.2)];

    self.name=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width*0.2+10, 5, 0.8*frame.size.width-20, frame.size.height*0.2)];
    self.name.textColor=[UIColor whiteColor];
    self.detail=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width*0.2+10, 10+frame.size.height*0.2, 0.8*frame.size.width-20 , frame.size.height*0.2)];
   
     self.detail.textColor=[UIColor whiteColor];
    self.number=[[UILabel alloc]initWithFrame:CGRectMake(frame.size.width*0.2+10, 0.8*frame.size.height-5,0.7*frame.size.width-30 , frame.size.height*0.2)];
     self.number.textColor=[UIColor whiteColor];
    [self addSubview:self.number];
    [self addSubview:self.detail];
    [self addSubview:self.name];
    [self addSubview:self.pic];
     [self addSubview:self.pic1];
    return self;
}

@end
