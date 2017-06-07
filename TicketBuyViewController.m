//
//  TicketBuyViewController.m
//  HYB
//
//  Created by CUIZE on 16/8/5.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "TicketBuyViewController.h"
#import "MJRefresh.h"
//#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter2.h"
@interface TicketBuyViewController ()<UITableViewDelegate,CLLocationManagerDelegate,UITableViewDataSource,UIScrollViewDelegate>

@end

@implementation TicketBuyViewController
-(CLGeocoder *)geocoder {
    if (_geocoder==nil) {
        _geocoder=[[CLGeocoder alloc]init];
    }
    return _geocoder;
}

-(id)init{
    if(self){
        self=[super init];
    }
    
    self.localID=[[NSString alloc]init];
    return self;
}
- (void)viewDidLoad {
    self.localtext=[[NSString alloc]init];
    self.localtext=@"";
    [self getLocation];
    
    [self getNivHead];
       
  
    
    self.btn1=[[UIButton alloc]initWithFrame:CGRectMake(0, 64, 0.5*w, 40)];
    [self.btn1 setTitle:@"当日门票" forState:UIControlStateNormal];
    [self.btn1 setTitleColor:redRGB forState:UIControlStateNormal];
    self.btn1.layer.cornerRadius=0;
    self.btn1.layer.masksToBounds=YES;
    [ self.btn1.layer setBorderWidth:1];
    [ self.btn1.layer setBorderColor: garyRGB.CGColor];
    self.btn1.tag=0;
    
    [self.view addSubview:self.btn1];
    self.btn2=[[UIButton alloc]initWithFrame:CGRectMake(0.5*w, 64, 0.5*w, 40)];
    [self.btn2 setTitle:@"预约门票" forState:UIControlStateNormal];
     self.btn2.tag=1;
    self.btn2.layer.cornerRadius=0;
    self.btn2.layer.masksToBounds=YES;
    [ self.btn2.layer setBorderWidth:1];
    [ self.btn2.layer setBorderColor: garyRGB.CGColor];

    self.btn2.backgroundColor=[UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1];
    [self.btn1 addTarget:self action:@selector(indexDidChangeFor :) forControlEvents:UIControlEventTouchUpInside];
     [self.btn2 addTarget:self action:@selector(indexDidChangeFor :) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn2];
    self.arr1=[NSMutableArray array];
    self.arr2=[NSMutableArray array];
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"景区官方售票";
    self.navigationController.tabBarItem.title=@"官方售票";
    

    
    self.scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 104, w , h-154)];
    self.scrollview.contentSize=CGSizeMake(2*w , h-154);
    self.scrollview.delegate=self;
    self. scrollview.pagingEnabled = YES;
    self.scrollview.bounces=NO;
    [self showTab];
    [self getdata];
      [self getdata1];
    [self.view addSubview:self.scrollview];
         // Do any additional setup after loading the view.
}
-(void)getdata{
    [[SMProgressHUD shareInstancetype] showLoading];
       NSDictionary *dic =  @{@"id":@"-6560798112820566019",
                           @"method":@"product.query.queryHybTicketList",@"params":
                               @{@"provcName":@"NULL",
                                 @"dateType":@"1",
                                 @"ctName":self.letfButton.titleLabel.text,
                                 @"matchName":@""},
                           @"jsonrpc":@"2.0"};
   // NSLog(@"%@",self.letfButton.titleLabel.text);
    AFHTTPRequestOperationManager*manager=[AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //申明请求的数据是json类型
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    //设置请求头
    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
    
    
    //发送请求
    [manager POST:BuyTicket   parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.arr1 removeAllObjects];

    //  NSLog(@"dic===%@",responseObject);
        [self.arr1 addObjectsFromArray: [[responseObject objectForKey:@"result"] objectForKey:@"ticketList"]];
         [self.tab1 reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [[SMProgressHUD shareInstancetype] dismissLoadingView];
         
        });

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[SMProgressHUD shareInstancetype] dismissLoadingView];
        NSLog(@"Error: %@", error);
        
        [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"网络异常,请稍后重试"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
        
    }];


}
-(void)getdata1{
    [[SMProgressHUD shareInstancetype] showLoading];

    NSDictionary *dic =  @{@"id":@"-6560798112820566019",
                           @"method":@"product.query.queryHybTicketList",
                           @"params":
                               @{@"provcName":@"NULL",
                                 @"dateType":@"2",
                                 @"ctName":self.letfButton.titleLabel.text,
                                 @"matchName":@""},
                           @"jsonrpc":@"2.0"};
    AFHTTPRequestOperationManager*manager=[AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //申明请求的数据是json类型
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    //设置请求头
    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
    
    
    //发送请求
    [manager POST:BuyTicket   parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.arr2 removeAllObjects];
        
        // NSLog(@"dic===%@",responseObject);
        if([[NSString stringWithFormat:@"%@",[[responseObject  objectForKey:@"result"] objectForKey:@"result"]] isEqualToString:@"FAIL"]){
             [self.tab2 reloadData];
           // [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"当前地区没有进行景区门票售卖"   delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
            
        }else{
        [self.arr2 addObjectsFromArray: [[responseObject objectForKey:@"result"] objectForKey:@"ticketList"]];
            [self.tab2 reloadData];
        }
        //[[[UIAlertView alloc]initWithTitle:@"提示信息" message:  [NSString stringWithFormat:@"%@", [dic objectForKey:@"errorMessage"]] delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [[SMProgressHUD shareInstancetype] dismissLoadingView];
            
        });

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
                    [[SMProgressHUD shareInstancetype] dismissLoadingView];
            
       
        [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"网络异常,请稍后重试"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
        
    }];
    
    
}

