//
//  payResultViewcontroller.h
//  HYB
//
//  Created by CUIZE on 16/8/30.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaydetaileController.h"
#import "Head.h"
@interface payResultViewcontroller : UIViewController
@property UIImageView *imageview;
@property UILabel *labtitle;
@property UILabel *labdetail;
@property UIButton *btn;
@property  NSMutableDictionary *dic;
@property id delegate;
@end
