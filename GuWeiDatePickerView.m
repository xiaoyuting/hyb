//
//  GuWeiDatePickerView.m
//  GuWeiDatePicker
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GuWeiDatePickerView.h"

@interface GuWeiDatePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>{
    
    CGFloat _W;
    CGFloat _H;
    
    UIPickerView *_pickerViiew;
    NSString *_dateStr;
    
    NSInteger _dayRange;
    
    NSMutableArray *_MArray;
    
    NSInteger _year;
    NSInteger _month;
    NSInteger _day;
    
    
}

@end

@implementation GuWeiDatePickerView


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _MArray = [NSMutableArray new];
        [self addPickerView];
        [self initData];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)addPickerView{
    
    _W = self.frame.size.width;
    _H = self.frame.size.height;
    
    //蓝色条
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _W, 25)];
    view.backgroundColor = [UIColor colorWithRed:5/255.f green:160/255.f blue:249/255.f alpha:1];
    view.userInteractionEnabled = YES;
    [self addSubview:view];
    
    _pickerViiew = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, _W, _H)];
    _pickerViiew.delegate = self;
    _pickerViiew.dataSource = self;
    [self addSubview:_pickerViiew];
    
    //左按钮
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, _H-30, 50, 25)];
    leftButton.tag = 101;
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftButton];
    //右按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(_W - 50, _H-30, 50, 25)];
    rightButton.tag = 102;
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightButton];
    //中间的label
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 25)];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"选择时间";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.center = view.center;
    [view addSubview:label];
    
    
    
}

-(void)buttonClick:(UIButton *)btn{
    
    if (btn.tag==101) {
        //
        
    }else{
        //
        self.pickerBlock(_dateStr);
    }
    
    [self removeFromSuperview];
    
    
}



-(void)initData{
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    
    //明天时间
    NSDate *tomorrow = [[NSDate alloc] initWithTimeIntervalSinceNow:secondsPerDay];
    //self.strPaystyle=[[NSString alloc]init];
    NSDateFormatter  *date =[[NSDateFormatter alloc] init];
    
    [date setDateFormat:@"YYYY-MM-dd"];
    

    //
  //  NSDate *date = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:tomorrow];
    
    NSArray *array = [dateStr componentsSeparatedByString:@"-"];
    
    _year = [array[0] integerValue];
    _month = [array[1] integerValue];
    _day = [array[2] integerValue];
    
    _dayRange = [self isAllDay:_year andMonth:_month];
    
    NSArray * weekArray = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    
    
    for (int i=0; i<_dayRange; i++) {
        
        //取出当月的天数
        NSInteger day = [self isAllDay:_year andMonth:_month] - [self isAllDay:_year andMonth:_month+1];
        if (_day > day) {
            _day = 1;
            _month++;
        }
        if (_month>12) {
            _year++;
        }
        _month = _month%13;
        if (_month==0) {
            _month=1;
            
        }
        NSString * string;
        if (i == 0) {
            string = [NSString stringWithFormat:@"%02ld-%02ld-%02ld %@",_year,_month,_day++,@"明日"];
            _dateStr = string;
        }else{
            NSInteger weekday = [self getNowWeekdayWithDate:_day andMonth:_month andYear:_year];
            string = [NSString stringWithFormat:@"%02ld-%02ld-%02ld %@",_year,_month,_day++,weekArray[weekday-1]];
            
        }
        [_MArray addObject:string];
    }
    
}

//传入日期字符串，返回星期几
-(NSInteger )getNowWeekdayWithDate:(NSInteger)day andMonth:(NSInteger)month andYear:(NSInteger)year{
    
    
    NSDateComponents *_comps = [[NSDateComponents alloc] init];
    [_comps setDay:day];
    [_comps setMonth:month];
    [_comps setYear:year];
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDate *_date = [gregorian dateFromComponents:_comps];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSWeekdayCalendarUnit fromDate:_date];
    
    NSInteger _weekday = [weekdayComponents weekday];
    
    
    return _weekday;
}

#pragma mark - UIPickerVIew的代理方法
//行高
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}

//
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel * label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:15.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.tag = 100 + row;
    
    label.frame = CGRectMake(20, 0, _W, 30);
    label.text =  _MArray[row];
    
    return label;
}
//
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
//
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _dayRange;
}

#pragma mark - 用户滑动的时候选中哪一个
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    _dateStr = _MArray[row];
    //self.pickerBlock(_MArray[row]);
    
    //NSLog(@"%@",_MArray[row]);
    
}

#pragma mark - 返回天数
-(NSInteger)isAllDay:(NSInteger)year andMonth:(NSInteger)month{
    int day=0;
    switch(month){
        case 1:
            day += 31;
        case 2:{
            if(((year%4==0)&&(year%100!=0))||(year%400==0)){
                day+=29;
            }
            else{
                day+=28;
            }
        }
        case 3:
            day += 31;
        case 4:
            day += 30;
        case 5:
            day += 31;
        case 6:
            day += 30;
        case 7:
            day += 31;
        case 8:
            day += 31;
        case 9:
            day += 30;
        case 10:
            day += 31;
        case 11:
            day += 30;
        case 12:
            day += 31;
            break;
        default:
            break;
    }
    return day;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
