//
//  PaydetaileController.h
//  HYB
//
//  Created by CUIZE on 16/8/29.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Head.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "payResultViewcontroller.h"
@interface PaydetaileController : UIViewController
@property UILabel *tickettime;
@property UILabel *timerStr;
@property UILabel *ticketName;
@property UILabel *countLab;
@property UILabel *pricelab;
@property UILabel *ticketCount;
@property UILabel *ticketPriceCount;
@property UILabel *payStyle;
@property UIImageView *image;
@property NSString *strImage;
@property NSMutableDictionary *dic;
@property NSTimer *timer;
@property NSTimer *timer1;
@property int count;
-(void)getpushView;
@end
