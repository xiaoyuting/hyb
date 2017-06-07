//
//  YZLoad.m
//  Hexiao
//
//  Created by CUIZE on 16/5/4.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "LoadView.h"
#import "regitViewController.h"
#import "mainViewController.h"
#import "forgetViewController.h"
@interface LoadView ()
 
@end


@implementation LoadView

- (void)viewDidLoad {
    
    
    

//    //  定义一个可变数组，用来存放所有字体
//    NSMutableArray *fontarray = [NSMutableArray arrayWithCapacity:10];
//    //  遍历UI字体
//    for (id x in [UIFont familyNames]) {
//        NSLog(@"%@",x);
//        [fontarray addObject:x];
//    }
   
    UIImageView *backImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, w , h-64)];
    backImage.image=[UIImage imageNamed:@"hyb3"];
    [self.view addSubview:backImage];
           NSURL *baseURL=[NSURL URLWithString:Load];
    AFHTTPRequestOperationManager *manger=[[AFHTTPRequestOperationManager alloc]initWithBaseURL:baseURL];
    NSOperationQueue *quequ=manger.operationQueue;
    [manger.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                case AFNetworkReachabilityStatusNotReachable:
                [quequ setSuspended:NO];
                break;
                case AFNetworkReachabilityStatusUnknown:
                
            default:
                [quequ setSuspended:YES];
                break;
        }
    }];
    self.title=@"登录";
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(postUp)];
    self.navigationItem.rightBarButtonItem=right;
    self.image=[[UIImageView alloc]initWithFrame: self.view.frame];
    UIImage *image=[UIImage imageNamed:@"BG_Login Hiyo.png"];
    self.image.image=image;
    [self.view addSubview:self.image];
     self.name=[[LYTextField alloc]initWithFrame:CGRectMake(0.15*w , h*0.3 -40, 0.7*w , 0.05*h)];
    self.name.textField.placeholder=@"请输入账号";
    self.name.textField.keyboardType=UIKeyboardTypeNumberPad;
    [self.name setCursorColor:[UIColor whiteColor]];
        [self.view addSubview: self.name];
    
    self.password=[[LYTextField alloc]initWithFrame:CGRectMake(0.15*w ,0.35*h-30, 0.7*w , 0.05*h)];
    self.password.textField.placeholder=@"请输入密码";
    self.password.textField.secureTextEntry=YES;
    [self.view addSubview:self.password ];
       self.vic2=[[UIImageView alloc]initWithFrame: CGRectMake(0.2*w-5 ,h*0.4 -29, 0.6*w+10, 1)];
    self.vic2.backgroundColor=[UIColor whiteColor];
    
    self.load=[[UIButton alloc]initWithFrame: CGRectMake(0.2*w -5,  0.5*h-5 , 0.6*w+10, 0.05*h)];
    
    [self.load setTitle:@"登录" forState:UIControlStateNormal];
    self.load.backgroundColor=[UIColor whiteColor];
    [self.load setTitleColor:redRGB
                    forState:UIControlStateNormal];
    
    self.Write=[[UIButton alloc]initWithFrame: CGRectMake(0.42*w, 0.4*h-5 , 0.16*w, 0.05*h)];
    UIImageView*vic3 =[[UIImageView alloc]initWithFrame:CGRectMake(0.42*w ,0.45*h-4, 0.16*w, 1)];
    vic3.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:vic3];
    
    self.Write.titleLabel.textColor=[[UIColor alloc]initWithRed:0.1 green:0.72 blue:0.75 alpha:1];
    [self.Write setTitleColor: [UIColor whiteColor]
                     forState:UIControlStateNormal];
    self.Write.titleLabel.adjustsFontSizeToFitWidth=YES;
    self.Write.titleLabel.font=[UIFont systemFontOfSize:12];
    
    [self.Write setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.Write addTarget:self action:@selector(forget ) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
        [self.view addSubview:self.load];
    [self.view addSubview:self.Write];
    [self.load addTarget:self action:@selector(loadget) forControlEvents:UIControlEventTouchUpInside];
        [super viewDidLoad];
    self.Array =[[NSMutableArray alloc]init];
    [self remberGet];
    

    // Do any additional setup after loading the view.
}
 //检测是有账号密码保存
