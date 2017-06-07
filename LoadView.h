//
//  YZLoad.h
//  Hexiao
//
//  Created by CUIZE on 16/5/4.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "Head.h"
#import "upfileViewController.h"
#import "LYTextField.h"

@interface LoadView : UIViewController

@property    UIImageView *image;//背景
 
@property   UIButton *Write;//注册
@property     UIButton *load;//登录
@property NSDictionary *Dic;
@property NSMutableArray*Array;
 
@property UIImageView   * vic1;
@property UIImageView   * vic2;
- (void)loadget;
@property LYTextField *name;
@property LYTextField *password;

@end