-(void)showTab{
    self.tab1=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, w, h-154) style:UITableViewStylePlain ];
    self.tab1.delegate=self;
    self.tab1.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tab1.dataSource=self;
    self.tab2=[[UITableView alloc]initWithFrame:CGRectMake(w, 0, w, h-154) style:UITableViewStylePlain ];
    self.tab2.delegate=self;
      self.tab2.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tab2.dataSource=self;
    
    // 下拉刷新
        self. tab1.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
                           [self loadheadData];
                     
                                }];
    
  
        self. tab1.mj_header.automaticallyChangeAlpha = YES;
    
        // 上拉刷新
    self. tab1.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
           [self loadfootData];

      
     }];
    // 下拉刷新
    self. tab2.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadheadData1];
        
            }];
    
    
    self. tab2.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    self. tab2.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadfootData1];
        
                
    }];

            [self.scrollview addSubview:self.tab1];
    [self.scrollview addSubview:self.tab2];
    //[self.scrollview addSubview:self.tab3];
}
- (void)loadfootData
{
    // 1.添加假数据
    
    [self  getdata];
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        //[self.tableView reloadData];
        
        // 拿到当前的上拉刷新控件，结束刷新状态
        [self.tab1.mj_footer endRefreshing];
    });
}

- (void)loadheadData
{
    // 1.添加假数据
    
    [self getdata];
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tab1.mj_header endRefreshing];
    });
}
- (void)loadfootData1
{
    // 1.添加假数据
    
    [self  getdata1];
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tab2.mj_footer endRefreshing];
    });
}

- (void)loadheadData1
{
    // 1.添加假数据
    
    [self getdata1];
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        // [self.tableView reloadData];
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tab2.mj_header endRefreshing];
    });
}


