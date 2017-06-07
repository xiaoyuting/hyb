//
//  PersonTableViewCell.m
//  HYB
//
//  Created by CUIZE on 16/8/18.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "PersonTableViewCell.h"

@implementation PersonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.image1=[[UIImageView alloc]initWithFrame:CGRectMake(10, self.contentView.frame.size.height*0.5-7.5, 15, 15)];
    [self.contentView addSubview:self.image1];
    self.image3=[[UIImageView alloc]initWithFrame:CGRectMake(w-25,self.contentView.frame.size.height*0.5-7.5,7,15)];
    [self.contentView addSubview:self.image3];
    self.image2=[[UIImageView alloc]initWithFrame:CGRectMake(w-21-self.contentView.frame.size.height, 2, self.contentView.frame.size.height-4, self.contentView.frame.size.height-4)];
    [self.contentView addSubview:self.image2];
    self.lab1=[[UILabel alloc]initWithFrame:CGRectMake(30, self.contentView.frame.size.height*0.5-7.5, w*0.3, 15)];
    self.lab1.font=[UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.lab1];
    self.lab2=[[UILabel alloc]initWithFrame:CGRectMake(45+w*0.3, self.contentView.frame.size.height*0.5-7.5, w*0.4, 15)];
    self.lab2.font=[UIFont systemFontOfSize:15];
    self.lab2.adjustsFontSizeToFitWidth=YES;
    [self.contentView addSubview:self.lab2];
    UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(10, self.contentView.frame.size.height-1, w-20, 1)];
    line.backgroundColor=lineRGB;
    [self.contentView addSubview:line];
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
