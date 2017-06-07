//
//  accountViewController.m
//  HYBao
//
//  Created by CUIZE on 16/9/2.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "accountViewController.h"
#import "personMoneyViewController.h"
#import "CardViewController.h"
#import "PushMoneyViewController.h"
@interface accountViewController ()

@end

@implementation accountViewController
-(void)viewback{
    [self.navigationController popViewControllerAnimated:YES];}


- (void)viewDidLoad {
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"zhankaileft"] style:UIBarButtonItemStyleDone target:self action:@selector(viewback)];
        self.navigationItem.leftBarButtonItem=left;
    self.title=@"我的账户";
    [super viewDidLoad];
    self.view .backgroundColor=garyRGB;
    self.viewhead=[[UIView alloc]initWithFrame:CGRectMake(0, 64, w , 570/880.0*w-10)];
    self.viewhead.backgroundColor=[UIColor whiteColor];
    self.photo=[[UIImageView alloc]initWithFrame:CGRectMake(self.viewhead.frame.size.width*0.4, self.viewhead.frame.size.height*0.2, self.viewhead.frame.size.width*0.2, self.viewhead.frame.size.width*0.2)];
   
    self.photo.image=[UIImage imageNamed:@"mine_account_icon"];
   [ self.viewhead addSubview:self.photo];
    self.lab1=[[UILabel alloc]initWithFrame:CGRectMake(0, self.viewhead.frame.size.width*0.2+self.viewhead.frame.size.height*0.25, w, self.viewhead.frame.size.height*0.1)];
    self.lab1.textAlignment=NSTextAlignmentCenter;
    self.lab1.font=[UIFont systemFontOfSize:12];
    self.lab1.textColor=backRGB;
    self.lab1.text=@"可用账户";
    [self.viewhead addSubview:self.lab1];
    self.lab2=[[UILabel alloc]initWithFrame:CGRectMake(0, self.viewhead.frame.size.width*0.2+self.viewhead.frame.size.height*0.35, w, (self.viewhead.frame.size.height*0.6-self.viewhead.frame.size.width*0.2)*0.8)];
    self.lab2.textAlignment=NSTextAlignmentCenter;
   self.lab2.font=[UIFont systemFontOfSize:30];
    self.lab2.textColor=backRGB;
    self.lab2.text=@"计算中";
    [self.viewhead addSubview:self.lab2];
    [self.view addSubview:self.viewhead];
    
    [self account];
    self.btn1=[[aboutButton alloc]initWithFrame:CGRectMake(0, 64+570/880.0*w, w,  (h-(114+570/880.0*w))/4.5)];
    self.btn1.tag=1;
    [self.btn1 addTarget:self action:@selector(getMoney:) forControlEvents:UIControlEventTouchUpInside];
    self.btn1.lab.text=@"卖家收入";
    [self.view addSubview:self.btn1];
    self.btn2=[[aboutButton alloc]initWithFrame:CGRectMake(0, 64+570/880.0*w+ (h-(114+570/880.0*w))/4.5, w,   (h-(114+570/880.0*w))/4.5)];
    self.btn2.tag=2;
    [self.btn2 addTarget:self action:@selector(getMoney:) forControlEvents:UIControlEventTouchUpInside];
    self.btn2.lab.text=@"推荐收入";
    [self.view addSubview:self.btn2];
    self.btn3=[[aboutButton alloc]initWithFrame:CGRectMake(0, 64+570/880.0*w+2.0*((h-(114+570/880.0*w))/4.5), w,  (h-(114+570/880.0*w))/4.5)];
    self.btn3.lab.text=@"提现记录";
    self.btn3.tag=3;
    [self.btn3 addTarget:self action:@selector(getMoney:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn3];
    self.btn4=[[aboutButton alloc]initWithFrame:CGRectMake(0, 64+570/880.0*w+3.0*((h-(114+570/880.0*w))/4.5), w,  (h-(114+570/880.0*w))/4.5)];
    self.btn4.lab.text=@"我的银行卡";
    self.btn4.tag=4;
    [self.btn4 addTarget:self action:@selector(getMoney:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn4];

    }
-(void)getMoney :(UIButton *)sender{
    if(sender.tag==1){
        personMoneyViewController *vic=[[personMoneyViewController alloc]init];
       
        UINavigationController *niv=[[UINavigationController alloc]initWithRootViewController:vic];
        [niv.navigationBar setBarTintColor:redRGB];
        [self presentViewController:niv  animated:YES completion:nil];
               
    }else if(sender.tag==2){
         [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"功能正在建设中"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
    }else if(sender.tag==3){
   
           PushMoneyViewController *vic=[[  PushMoneyViewController alloc]init];
        
        UINavigationController *niv=[[UINavigationController alloc]initWithRootViewController:vic];
        [niv.navigationBar setBarTintColor:redRGB];
        [self presentViewController:niv  animated:YES completion:nil];

    }else if(sender.tag==4){
        NSLog(@"银行卡");
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
        
        NSDictionary *parameters = @{
                                     @"AccountEntity":@{
                                             @"token":[NSString stringWithFormat:@"%@", [array.lastObject objectForKey:@"token"]],
                                             }};//发送请求
        
        [manager POST:BankCard   parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dic=[responseObject objectForKey:@"Result"];
        
                    CardViewController  *vic=[[CardViewController alloc]init];
             vic.data=[[NSMutableDictionary alloc]initWithDictionary:
                       [dic objectForKey:@"accountBank"]];
            UINavigationController *niv=[[UINavigationController alloc]initWithRootViewController:vic];
             [niv.navigationBar setBarTintColor:redRGB];
            [self presentViewController:niv  animated:YES completion:nil];
            
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"Error: %@", error);
            
            [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"网络出错"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
            
        }];
        

        
    }


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)account{
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
                                         }};//发送请求
    [manager POST:MoneyPerson  parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic=[responseObject objectForKey:@"Result"];
 
     self.lab2.text=[NSString stringWithFormat:@"¥%@", [[dic objectForKey:@"account"] objectForKey:@"remainingMoney"]];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"网络异常,请稍后重试"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
        
    }];

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
