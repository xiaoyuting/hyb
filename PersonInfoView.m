//
//  PersonInfoView.m
//  HYB
//
//  Created by CUIZE on 16/8/5.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "PersonInfoView.h"
#import "AFNetworking.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "editPersonView.h"
#import "checkViewController.h"
#import "WebViewController.h"
#import "aboutViewController.h"
#import "SMProgressHUD.h"
//#import "HYB-Swift.h"

@interface PersonInfoView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation PersonInfoView

- (void)viewDidLoad {
    [self getpersonInfo];
    [super viewDidLoad];
    [self viewShow];
     self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"我的";
         self.arrData=[NSMutableArray arrayWithObjects:[[NSDictionary alloc]initWithObjectsAndKeys:@"公告",@"name",@"1.png",@"pic", nil],[[NSDictionary alloc]initWithObjectsAndKeys:@"消息",@"name",@"2.png",@"pic", nil],[[NSDictionary alloc]initWithObjectsAndKeys:@"我的帐户",@"name",@"3.png",@"pic", nil],[[NSDictionary alloc]initWithObjectsAndKeys:@"关于我们",@"name",@"4.png",@"pic", nil],[[NSDictionary alloc]initWithObjectsAndKeys:@"设置",@"name",@"5.png",@"pic", nil], [[NSDictionary alloc]initWithObjectsAndKeys:@"身份认证进度",@"name",@"6.png",@"pic", nil], nil];
    // Do any additional setup after loading the view.
}
-(void)viewShow{
    self.personView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 69, 0.2*w , 0.2*w )];
    self.personView.layer.cornerRadius=6;
    self.personView.layer.masksToBounds=YES;
    [self.view addSubview:self.personView];
    self.personPhone=[[UILabel alloc]initWithFrame:CGRectMake(0.3*w, 69+0.1*w, 0.4*w , 0.1*w)];
    self.personPhone.textColor=backRGB;
    [self.view addSubview:self.personPhone];
    self.personLabname=[[UILabel alloc]initWithFrame:CGRectMake(0.3*w, 69, 0.2*w, 0.1*w)];
    self.personLabname.textColor=backRGB;
    [self.view addSubview:self.personLabname];
    UIImageView *vic1=[[UIImageView alloc]initWithFrame:CGRectMake(10, 0.2*w+74+0.025*h-1, w-20 , 1)];
    vic1.backgroundColor=garyRGB;
    [self.view addSubview:vic1];
    self.leftButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0.2*w+74+0.025*h, w , 0.055*h)];
    [self.leftButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.leftButton setTitle:@"编辑资料" forState:UIControlStateNormal];
    [self.leftButton setTitleColor:redRGB forState:UIControlStateHighlighted];
    [self.leftButton setTitle:@"编辑资料" forState:UIControlStateHighlighted];
//    self.leftButton.layer.cornerRadius=0;
//    self.leftButton.layer.borderWidth=1;
//    [self.leftButton.layer setBorderColor:garyRGB.CGColor];
    [self.leftButton addTarget:self action:@selector(editView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftButton];
    UIImageView *vic2=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0.2*w+74+0.025*h+0.055*h, w, 0.02*h )];
    vic2.backgroundColor=garyRGB;
    [self.view addSubview:vic2];
    self.rightButton=[[UIButton alloc]initWithFrame:CGRectMake(0.5*w+1, 0.2*w+74, 0.5*w-1 , 0.1*h)];
    [self.rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

   // [self.rightButton setTitle:@"权限设置" forState:UIControlStateNormal];

   // [self.view addSubview:self.rightButton];
    
    self.personTab=[[UITableView alloc]initWithFrame:CGRectMake(0, 79+0.2*w+0.1*h, w, h-79+0.2*w+0.1*h) style:UITableViewStylePlain];
    self.personTab.delegate=self;
    self.personTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.personTab.dataSource=self;
    [self.view addSubview:self.personTab];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrData.count;
}

