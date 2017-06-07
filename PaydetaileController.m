//
//  PaydetaileController.m
//  HYB
//
//  Created by CUIZE on 16/8/29.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "PaydetaileController.h"
#import "AFNetworking.h"

#import "mainViewController.h"

@implementation PaydetaileController
-(id)init{
    if(self){
        self=[super init];
        
    }
    self.dic=[[NSMutableDictionary   alloc]init];
    return self;
}
-(void)viewback{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
//    payResultViewcontroller*vic=[[payResultViewcontroller alloc]init];
//    UINavigationController *niv=[[UINavigationController alloc]initWithRootViewController:vic];
//    [niv.navigationBar setBarTintColor:redRGB];
//       vic.delegate=self;
//    vic.dic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:  @"order qewqewqewqewqewqewqewqewqewqwqewqewqewqewqewqewqewqewqewqqwwqeqwehfsdh ",@"number",@"2",@"str",nil];
//    [self presentViewController:niv animated:YES completion:nil];
    self.count=1;
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"zhankaileft"] style:UIBarButtonItemStyleDone target:self action:@selector(viewback)];
    self.navigationItem.leftBarButtonItem=left;
    self.ticketName=[[UILabel alloc]initWithFrame:CGRectMake(0, 64, w, 0.08*h )];
    self.ticketName.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];

    self.ticketName.text= [NSString  stringWithFormat:@"  %@",[self.dic objectForKey:@"name"]];
    self.ticketName.font=[UIFont systemFontOfSize:14];
    self.ticketName.adjustsFontSizeToFitWidth=YES;
    [self.view addSubview:self.ticketName];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"付款";
    self.ticketCount=[[UILabel alloc]initWithFrame:CGRectMake(w-80, 64+0.16*h , 80, 0.08*h)];
    
    self.ticketCount.text=[self.dic objectForKey:@"count"];
    self.ticketCount.font=[UIFont systemFontOfSize:13];
     self.ticketCount.textAlignment=NSTextAlignmentCenter;
    self.ticketCount.adjustsFontSizeToFitWidth=YES;
    [self.view addSubview:self.ticketCount];
    self.tickettime=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+0.08*h, 80, 0.08*h)];
    self.tickettime.text=@"  日期";
    [self.view addSubview:self.tickettime];
    self.timerStr=[[UILabel alloc]initWithFrame:CGRectMake(80, 64+0.08*h, w-80, 0.08*h)];
    self.timerStr.text=[NSString  stringWithFormat:@"  %@",[self.dic objectForKey:@"time"]];
    self.timerStr.textAlignment=NSTextAlignmentRight;
    [self.view addSubview:self.timerStr];
    self.countLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+0.16*h, 80, 0.08*h)];
    self.countLab.text=@"  数量";
    [self.view addSubview:self.countLab];
    UIImageView*vic1=[[UIImageView alloc]initWithFrame:CGRectMake(10, 64+0.16*h , w-20, 1)];
    vic1.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self.view addSubview:vic1];
    UIImageView*vic2=[[UIImageView alloc]initWithFrame:CGRectMake(10, 64+0.24*h , w-20, 1)];
    vic2.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self.view addSubview:vic2];
    self.ticketPriceCount=[[UILabel alloc]initWithFrame:CGRectMake(w-80, 64+0.24*h , 80, 0.08*h)];
    self.ticketPriceCount.text=[self.dic objectForKey:@"price"];
    self.ticketPriceCount.font =[UIFont systemFontOfSize:14];
   
     self.ticketPriceCount.textAlignment=NSTextAlignmentCenter;
    self.ticketPriceCount.adjustsFontSizeToFitWidth =YES;
    [self.view addSubview:self.ticketPriceCount];
    self.pricelab=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+0.24*h, 80, 0.08*h)];
    self.pricelab.text=@"  总计";
    [self.view addSubview:self.pricelab  ];
    [super viewDidLoad];
    self.payStyle=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+0.32*h, w , 0.08*h)];
    self.payStyle.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    self.payStyle.text=@"  支付方式";
    self.payStyle.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:self.payStyle];
    self.image=[[UIImageView alloc]initWithFrame:CGRectMake(0.2*w, 64+0.40*h+6, 0.6*w , 0.6*w)];
    NSURL *url=[NSURL URLWithString:[self.dic objectForKey:@"image"]];
    
    [self.image sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"user_head.png"]];
    [self.view addSubview:self.image];
    self.timer=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(getdata) userInfo:nil repeats:YES ];
    self.timer1=[ NSTimer scheduledTimerWithTimeInterval:1
                                                 target:self selector:@selector(getleave) userInfo:nil repeats:YES ];
    // Do any additional setup after loading the view.
}
 - (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getdata{
    NSLog(@"timer");
    NSDictionary *dic =  @{@"id":@"cz_3720275",
                           @"method":@"order.ticket.getOrderPayStatus",
                           @"params":@{
                                   @"orderNo": [NSString stringWithFormat:@"%@",[self.dic objectForKey:@"orderNo"]]},
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
    [manager POST:PayResult  parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic=[responseObject objectForKey:@"result"];
       // NSLog(@"dic===%@",responseObject);
        
        if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"payResult"]] isEqualToString:@"SUCCESS"]){
            payResultViewcontroller*vic=[[payResultViewcontroller alloc]init];
            UINavigationController *niv=[[UINavigationController alloc]initWithRootViewController:vic];
            [niv.navigationBar setBarTintColor:redRGB];
            vic.dic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[dic objectForKey:@"tradeInfo"] objectForKey:@"orderNo"],@"number",@"1",@"str",nil];
            [self presentViewController:niv animated:YES completion:nil];
        }else if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"payResult"]] isEqualToString:@"FAIL"]){
            payResultViewcontroller*vic=[[payResultViewcontroller alloc]init];
            vic.dic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[dic objectForKey:@"tradeInfo"] objectForKey:@"orderNo"],@"number",@"2",@"str",nil];
            vic.delegate=self;
            UINavigationController *niv=[[UINavigationController alloc]initWithRootViewController:vic];
            [niv.navigationBar setBarTintColor:redRGB];
            [self presentViewController:niv animated:YES completion:nil];

        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
       // [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"网络出错"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
    }];
}
-(void)getpushView{
   
   [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)getleave{
    if(self.count==900){
        [self.timer invalidate];
          self.timer =nil;
        [self.timer1 invalidate];
         self.timer1=nil;
         mainViewController *vic=[[mainViewController alloc]init];
        [self presentViewController:vic animated:YES completion:nil];

    }else{
        self.count++;
    }
}
 -(void)viewDidDisappear:(BOOL)animated{
    [self.timer  invalidate];
    self.timer =nil;
    [self.timer1 invalidate];
    self.timer1=nil;
}
@end