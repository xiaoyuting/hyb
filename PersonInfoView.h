//
//  PersonInfoView.h
//  HYB
//
//  Created by CUIZE on 16/8/5.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "messViewController.h"
#import "PersonTableViewCell.h"
#import "accountViewController.h"
#import "SetViewController.h"
@interface PersonInfoView : UIViewController
@property UIImageView *personView;
@property  UILabel *personLabname;
@property  UILabel *personPhone;
@property  UIButton *leftButton;
@property UIButton *rightButton;
@property UITableView *personTab;
@property NSMutableArray *arrData;
@property NSMutableDictionary   *dicPerson;
-(void)back :(UIImage *)image;
@end
