//
//  personMoneyViewController.m
//  HYBao
//
//  Created by CUIZE on 16/9/4.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "personMoneyViewController.h"
#import "personMoneyTableViewCell.h"
#import "Head.h"
#import "AFNetworking.h"
#import "MJRefresh.h"
@interface personMoneyViewController ()<UITableViewDataSource>

@end

@implementation personMoneyViewController
-(id)init{
    self=[super init];
    self.data=[NSMutableArray array];
    return self;
}
-(void)viewback{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"zhankaileft"] style:UIBarButtonItemStyleDone target:self action:@selector(viewback)];
    self.navigationItem.leftBarButtonItem=left;

    self.title=@"收入记录";
    self.view.backgroundColor=[UIColor whiteColor];
    self.tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, w , h) style:UITableViewStylePlain];
    self.tab.dataSource=self;
    self.tab.rowHeight=0.2*h;
    self.tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self getdata];
    [self.view addSubview:self.tab];
    [super viewDidLoad];
    // 下拉刷新
    self. tab.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadheadData];
        
    }];
    
    
    self. tab.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    self. tab.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadfootData];
        
        
    }];

    // Do any additional setup after loading the view.
}

- (void)loadfootData
{
    
    
    [self  getdatafoot];
    
    
        [self.tab.mj_footer endRefreshing];
   
}

- (void)loadheadData
{
    
    
    [self getdata];
    
        [self.tab.mj_header endRefreshing];
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.data.count;
    
    
}
-(void)getdata{
    self.count=1;
    AFHTTPRequestOperationManager*manager=[AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //申明请求的数据是json类型
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    //设置请求头
    NSString *path=NSHomeDirectory();
    NSString * path2=[path stringByAppendingString:@"/Documents/"];
    NSString * path1=[path2 stringByAppendingString:@"/token.json"];
    NSArray *array=[[NSArray alloc]init];
    array=[NSArray arrayWithContentsOfFile:path1];
    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
    NSLog(@"%@",[array.lastObject objectForKey:@"token"]);
    NSDictionary *parameters = @{
                                 @"AccountEntity":@{
                                         @"token":[NSString stringWithFormat:@"%@", [array.lastObject objectForKey:@"token"]],
                                         @"pageNumber":[NSString stringWithFormat:@"%d", self.count],
                                         @"pageSize":@"5"
                                         }};//发送请求
    
    [manager POST:Moneymessage  parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic=[responseObject objectForKey:@"Result"];
        NSLog(@"%@",responseObject);
        
        self.count++;
        self.data=[NSMutableArray arrayWithArray:[dic objectForKey:@"hiyoAccountOperations"]];
        
        [self.tab reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"网络出错"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
        
    }];
    }

-(void)getdatafoot{
    
    AFHTTPRequestOperationManager*manager=[AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //申明请求的数据是json类型
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    //设置请求头
    NSString *path=NSHomeDirectory();
    NSString * path2=[path stringByAppendingString:@"/Documents/"];
    NSString * path1=[path2 stringByAppendingString:@"/token.json"];
    NSArray *array=[[NSArray alloc]init];
    array=[NSArray arrayWithContentsOfFile:path1];
    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
    NSLog(@"%@",[array.lastObject objectForKey:@"token"]);
    NSDictionary *parameters = @{
                                 @"AccountEntity":@{
                                         @"token":[NSString stringWithFormat:@"%@", [array.lastObject objectForKey:@"token"]],
                                         @"pageNumber":[NSString stringWithFormat:@"%d", self.count],
                                         @"pageSize":@"5"
                                         }};//发送请求
    
    [manager POST:Moneymessage   parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic=[responseObject objectForKey:@"Result"];
        NSLog(@"%@",responseObject);
        
        self.count++;
        [self.data addObjectsFromArray:[dic objectForKey:@"hiyoAccountOperations"]];
        
        [self.tab reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"网络异常,请稍后重试"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
        
    }];
    
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     static NSString *str=@"qqq";
    personMoneyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil){
        cell=[[personMoneyTableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"str"];
    }
    NSDictionary  *dic=self.data[indexPath.row];
    cell.ticketNumber.text=[NSString stringWithFormat:@"单号:%@",[dic objectForKey:@"tradeNo"]];
    cell.Money.text=[NSString stringWithFormat:@"金额：%@元",[dic objectForKey:@"totalMoney"]];
    cell.ticketName.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"context"]];
    cell.ticketTime.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"createTime"]];

    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