-(void)indexDidChangeFor :(UIButton *)sender
{
    //我定义了一个 NSInteger tag，是为了记录我当前选择的是分段控件的左边还是右边。
    
    if(sender.tag==1){
        self.btn2.backgroundColor=[UIColor whiteColor];
        [self.btn2 setTitleColor:redRGB forState:UIControlStateNormal];
        self.btn1.backgroundColor= [UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1];
        [self.btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 animations:^{
             self.scrollview.contentOffset=CGPointMake(w, 0);
        }];
       
    }else if(sender.tag==0){
        self.btn1.backgroundColor=[UIColor whiteColor];
        [self.btn1 setTitleColor:redRGB forState:UIControlStateNormal];
        self.btn2.backgroundColor= [UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1];
        [self.btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        [UIView animateWithDuration:0.3 animations:^{
            self.scrollview.contentOffset=CGPointMake(0, 0);
        }];
}
 }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     return 0.2*w+10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([tableView isEqual:self.tab1]){
        return self.arr1.count
        ;
    }else if([tableView isEqual:self.tab2]){
        return self.arr2.count;
    }
//    }else if([tableView isEqual:self.tab3]){
//        return 6;
//    }
    return 0;
   }

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str=@"qqq";
    
        if([tableView isEqual:self.tab1]){
            TableViewCellTicket *cell=[tableView dequeueReusableCellWithIdentifier:str];
            if(cell==nil){
                cell=[[TableViewCellTicket alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
            }
            if(indexPath.row%2!=0){
                cell.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
            }

            cell.editing=NO;
            cell.selectionStyle=UITableViewCellSelectionStyleNone ;
            NSDictionary *dic=self.arr1[indexPath.row];
            cell.namelable.text=[dic objectForKey:@"productName"];
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",[dic objectForKey:@"salesPrice"]]];
            
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor  redColor] range:NSMakeRange(0,1)]; //设置字体颜色
            
            [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:14.0] range:NSMakeRange(0, 1)];

            cell.btnprice.labtitle.attributedText=str;
            cell.btnprice.labInfo.text=@"点击购买";
            cell.detaillable.text=[dic objectForKey:@"productAbstract"];
            NSURL * url2= [NSURL URLWithString:[NSString stringWithFormat:@"%@", [dic objectForKey:@"mainPic"]]];
          [cell.pic   sd_setImageWithURL:url2 placeholderImage:[UIImage imageNamed:@"user_head.png"]];
            cell.priceBlock=^{
                self.strID=[NSString  stringWithFormat:@"%ld",(long)indexPath.row];
                //NSLog(@"friendAttenClink==%ld",(long)indexPath.row);
            };
        
            [cell.btnprice  addTarget:self action:@selector(getTicket:) forControlEvents:UIControlEventTouchUpInside];
            cell.btnprice.tag=1;
            return cell;

        }else if([tableView isEqual:self.tab2]){
            TableViewCellTicket *cell=[tableView dequeueReusableCellWithIdentifier:str];
            if(cell==nil){
                cell=[[TableViewCellTicket alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
            }
            cell.editing=NO;
            cell.selectionStyle=UITableViewCellSelectionStyleNone ;
            NSDictionary *dic=self.arr2[indexPath.row];
            if(indexPath.row%2!=0){
                cell.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
            }
            cell.namelable.text=[dic objectForKey:@"productName"];
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",[dic objectForKey:@"salesPrice"]]];
            
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor  redColor] range:NSMakeRange(0,1)]; //设置字体颜色
            
            [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:14.0] range:NSMakeRange(0, 1)];
            
            cell.btnprice.labtitle.attributedText=str;
            cell.btnprice.labInfo.text=@"点击购买";
            cell.detaillable.text=[dic objectForKey:@"productAbstract" ];
            NSURL * url2= [NSURL URLWithString:[NSString stringWithFormat:@"%@", [dic objectForKey:@"mainPic"]]];
            [cell.pic   sd_setImageWithURL:url2 placeholderImage:[UIImage imageNamed:@"user_head.png"]];
            cell.priceBlock=^{
                self.strID=[NSString  stringWithFormat:@"%ld",(long)indexPath.row];
                //NSLog(@"friendAttenClink==%ld",(long)indexPath.row);
            };
            [cell.btnprice  addTarget:self action:@selector(getTicket:) forControlEvents:UIControlEventTouchUpInside];
            cell.btnprice.tag=2;
            return cell;

        }else if([tableView isEqual:self.tab3]){
            TableViewCellTicket *cell=[tableView dequeueReusableCellWithIdentifier:str];
            if(cell==nil){
                cell=[[TableViewCellTicket alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
            }
            cell.editing=NO;
            cell.selectionStyle=UITableViewCellSelectionStyleNone ;
            cell.priceBlock=^{
                //self.strID=[NSString  stringWithFormat:@"%ld",(long)indexPath.row];
                NSLog(@"friendAttenClink==%ld",(long)indexPath.row);
            };
            
            return cell;
        }
    return nil;

   }
-(void)getTicket :(UIButton *)sender{
    if(sender.tag==1){
    buyTicketView *vic=[[buyTicketView alloc]init];
    UINavigationController  *niv=[[UINavigationController  alloc]initWithRootViewController:vic];
    vic.dic=[[NSMutableDictionary  alloc]initWithDictionary:self.arr1[[self.strID  intValue]]];
    vic.strData=@"1";
    [niv.navigationBar setBarTintColor:redRGB];
    [self presentViewController:niv animated:YES completion:nil];
        NSLog(@"str==%@",self.strID);}
    else if(sender.tag==2){
        buyTicketView *vic=[[buyTicketView alloc]init];
        UINavigationController  *niv=[[UINavigationController  alloc]initWithRootViewController:vic];
        vic.dic=[[NSMutableDictionary  alloc]initWithDictionary:self.arr2[[self.strID  intValue]]];
        [niv.navigationBar setBarTintColor:redRGB];
        [self presentViewController:niv animated:YES completion:nil];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint p1=self.scrollview.contentOffset;
    int i=(int)p1.x/w;
    
    if(i>=1&&i<2){
        [UIView animateWithDuration:0.2 animations:^{
            self.btn2.backgroundColor=[UIColor whiteColor];
            [self.btn2 setTitleColor:redRGB forState:UIControlStateNormal];
            self.btn1.backgroundColor= [UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1];
            [self.btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        }];
        
            }
     else{
         [UIView  animateWithDuration:0.2 animations:^{
             self.btn1.backgroundColor=[UIColor whiteColor];
             [self.btn1 setTitleColor:redRGB forState:UIControlStateNormal];
             self.btn2.backgroundColor= [UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1];
             [self.btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
 
         }
          ];
             }
}

//定位
-(void)getLocation{
    [self geocoder];
    self.locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy =kCLLocationAccuracyBestForNavigation;
    _locationManager.distanceFilter = 10;
    [_locationManager requestAlwaysAuthorization];//添加这句
    [self getMaplocal ];
    
}
//导航栏显示
-(void)getNivHead{
//    NSString *path=NSHomeDirectory();
//    NSString * path2=[path stringByAppendingString:@"/Documents/"];
//    NSString * path1=[path2 stringByAppendingString:@"/local.json"];
//    NSArray *array=[[NSArray alloc]init];
//    array=[NSArray arrayWithContentsOfFile:path1];
//    if(array.count==0){
        self.localString=[NSString stringWithFormat:@"%@", @"池州市"];
//        
//    }else{
//        NSString * local=[NSString  stringWithFormat:@"%@", [array objectAtIndex:0
//                                                             ]];
//        self.localString=[NSString stringWithFormat:@"%@", local];
//            }
    
    self.letfButton = [SXButton buttonWithType:UIButtonTypeCustom];
    self.letfButton.frame = CGRectMake(-10, 0, 60, 20);
    [self.letfButton setTitle:self.localString  forState:UIControlStateNormal];
    [self.letfButton setImage:[UIImage imageNamed:@"zhankai"] forState:UIControlStateNormal];
    
    [self.letfButton addTarget:self action:@selector(location ) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *LeftBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.letfButton];
    self.navigationItem.leftBarButtonItem = LeftBarButton;
    self.title=@"主页";
    }
 //导航栏地理位置
-(void)location{
//    CityListViewController * vc = [[CityListViewController alloc]init];
//    vc.delegate=self;
//    vc.str=self.localtext;
//    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
//    [nav.navigationBar setBarTintColor:redRGB];
//    [nav.navigationBar  setTintColor:[UIColor whiteColor ]];
//    [self presentViewController:nav animated:YES completion:^{
//    }];
}
-(void)locValue:(NSString *)strloction{
    
    [self.letfButton setTitle: strloction  forState:UIControlStateNormal];
    self.localString=[NSString stringWithString:strloction];
    
    [self getdata];
    [self getdata1];
    
}
 
-(void)getMaplocal{
    
    // 判断的手机的定位功能是否开启
    // 开启定位:设置 > 隐私 > 位置 > 定位服务
    
    if ([CLLocationManager locationServicesEnabled]) {
        // 启动位置更新
        //NSLog(@"123");
        // 开启位置更新需要与服务器进行轮询所以会比较耗电，在不需要时用stopUpdatingLocation方法关闭;
        [self.locationManager startUpdatingLocation];
        
    }
    else {
       // NSLog(@"请开启定位功能！");
    }
}
- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    // 获取经纬度
    NSLog(@"纬度:%f",newLocation.coordinate.latitude);
    NSLog(@"经度:%f",newLocation.coordinate.longitude);
    
    //2.反地理编码
    [self.geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error||placemarks.count==0) {
            self.detailAddressLabel.text=@"你输入的地址没找到，可能在月球上";
        }else//编码成功
        {
            for (CLPlacemark *placemark in placemarks) {
               // NSLog(@"name=%@ locality=%@ country=%@ postalCode=%@111%@222%@333%@444%@",placemark.name,placemark.locality,placemark.country,placemark.postalCode,placemark.subLocality,placemark.thoroughfare,placemark. administrativeArea,placemark.subAdministrativeArea);
                self.strlocal= [NSString stringWithFormat:@"%@,%@",placemark.administrativeArea,placemark.locality];
                
                self.localtext=[NSString stringWithFormat:@"%@",placemark.locality];
                [self compear];
            }
        }
    }];
    // 停止位置更新
    [manager stopUpdatingLocation];
}
-(void)getLocal:(NSString *)str{
}
// 定位失误时触发
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    //NSLog(@"error:%@",error);
    [NSString stringWithFormat:@"%@",error];
}
- (void)geocode :(NSString *)str{
    //1.获得输入的地址
    NSString *address= str;
    if (address.length==0)
        return;
    
    //2.开始地理编码
    //说明：调用下面的方法开始编码，不管编码是成功还是失败都会调用block中的方法
    [self.geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        //如果有错误信息，或者是数组中获取的地名元素数量为0，那么说明没有找到
        if (error || placemarks.count==0) {
            self.detailAddressLabel.text=@"你输入的地址没找到，可能在月球上";
        }else   //  编码成功，找到了具体的位置信息
        {
            //打印查看找到的所有的位置信息
            /*
             61                     name:名称
             62                     locality:城市
             63                     country:国家
             64                     postalCode:邮政编码
             65                  */
            for (CLPlacemark *placemark in placemarks) {
                NSLog(@"name=%@ locality=%@ country=%@ postalCode=%@",placemark.name,placemark.locality,placemark.country,placemark.postalCode);
            }
            
            //取出获取的地理信息数组中的第一个显示在界面上
            CLPlacemark *firstPlacemark=[placemarks firstObject];
            //详细地址名称
            self.detailAddressLabel.text=firstPlacemark.name;
            //纬度
            CLLocationDegrees latitude=firstPlacemark.location.coordinate.latitude;
            //经度
            CLLocationDegrees longitude=firstPlacemark.location.coordinate.longitude;
            self.latitudeLabel.text=[NSString stringWithFormat:@"%.2f",latitude];
            self.longitudeLabel.text=[NSString stringWithFormat:@"%.2f",longitude];
        }
    }];
}
 -(void)viewDidDisappear:(BOOL)animated{
//    NSLog(@"likai");
//    NSMutableArray *Array=[[NSMutableArray  alloc]init];
//    [Array addObject:self.letfButton. titleLabel.text];
//    
//    NSString *path=NSHomeDirectory();
//    path= [path stringByAppendingString:@"/Documents/"];
//    NSString *fileName = [path stringByAppendingPathComponent:@"local.json"];
//    if([Array writeToFile:fileName atomically:YES])
//    {
//        NSLog(@"%@",Array);
//    }
    
}
-(void)compear{
    NSString *path=NSHomeDirectory();
    NSString * path2=[path stringByAppendingString:@"/Documents/"];
    NSString * path1=[path2 stringByAppendingString:@"/local.json"];
    NSArray *array=[[NSArray alloc]init];
    
    array=[NSArray arrayWithContentsOfFile:path1];
  //  NSLog(@"%@",array);
    NSString * local=[NSString stringWithFormat:@"%@",array.lastObject];
   // NSLog(@" %@",self.localtext);
    //   NSLog(@"%@",self.localID);
    
    NSString *pathlocal=NSHomeDirectory();
    NSString * pathlocal2=[pathlocal stringByAppendingString:@"/Documents/"];
    NSString * pathlocal1=[pathlocal2 stringByAppendingString:@"/localID.json"];
    NSArray *arraylocal=[[NSArray alloc]init];
    arraylocal=[NSArray arrayWithContentsOfFile:pathlocal1];
    if(![local isEqualToString:self.localtext]&&[@"1" isEqualToString:[NSString stringWithFormat:@"%@",  arraylocal.lastObject]]){
        NSString *path=NSHomeDirectory();
        NSArray *arr=[NSArray arrayWithObject:@"2"];
        path= [path stringByAppendingString:@"/Documents/"];
        NSString *fileName = [path stringByAppendingPathComponent:@"localID.json"];
        
        if([arr writeToFile:fileName atomically:YES])
        {
          //  NSLog(@"%@",arr);
          //  NSLog(@"写入成功");
        }
        else
        {
          //  NSLog(@"写入失败");
        }

        UIAlertView *ale=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"切换到当前城市" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        ale.tag=0;
        ale.delegate=self;
      //  [ale show];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag==0){
        if(buttonIndex==0){
          //  NSLog(@"quexiao");
        }else if(buttonIndex==1){
            [self.alert removeFromSuperview];
            
            [self.letfButton setTitle: self.localtext  forState:UIControlStateNormal];
            self.localString=[NSString stringWithString:self.localtext];
            [self getdata];
            [self getdata1];
            
            
        }}
}

 @end