-(void)remberGet{
    NSString *path=NSHomeDirectory();
  //  NSLog(@"%@",path);
    NSString * path2=[path stringByAppendingString:@"/Documents/"];
    NSString * path1=[path2 stringByAppendingString:@"/arry.json"];
    
    NSArray *array=[[NSArray alloc]init];
    array=[NSArray arrayWithContentsOfFile:path1];
    if(array.count==0){
        self.name.textField.text=@"";
        
    }
    else
    {
        self.name.textField.text=[array.lastObject objectForKey:@"name"];
        self.password.textField.text=[array.lastObject objectForKey:@"pass"];
    }
}
//保存
- (void)writeInfo {
    NSString *strPass = self.name.textField.text;
    NSString *strLoad=self.password.textField.text;
    strLoad=[strLoad stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    strPass=[strPass stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if([strPass  isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"友情提示" message:@"帐号输入为空" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles: nil];
        [alert show];
        self.name.textField.text=@"";
        [self.name.textField becomeFirstResponder];
    }
    
    else if([strLoad isEqualToString:@""]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"友情提示" message:@"密码输入为空" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles: nil];
        [alert show];
        self.password.textField.text=@"";
        [self.password becomeFirstResponder];
        
    }
    else
    {
        self. Dic =[[NSDictionary alloc]initWithObjectsAndKeys: self.name.textField.text ,@"name",self.password.textField.text,@"pass", nil];
        [self.Array addObject:self.Dic];
        
        
        NSString *path=NSHomeDirectory();
        
        path= [path stringByAppendingString:@"/Documents/"];
        NSString *fileName = [path stringByAppendingPathComponent:@"arry.json"];
        
        if([self.Array writeToFile:fileName atomically:YES])
        {
           // NSLog(@"%@",self.Array);
           // NSLog(@"写入成功");
        }
        else
        {
           // NSLog(@"写入失败");
        }
    }
}
//登录帐号
- (void)loadget{
   
    
    if([self.name.textField.text isEqualToString:@""])
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"友情提示" message:@"用户名为空" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles: nil];
        [alert show];
        
        
    }
    else if([self.password.textField.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"友情提示" message:@"密码为空" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles: nil];
        [alert show];
        
        
    }
    else
    {   [[SMProgressHUD shareInstancetype] showLoading];

         AFHTTPRequestOperationManager*manager=[AFHTTPRequestOperationManager manager];
        //申明返回的结果是json类型
        manager.requestSerializer=[AFJSONRequestSerializer serializer];
        //申明请求的数据是json类型
        manager.responseSerializer=[AFJSONResponseSerializer serializer];
        //设置请求头
        [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
        NSDictionary *parameters = @{
                                     @"UserEntity":@{
                                             @"loginname":self.name.textField.text,
                                             @"pwd":self.password.textField.text,
                                             
                                             }
                                     };
        
        NSLog(@"%@",Load);
        //发送请求
        [manager POST:Load  parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
           
            //[self.gifLoading setState: CLLoadStateFinish];
            NSDictionary *dic=[responseObject objectForKey:@"Result"];
            NSLog(@"%@",dic);
            
                if([[NSString  stringWithFormat:@"%@",[dic objectForKey:@"errorCode"]] isEqualToString:@"0"]){
                
                //token存储
                //************************************************************
                NSDictionary   *dicid=[dic objectForKey:@"user"];
               NSString *idCardNo=[dicid objectForKey:@"idCardNo"];
                NSString* token=[dic objectForKey:@"token"];
                NSString *ID=[dicid objectForKey:@"id"];
               // NSString *pic=[dic objectForKey:@"userPhotoUrl"];
                NSDictionary*  tokenD =[[NSDictionary alloc]initWithObjectsAndKeys:  token ,@"token",idCardNo,@"idCardNo",ID,@"ID",nil];
                NSMutableArray *Array=[[ NSMutableArray  alloc]init];
                [Array addObject:tokenD];
                NSLog(@"%@",Array);
                NSString *path=NSHomeDirectory();
                path= [path stringByAppendingString:@"/Documents/"];
                NSString *fileName = [path stringByAppendingPathComponent:@"token.json"];
                if([Array writeToFile:fileName atomically:YES])
                {
                    NSLog(@"写入成功");
                }
                //************************************************************
                [self writeInfo];
                NSDictionary *dicauthstate=[[NSDictionary alloc]initWithDictionary:[dic objectForKey:@"user"]];
                if([[NSString stringWithFormat:@"%@", [dicauthstate objectForKey:@"authState"]] isEqualToString:@"0"]){
                    upfileViewController *vic=[[upfileViewController alloc] initWithNibName:@"LocationPickerVC" bundle:nil];
                    UINavigationController *niv=[[UINavigationController alloc]initWithRootViewController:vic];
                    [niv.navigationBar setBarTintColor:redRGB];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [[SMProgressHUD shareInstancetype] dismissLoadingView];
                         [self presentViewController:niv animated:YES completion:nil];
                    });

                   

                }else{
             mainViewController *vic=[[mainViewController alloc]init];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [[SMProgressHUD shareInstancetype] dismissLoadingView];
                        NSString *path=NSHomeDirectory();
                        NSArray *arr=[NSArray arrayWithObject:@"1"];
                        path= [path stringByAppendingString:@"/Documents/"];
                        NSString *fileName = [path stringByAppendingPathComponent:@"localID.json"];
                        
                        if([arr writeToFile:fileName atomically:YES])
                        {
                         //   NSLog(@"%@",arr);
                         //   NSLog(@"写入成功");
                        }
                        else
                        {
                        //    NSLog(@"写入失败");
                        }

                        [self presentViewController:vic animated:YES completion:nil];

                    });

                          }
                } else if([[NSString  stringWithFormat:@"%@",[dic objectForKey:@"errorCode"]] isEqualToString:@"50001"]){
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [[SMProgressHUD shareInstancetype] dismissLoadingView];
                                             });

                     [[[UIAlertView alloc]initWithTitle:@"提示信息" message:[NSString  stringWithFormat:@"%@",[dic objectForKey:@"errorMessage"]]   delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
                }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [[SMProgressHUD shareInstancetype] dismissLoadingView];

           // NSLog(@"Error: %@", error);
            
           [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"网络异常,请稍后重试"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
        
        }];
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event         {
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//跳转到注册界面
-(void)postUp{
    
    regitViewController *vic=[[regitViewController alloc]init];
    UINavigationController *niv=[[UINavigationController alloc]initWithRootViewController:vic];
    [niv.navigationBar setBarTintColor:redRGB];
    [self  presentViewController:niv  animated:YES completion:nil];
    }
//忘记密码页面
-(void)forget{
    
    forgetViewController *vic=[[forgetViewController alloc]init];
    UINavigationController *niv=[[UINavigationController alloc]initWithRootViewController:vic];
     [niv.navigationBar setBarTintColor:redRGB];
    [self presentViewController:niv animated:YES completion:nil];
    
}
@end
