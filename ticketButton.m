//
//  ticketButton.m
//  HYB
//
//  Created by CUIZE on 16/8/16.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "ticketButton.h"

@implementation ticketButton
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    self.labtitle=[[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height*0.05, frame.size.width , frame.size.height*0.4-1)];
    self.labtitle.adjustsFontSizeToFitWidth=YES;
       self.labtitle.textColor= [UIColor redColor];
    self.labtitle.font= [UIFont fontWithName:@"Helvetica-Bold" size:20];
     // self.labtitle.font = [UIFont fontWithName:@"Helvetica" size:17];
    self.labtitle.textAlignment=NSTextAlignmentCenter;
    self.labInfo=[[UILabel alloc]initWithFrame:CGRectMake(5, frame.size.height*0.5,frame.size.width-10,frame.size.height*0.3)];
    self.labInfo.adjustsFontSizeToFitWidth=YES;
    self.labInfo.textAlignment=NSTextAlignmentCenter;
    self.labInfo.layer.cornerRadius=5;
    self.labInfo.layer.masksToBounds=YES;
    [self.labInfo.layer setBorderWidth:1];
    [self.labInfo.layer setBorderColor:[UIColor clearColor].CGColor];
    self.labInfo.backgroundColor =[UIColor colorWithRed:195/255.0 green:80/255.0 blue:82/255.0 alpha:1];
    self.labInfo.textColor=[UIColor whiteColor];
    [self addSubview:self.labInfo];
    [self addSubview:self.labtitle];
    return self;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
