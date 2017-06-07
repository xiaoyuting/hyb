//
//  TableViewCellTicket.h
//  HYB
//
//  Created by CUIZE on 16/8/16.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ticketButton.h"

@interface TableViewCellTicket : UITableViewCell
@property UIImageView *pic;
@property UILabel *namelable;
@property UILabel *detaillable;
@property (strong,nonatomic)ticketButton *btnprice;
@property  void(^priceBlock)();
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
