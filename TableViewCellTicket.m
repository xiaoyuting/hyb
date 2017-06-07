//
//  TableViewCellTicket.m
//  HYB
//
//  Created by CUIZE on 16/8/16.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "TableViewCellTicket.h"
#import "Head.h"
@implementation TableViewCellTicket

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"photocells";
     TableViewCellTicket*cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TableViewCellTicket alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.pic=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5,0.2*w/3*4.0,0.2*w)];
    
    [self.contentView addSubview:self.pic];
    
    
    self.namelable=[[UILabel alloc]initWithFrame:CGRectMake(0.2*w/3*4.0+10, 5, 0.5*w, 0.14*w)];
    self.namelable.adjustsFontSizeToFitWidth=YES;
    self.namelable.font = [UIFont fontWithName:@"Helvetica" size:15];
    self.namelable.lineBreakMode = UILineBreakModeWordWrap;
    self.namelable.numberOfLines = 0;
   [self.contentView addSubview:self.namelable];
    self.detaillable=[[UILabel alloc]initWithFrame:CGRectMake(0.2*w/3*4.0+10, 0.14*w, 0.3*w, 0.06*w)];
    self.detaillable.textColor=backRGB;
    [self.detaillable setNumberOfLines:0];
    [self.contentView addSubview:self.detaillable];
      self.detaillable.font=[UIFont systemFontOfSize:10];
    self.btnprice=[[ticketButton alloc]initWithFrame:CGRectMake(0.8*w-10, 5, 0.2*w , 0.2*w)];
    [self.contentView addSubview:self.btnprice];
     [self.btnprice addTarget:self action:@selector(price) forControlEvents:UIControlEventTouchUpInside];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)price{
    if(self.priceBlock){
        self.priceBlock();
    }
}
@end
