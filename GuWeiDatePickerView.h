//
//  GuWeiDatePickerView.h
//  GuWeiDatePicker
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PickerBlock)(NSString *);

@interface GuWeiDatePickerView : UIView

@property(nonatomic,copy)PickerBlock pickerBlock;

@end