-(void)editView :(UIButton *)sender{
    editPersonView *vic=[[editPersonView alloc]init];
    vic.dicinfo=self.dicPerson;
    vic.backgroundImage.image=self.personView.image;
        vic.imagedelege=self;
    [self.navigationController pushViewController:vic animated:YES];
  //  [self presentViewController:niv animated:YES completion:^{
        
   // }];
}
-(void)back :(UIImage *)image{
    self.personView.image=image;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str=@"qqq";
   PersonTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil){
        cell=[[PersonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
    }
  //  cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
  //  cell.tintColor = [UIColor redColor];
 NSDictionary *dic=self.arrData[indexPath.row];
    cell.lab1.text=[dic objectForKey:@"name"];
    cell.image1.image=[UIImage imageNamed:[dic objectForKey:@"pic"]];
    cell.image3.image=[UIImage imageNamed: @"7.png"];
    
    return  cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==5){
        [[SMProgressHUD shareInstancetype] showLoading];
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
  //  NSLog(@"%@",[array.lastObject objectForKey:@"token"]);
    NSDictionary *parameters = @{
                                 @"BusinessUserEntity":@{
                                         @"token":[NSString stringWithFormat:@"%@", [array.lastObject objectForKey:@"token"]],
                                          }};//发送请求
    [manager POST:cheakPersonInfo parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
      //   NSLog(@"%@",responseObject);
        NSDictionary *dic=[responseObject objectForKey:@"Result"];
        NSLog(@"%@",dic);
        if([[ NSString stringWithFormat:@"%@", [[dic objectForKey:@"businessUser"] objectForKey:@"state"]] isEqualToString:@"1"]){
            checkViewController *vic=[[checkViewController alloc]init];
            vic.strID=@"2";
            UINavigationController *niv=[[UINavigationController alloc]initWithRootViewController:vic];
            [niv.navigationBar setBarTintColor:redRGB];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [[SMProgressHUD shareInstancetype] dismissLoadingView];
                
                 [self presentViewController:niv animated:YES completion:nil];
            });

           

           // [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"正在审核中" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
        }else  if([[ NSString stringWithFormat:@"%@", [[dic objectForKey:@"businessUser"] objectForKey:@"state"]] isEqualToString:@"2"]){
            checkViewController *vic=[[checkViewController alloc]init];
            vic.strID=@"3";
            UINavigationController *niv=[[UINavigationController alloc]initWithRootViewController:vic];
            [niv.navigationBar setBarTintColor:redRGB];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [[SMProgressHUD shareInstancetype] dismissLoadingView];
                [self presentViewController:niv animated:YES completion:nil];

                
            });

            
         
        }else  if([[ NSString stringWithFormat:@"%@", [[dic objectForKey:@"businessUser"] objectForKey:@"state"]] isEqualToString:@"3"]){
            checkViewController *vic=[[checkViewController alloc]init];
            vic.strID=@"4";
            vic.failStr=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"businessUser"] objectForKey:@"content"]];
            
                        UINavigationController *niv=[[UINavigationController alloc]initWithRootViewController:vic];
            [niv.navigationBar setBarTintColor:redRGB];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [[SMProgressHUD shareInstancetype] dismissLoadingView];
                
                 [self presentViewController:niv animated:YES completion:nil];
            });

           

            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
      
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [[SMProgressHUD shareInstancetype] dismissLoadingView];
            
            
        });

        [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"网络出错"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
        
    }];
    }
    
    else if(indexPath.row==1){
        messViewController *vic=[[messViewController alloc]init];
        [self.navigationController pushViewController:vic animated:YES];
           } else if (indexPath.row == 3) {
         aboutViewController * aboutvc = [[ aboutViewController alloc]init];
       UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:aboutvc];
        [controller.navigationBar setBarTintColor:redRGB];
       [self presentViewController:controller animated:YES completion:nil];
    }
    else if (indexPath.row==0){
        WebViewController * aboutvc =[[WebViewController alloc]init];
        [self.navigationController pushViewController:aboutvc animated:YES];

 
    }else if (indexPath.row==2){
accountViewController * vc =[[accountViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==4){
       SetViewController * vc =[[SetViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }


}

-(void)getpersonInfo{
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
                                 @"UserEntity":@{
                                         @"token":[NSString stringWithFormat:@"%@", [array.lastObject objectForKey:@"token"]]
                                         }};//发送请求
    [manager POST: PersonInfo  parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"ewqqe%@",responseObject);
        NSDictionary *dic=[responseObject objectForKey:@"Result"];
        self.dicPerson=[[NSMutableDictionary alloc]initWithDictionary:[dic objectForKey:@"user" ]];
        NSURL * url2= [NSURL URLWithString:[NSString stringWithFormat:@"%@", [self.dicPerson objectForKey:@"portrait"]]];
        [self.personView   sd_setImageWithURL:url2 placeholderImage:[UIImage imageNamed:@"user_head.png"]];

     //   [self.personView   sd_setImageWithURL:url2 placeholderImage:[UIImage imageNamed:@"user_head.png"]];
        self.personLabname.text=[NSString stringWithFormat:@"%@",[self.dicPerson objectForKey:@"realName"] ];
        self.personPhone.text=[NSString stringWithFormat:@"%@",[self.dicPerson objectForKey:@"phone"] ];
        NSLog(@"%@",self.dicPerson);
                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"网络异常,请稍后重试"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
        
    }];

}
@end
