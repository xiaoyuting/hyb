//
//  messViewController.m
//  HYB
//
//  Created by CUIZE on 16/8/22.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "messViewController.h"
#import "Head.h"
#import "AFNetworking.h"
#import "modelCell.h"
#import "MJRefresh.h"
@interface messViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation messViewController
-(void)viewback{
     [self.navigationController popViewControllerAnimated:YES];}

- (void)viewDidLoad {
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"zhankaileft"] style:UIBarButtonItemStyleDone target:self action:@selector(viewback)];
    self.navigationItem.leftBarButtonItem=left;

    self.view.backgroundColor=[UIColor whiteColor];
    self.dataArray=[NSMutableArray array];
    [super viewDidLoad];
    self.title=@"消息盒子";
    self.tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, w , h) style:UITableViewStylePlain];
    self.tab.delegate=self;
    self.tab.dataSource=self;
    self.tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 下拉刷新
    self. tab.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadheadData];
        
    }];
    
    
    self. tab.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    self. tab.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadfootData];
        
        
    }];
    

    [self.view addSubview:self.tab];
    [self pulldata];
    // Do any additional setup after loading the view.
}
- (void)loadfootData
{
    
    
    [self  pulldatafoot];
    
    
    [self.tab.mj_footer endRefreshing];
    
}

- (void)loadheadData
{
    
    
    [self pulldata];
    
    [self.tab.mj_header endRefreshing];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    modelCell *cell=[[ modelCell  alloc]init];;
    
    
    return[cell add:self.dataArray[indexPath.row]];
}
- ( UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str=@"aaa";
    modelCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil){
        cell=[[modelCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    [cell add:self.dataArray[indexPath.row]];
  //  NSDictionary *dic=self.dataArray[indexPath.row];
    
    
   // cell.name.text=[NSString stringWithFormat:@"%@", [dic objectForKey:@"nickName"] ] ;
    //cell.time.text=[ NSString   stringWithFormat:@"%@",[dic objectForKey:@"createdatetime"]];
    //cell.icon.image=[UIImage imageNamed:@"user_head.png"];
    //NSURL *url1=[NSURL URLWithString:[dic objectForKey:@"userPhotoUrl"]];
   // [cell.icon   sd_setImageWithURL:url1  placeholderImage:[UIImage imageNamed:@"user_head.png"]];
   // cell.text.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"msgContent"]];
    return  cell;
}

-(void)pulldata{
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
    //NSLog(@"%@",[array.lastObject objectForKey:@"token"]);
    NSDictionary *parameters = @{
                                 @"MessageQueryCondition":@{
                                         @"token":[NSString stringWithFormat:@"%@", [array.lastObject objectForKey:@"token"]],
                                         @"pageNumber":[NSString stringWithFormat:@"%d",self.count ],
                                         @"pageSize":@"5"
                                         }};//发送请求
    [manager POST:Notification  parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.dataArray removeAllObjects];
   
        NSDictionary *dic=[responseObject objectForKey:@"Result"];
       // NSLog(@"dic=====%@",dic);
        self.count++;
        [self.dataArray addObjectsFromArray:[dic objectForKey:@"messages"]];
        [self.tab reloadData];
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"网络异常,请稍后重试"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
        
    }];
}
-(void)pulldatafoot{
    
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
                                 @"MessageQueryCondition":@{
                                         @"token":[NSString stringWithFormat:@"%@", [array.lastObject objectForKey:@"token"]],
                                         @"pageNumber":[NSString stringWithFormat:@"%d",self.count ],
                                         @"pageSize":@"5"
                                         }};//发送请求
    
    [manager POST: Notification   parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.count++;
        NSDictionary *dic=[responseObject objectForKey:@"Result"];
      //  NSLog(@"dic===%@",dic);
        // NSLog(@"qweqew%@",[dic objectForKey:@"messages"]);
        [self.dataArray addObjectsFromArray:[dic objectForKey:@"messages"]];
       
        [self.tab reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"网络出错"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
        
    }];

}



@end
