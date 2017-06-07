//
//  upfileViewController.h
//  HYB
//
//  Created by CUIZE on 16/8/15.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXButton.h"
#import "regitDetailViewController.h"
#import "WBPopMenuModel.h"
#import "WBPopMenuSingleton.h"

@interface upfileViewController : UIViewController
@property SXButton *leftButton;
@property SXButton *centerButton;
@property SXButton  *rightButton;
@property UILabel  *localLable;
@property UILabel  *nameLable;
@property UITextField *nameText;
@property UILabel *typeLable;
@property SXButton *typeButton;
//@property UIScrollView *shopView;
@property UIButton *pushButton;

@property UIImageView *photo1;
@property UIImageView *photo2;
@property UIImageView *photo3;
@property UIImageView *photo4;

//@property UIButton *btn1;
//@property UIButton *btn2;
//@property UIButton *btn3;
//@property UIButton *btn4;

@property UILabel *lab1;
@property UILabel *lab2;
@property UILabel *lab3;
@property UILabel *lab4;


@property UIButton *btnpic1;
@property UIButton *btnpic2;
@property UIButton *btnpic3;
@property UIButton *btnpic4;

@property (nonatomic) UIImagePickerController*imagePickerController4;
@property (nonatomic) UIImagePickerController*imagePickerController1;
@property (nonatomic) UIImagePickerController*imagePickerController2;
@property (nonatomic) UIImagePickerController*imagePickerController3;

@property   NSString *strUrl1;
@property   NSString *strUrl2;
@property   NSString *strUrl3;
@property   NSString *strUrl4;
@property  UILabel *personlab;
@property  UITextField *personId;
@property UIScrollView *scr;
@property UITextField *bankName;
@property UITextField *bankNumber;
@property UITextField *alPayNumber;
@end
