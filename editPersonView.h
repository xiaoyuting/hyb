//
//  editPersonView.h
//  HYB
//
//  Created by CUIZE on 16/8/18.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonInfoView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "PersonTableViewCell.h"
@interface editPersonView : UIViewController
@property id imagedelege;
@property  NSMutableDictionary  *dicinfo;
@property UIImageView *backgroundImage;
@property UITableView *tabedit;
@property NSMutableArray *arrinfo;
@property NSString *picStr;
@property (nonatomic) UIImagePickerController*imagePickerController1;
@end
