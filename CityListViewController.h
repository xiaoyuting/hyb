//
//  CityListViewController.h
//  CityList
//
//  Created by Chen Yaoqiang on 14-3-6.
//
//

#import <UIKit/UIKit.h>
#import "TicketBuyViewController.h"

 
@interface CityListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableDictionary *cities;

@property (nonatomic, strong) NSMutableArray *keys; //城市首字母
@property (nonatomic, strong) NSMutableArray *arrayCitys;   //城市数据
@property (nonatomic, strong) NSMutableArray *arrayHotCity;
@property (nonatomic,strong)  UILabel *labPoint;
@property (nonatomic,strong)  UILabel *labDetail;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSString *str;
@property id delegate;
@end
