//
//  CardViewController.h
//  HYBao
//
//  Created by CUIZE on 16/9/7.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYTextField.h"
#import "CardButton.h"
@interface CardViewController : UIViewController
@property NSMutableDictionary *data;
@property  CardButton *WXbtn;
@property  CardButton *ALIPYbtn;
@property UIView *viewDetail;
//@property UILabel *labName;
//@property UILabel *labNumber;
@property LYTextField *name;
@property LYTextField *number;
//@property UITextField *textName;
//@property UITextField *textNumber;
 
@end
