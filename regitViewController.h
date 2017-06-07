//
//  regitViewController.h
//  HIYAOXYT
//
//  Created by CUIZE on 16/5/23.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Head.h"
#import "upfileViewController.h"
#import "mainViewController.h"
#import "LYTextField.h"
@interface regitViewController : UIViewController
 @property    UIImageView *image;//
 @property   UIButton *Write;//
@property   UIButton *load;//
@property NSDictionary *Dic;
@property NSMutableArray*Array;
@property UIButton *getpyz;
 
@property  UIActivityIndicatorView *actload;
 @property UIButton *agreement;
 
@property  LYTextField *PhoneNumber;
@property LYTextField *passWord;
@property LYTextField *repeatpassWord;
@property LYTextField *cheakNumber;//邀请码
@property LYTextField *changeNumber;//验证吗

@end
