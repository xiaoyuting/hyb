//
//  modelCell.m
//  HYB
//
//  Created by CUIZE on 16/8/23.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "modelCell.h"
#import "Head.h"
@implementation modelCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self addContent];
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//添加控件
-(void)addContent
{
    //头像
    _icon=[[UIImageView alloc] init];
   // _icon.frame=CGRectMake(SPACING, SPACING, ICONW, ICONH);
    //_icon.layer.cornerRadius =ICONW/2.0;
    _icon.layer.masksToBounds = YES;
    [ _icon.layer setBorderWidth:1];
    [ _icon.layer setBorderColor:[UIColor whiteColor].CGColor];  //设置边框为白色
    [self.contentView addSubview:_icon];
    //昵称
    
    _name=[[UILabel alloc] initWithFrame:CGRectMake(80, 15, 60, 20)];
    
    _name.adjustsFontSizeToFitWidth=YES;
 
    //_name.font=[UIFont systemFontOfSize:NAMEFONT];
    [self.contentView addSubview:_name];
    //评论时间
    _time=[[UILabel alloc]initWithFrame:CGRectZero];
    _time.adjustsFontSizeToFitWidth=YES;
    _time.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:_time];
    //内容
    _text=[[UILabel alloc]init];
 
    [self.contentView addSubview:_text];
    
    self.line=[[UIImageView alloc]init];
    self.line.backgroundColor=lineRGB;
    [self.contentView addSubview:self.line];
}


//设置内容
-(CGFloat)add:(NSDictionary*)mesinfo
{
    CGFloat height=15;
    self. text.numberOfLines=0;
    self.text.font=[UIFont systemFontOfSize:16];
    
    self. text.text= [NSString stringWithFormat:@"%@", [mesinfo objectForKey:@"msgContent"]];
    self.time.text=[NSString stringWithFormat:@"%@", [mesinfo objectForKey:@"createdatetime"]];

    CGSize textSize=[self.text.text boundingRectWithSize:CGSizeMake(w-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    
    CGFloat textH=textSize.height;
    self.text.frame=CGRectMake(20, 15, w-40, textH);
    height=textH+height;
    self.time.frame=CGRectMake(0, height, w-20, 20);
    self.line.frame=CGRectMake(20, height+29, w-40, 1);
    return height+30;
}

@end
