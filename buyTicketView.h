//
//  buyTicketView.h
//  HYB
//
//  Created by CUIZE on 16/8/22.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import <UIKit/UIKit.h>
 
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "SXButton.h"
#import "GuWeiDatePickerView.h"
#import "PaydetaileController.h"
#import "PaystyleButton.h"
@interface buyTicketView : UIViewController
@property NSMutableDictionary *dic;
@property UIImageView * image;
@property UILabel *ticketDetail;
@property UILabel  *ticketPrice;
@property UILabel *ticketName;
@property UILabel *ticketDate;
@property UILabel *ticketNumber;
@property UILabel *count;
@property UIButton *btnadd;
@property UIButton *btnreduce;
@property SXButton *dateBtn;
@property      NSString *  locationString;
@property int priceCount;
@property int ticketPriceCount;
@property UILabel *amount;
@property  UIButton*btnPush;
@property  UILabel * personlab;
@property UILabel *phonelab;
@property UITextField *persontext;
@property UITextField *phonetext;
@property UILabel *agreeLab;
@property UIView *viewcheak;
@property UITextField *cheakNumber;
@property UILabel *agreelabdetail;
@property UIButton *viewbtncheak;
@property UIButton *btnJump;
@property UIButton  *btnBack;
@property UIView *backView;
@property UIScrollView *scr;
@property UIButton *btnViewadd;
//@property UITableView *tab;
@property PaystyleButton  *WX;
@property PaystyleButton *ALPAY;
@property UIButton *reducePrice;
@property UIButton *addPrice;
@property NSString *strPaystyle;
@property NSString *strData;
@property NSString * maxPrice;
@property NSString *miniPrice;
@property NSString *rulesPrice;
@property NSString *nowPrice;
@property UIButton *btnPushticket;
@end
