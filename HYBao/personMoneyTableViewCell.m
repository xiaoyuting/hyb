//
//  personMoneyTableViewCell.m
//  HYBao
//
//  Created by CUIZE on 16/9/4.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "personMoneyTableViewCell.h"
#import "Head.h"
@implementation personMoneyTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
   
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.ticketNumber=[[UILabel alloc]initWithFrame:CGRectMake(5, 0.005*h, w-10,0.06*h )];
    self.ticketNumber.adjustsFontSizeToFitWidth=YES;
    [self.contentView addSubview:self.ticketNumber];
    self.Money=[[UILabel alloc]initWithFrame:CGRectMake(5 ,0.07*h ,w-10,0.06*h)];
    self.Money.adjustsFontSizeToFitWidth=YES;
    self.Money.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:self.Money];
    self.ticketName=[[UILabel alloc]initWithFrame:CGRectMake(5, 0.135*h ,0.5*w-10,0.06*h )];
    self.ticketName.adjustsFontSizeToFitWidth=YES;
    
    [self addSubview:self.ticketName];
    self.ticketTime=[[UILabel alloc]initWithFrame:CGRectMake(0.5*w+5, 0.135*h ,0.5*w-10,0.06*h )];
    self.ticketTime.adjustsFontSizeToFitWidth=YES;
    self.ticketTime.textAlignment=NSTextAlignmentRight;
    UIImageView *line=[[UIImageView alloc]initWithFrame:CGRectMake(5, 0.2*h -1, w-10, 1)];
     [self.contentView addSubview:self.ticketTime];
    line.backgroundColor=lineRGB;
    [self.contentView addSubview:line];
   
    
    
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

@end
