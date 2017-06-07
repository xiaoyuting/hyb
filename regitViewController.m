//
//  regitViewController.m
//  HIYAOXYT
//
//  Created by CUIZE on 16/5/23.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "regitViewController.h"
#import "BuyticketWebViewController.h"
@interface regitViewController ()

@end

@implementation regitViewController

- (void)viewDidLoad {
    self.title=@"注册";
    
    UIImageView *backImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, w , h-64)];
    backImage.image=[UIImage imageNamed:@"hyb3"];
    [self.view addSubview:backImage];

  UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStyleDone target:self action:@selector(viewLoad)];
    self.navigationItem.rightBarButtonItem=right;
    self.image=[[UIImageView alloc]initWithFrame: self.view.frame];
    UIImage *image=[UIImage imageNamed:@"BG_Login Hiyo.png"];
    self.image.image=image;
    [self.view addSubview:self.image];

    self.getpyz=[[UIButton alloc]initWithFrame:CGRectMake  (0.6*w ,0.5*h-4  , 0.2*w, 0.05*h)];
    
    self.getpyz.titleLabel.adjustsFontSizeToFitWidth=YES;
    [self.getpyz setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.agreement=[[UIButton alloc]initWithFrame:CGRectMake(0.2*w -5, 0.72*h-60, 55, 55)];
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0.2*w +50, 0.72*h-60, 0.6*w-45, 50)];
    UIImageView *viewpic=[[UIImageView alloc]initWithFrame:CGRectMake(0.2*w+30, 0.72*h-45,20,20)];
    viewpic.image=[UIImage imageNamed:@"cheakRegist.png"];
    [self.view addSubview:viewpic];
    lab.textAlignment=NSTextAlignmentLeft;
       lab.adjustsFontSizeToFitWidth=YES;
    lab.text=@"同意并接受<通用协议>中的相关条款";
    lab.textColor=[UIColor whiteColor];
    lab.userInteractionEnabled=YES;
    UIButton *btnAgree=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0.6*w-45, 50)];
    [btnAgree addTarget:self action:@selector(getWebview) forControlEvents:UIControlEventTouchUpInside];
    [lab addSubview:btnAgree];
    [self.view addSubview: lab];
    [self.view addSubview:self.agreement];
    [self.agreement  addTarget:self action:@selector(agreebook) forControlEvents:UIControlEventTouchUpInside];
    self.getpyz.backgroundColor=[UIColor whiteColor];
    [self.getpyz setTitleColor: redRGB
                    forState:UIControlStateNormal];

    [self.getpyz addTarget:self action:@selector(getphoneNumber) forControlEvents:UIControlEventTouchUpInside];
     self.PhoneNumber=[[LYTextField alloc]initWithFrame:CGRectMake(0.2*w , 0.3*h -40, 0.6*w , 0.05*h)];
    self.PhoneNumber.textField.placeholder=@"手机号";
    [self.view addSubview:self.PhoneNumber];
     self.passWord=[[LYTextField alloc]initWithFrame:CGRectMake(0.2*w  , 0.35*h-30 , 0.6*w , 0.05*h)];
    self.passWord.textField.placeholder=@"密码";
    self.passWord.textField.secureTextEntry=YES;
    [self.view addSubview:self.passWord];
   
    self.repeatpassWord=[[LYTextField alloc]initWithFrame:CGRectMake(0.2*w , 0.4*h-20 , 0.6*w , 0.05*h)];
    self.repeatpassWord.textField.placeholder=@"重复密码";
    self.repeatpassWord.textField.secureTextEntry=YES;
    [self.view addSubview:self.repeatpassWord];
     self.cheakNumber=[[LYTextField alloc]initWithFrame:CGRectMake(0.2*w   , 0.45*h-10 , 0.6*w , 0.05*h )];
    self.cheakNumber.textField.placeholder=@"邀请码";
    self.cheakNumber.textField.text=@"8888";
    [self.view addSubview:self.cheakNumber];
     self.changeNumber=[[LYTextField alloc]initWithFrame:CGRectMake(0.2*w , 0.5*h+1 ,  0.2*w+40, 0.05*h)];
    self.changeNumber.textField.placeholder=@"验证码";
    [self.view addSubview:self.changeNumber];
 
    self.load=[[UIButton alloc]initWithFrame: CGRectMake(0.2*w -5,  0.72*h-5 , 0.6*w+10, 0.05*h)];
    
       [self.load setTitle:@"注册" forState:UIControlStateNormal];
   
    self.load.backgroundColor=[UIColor whiteColor];
    [self.load setTitleColor:redRGB
                    forState:UIControlStateNormal];

    
    [self.view addSubview:self.load];
    [self.view addSubview:self.Write];
        [self.view addSubview:self.getpyz];
  
         [self.load addTarget:self action:@selector(loadget) forControlEvents:UIControlEventTouchUpInside];
    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(change) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(current) name:UIKeyboardWillHideNotification object:nil];
    self.actload=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.actload.center=self.view.center;
    [self.actload setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self.actload setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    // [self.actload setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:self.actload];

    [super viewDidLoad];
    self.Array =[[NSMutableArray alloc]init];
       // Do any additional setup after loading the view.
}
-(void)getWebview{
      BuyticketWebViewController *vic=[[ BuyticketWebViewController alloc]init];
    UINavigationController  *niv=[[UINavigationController  alloc]initWithRootViewController:vic];
    [niv.navigationBar setBarTintColor:redRGB];
    
    [self presentViewController:niv animated:YES completion:nil];
}
-(void)backview{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)viewLoad{
     [self dismissViewControllerAnimated:YES completion:nil];
 }
-(void)agreebook{
    
}
//获取验证码

-(void)getphoneNumber{
    if(self.PhoneNumber.textField.text.length==11){
        __block int timeout=30; //倒计时时间
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if(timeout<=0){ //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    [self.getpyz setTitle:@"获取验证码" forState:UIControlStateNormal];
                    self.getpyz.userInteractionEnabled = YES;
                });
            }else{
                int seconds = timeout % 60;
                NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    //NSLog(@"____%@",strTime);
                    [UIView beginAnimations:nil context:nil];
                    [UIView setAnimationDuration:1];
                    [self.getpyz setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                    [UIView commitAnimations];
                    self.getpyz.userInteractionEnabled = NO;
                });
                timeout--;
            }
        });
        dispatch_resume(_timer);

    // 1.创建请求
   // NSLog(@"phoneNumber");
        
        
    
       
          NSDictionary *json = @{
                                                       @"UserEntity":@{
                                                               @"phone":self.PhoneNumber.textField.text,
                                                               @"smstype":@"1"
                                                               }
                                                       };
        AFHTTPRequestOperationManager*manager=[AFHTTPRequestOperationManager manager];
        //申明返回的结果是json类型
        manager.requestSerializer=[AFJSONRequestSerializer serializer];
        //申明请求的数据是json类型
        manager.responseSerializer=[AFJSONResponseSerializer serializer];
        //设置请求头
        [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
        
        
        //发送请求
        [manager POST:getNumb  parameters:json success:^(AFHTTPRequestOperation *operation, id responseObject) {
          //  NSLog(@"123%@",responseObject);
            NSDictionary *dic=[responseObject objectForKey:@"Result"];
            if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"errorCode"]] isEqualToString:@"0"]){
                
                  [[[UIAlertView alloc]initWithTitle:@"提示信息" message:  [NSString stringWithFormat:@"%@", [dic objectForKey:@"errorMessage"]] delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
               
            }else
            {
            
          
            [[[UIAlertView alloc]initWithTitle:@"提示信息" message:  [NSString stringWithFormat:@"%@", [dic objectForKey:@"errorMessage"]] delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
          //  NSLog(@"Error: %@", error);
            
            [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"网络异常,请稍后重试"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
            
        }];
    }else {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"请检查输入的手机号码" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
    }

    }




-(void)current
{
    
    self.PhoneNumber.frame=CGRectMake(0.2*w ,h*0.3 -40, 0.6*w , 0.05*h);
        self.passWord .frame=CGRectMake(0.2*w  ,0.35*h-30 ,  0.6*w, 0.05*h);
   
    self.changeNumber.frame=CGRectMake(0.2*w   , 0.5*h+1 ,  0.2*w+40, 0.05*h);
    self.load.frame=CGRectMake(0.2*w -5,  0.72*h-5 , 0.6*w+10, 0.05*h);
    self.Write.frame=CGRectMake(0.2*w -5, 0.8*h-5 , 0.6*w+10, 0.05*h);
    self.getpyz.frame= CGRectMake  (0.6*w ,0.5*h-4  , 0.2*w, 0.05*h);
       self.repeatpassWord.frame= CGRectMake(0.2*w , 0.4*h-20 , 0.6*w , 0.05*h) ;
   
   self.cheakNumber.frame= CGRectMake(0.2*w   , 0.45*h-10 , 0.6*w , 0.05*h ) ;
    
   
    }

-(void)change
{
        self.PhoneNumber.frame=CGRectMake(0.2*w ,h*0.3 -60, 0.6*w , 0.05*h);
    
    self.passWord .frame=CGRectMake(0.2*w , 0.35*h-50 ,  0.6*w, 0.05*h-1);
        self.changeNumber.frame=CGRectMake(0.2*w  , 0.5*h-19 ,  0.2*w+40, 0.05*h);
    self.load.frame=CGRectMake(0.2*w -5,  0.72*h-25, 0.6*w+10, 0.05*h);
    self.Write.frame=CGRectMake(0.2*w -5, 0.8*h-25 , 0.6*w+10, 0.05*h);
    self.getpyz.frame= CGRectMake  (0.6*w ,0.5*h-26  , 0.2*w, 0.05*h);
   
    self.repeatpassWord.frame= CGRectMake(0.2*w , 0.4*h-40 , 0.6*w , 0.05*h
                                          ) ;
        self.cheakNumber.frame= CGRectMake(0.2*w   , 0.45*h-30 , 0.6*w , 0.05*h ) ;
    }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
     }
//注册加登录
-(void)loadget{
    NSLog(@"%@",self.changeNumber.textField.text);//验证码
     NSLog(@"%@",self.repeatpassWord.textField.text);//重复密码
      NSLog(@"%@",self.cheakNumber.textField.text);//动态码
     NSLog(@"%@",self.passWord.textField.text);//密码
     NSLog(@"%@",self.PhoneNumber.textField.text);//号码
    
    //验证码验证
    if([self.passWord.textField.text isEqualToString:self.repeatpassWord.textField.text]&&self.passWord.textField.text.length!=0){
    if(self.PhoneNumber.textField.text.length==11&&self.cheakNumber.textField.text.length==4&&self.changeNumber.textField.text.length==4&&self.passWord.textField.text.length!=0&&self.repeatpassWord.textField.text.length!=0&&self.cheakNumber.textField.text.length!=0)//验证码验证
    {
        
        
        NSDictionary *json = @{
                               @"UserEntity":@{
                                       @"loginname":self.PhoneNumber.textField.text,
                                       @"smstype":@"1",
                                       @"usertype":@"7",
                                       @"invitationCode":self.cheakNumber.textField.text,
                                        @"code":self.changeNumber.textField.text,
                                       @"pwd":self.repeatpassWord.textField.text
                                      // @"idCardNo":self.PersonID.text
                                       }
                               };
        AFHTTPRequestOperationManager*manager=[AFHTTPRequestOperationManager manager];
        //申明返回的结果是json类型
        manager.requestSerializer=[AFJSONRequestSerializer serializer];
        //申明请求的数据是json类型
        manager.responseSerializer=[AFJSONResponseSerializer serializer];
        //设置请求头
        [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
        
        
        //发送请求
        [manager POST:Register  parameters:json success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dic=[responseObject objectForKey:@"Result"];
         //   NSLog(@"dic===%@",dic);
          //  NSLog(@"user==%@",[responseObject objectForKey:@"user"]);
            if([[NSString stringWithFormat:@"%@", [dic objectForKey:@"errorCode"]] isEqualToString:@"-1"]){
                [[[UIAlertView alloc]initWithTitle:@"提示信息" message:  [NSString stringWithFormat:@"%@", [dic objectForKey:@"errorMessage"]] delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];}else{
                   // NSLog(@"注册成功");
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
                   // NSLog(@"%@",Array);
                    NSString *path=NSHomeDirectory();
                    path= [path stringByAppendingString:@"/Documents/"];
                    NSString *fileName = [path stringByAppendingPathComponent:@"token.json"];
                    if([Array writeToFile:fileName atomically:YES])
                    {
                      //  NSLog(@"写入成功");
                    }
                    
                    upfileViewController *vic=[[upfileViewController alloc] initWithNibName:@"LocationPickerVC" bundle:nil];
                    UINavigationController *niv=[[UINavigationController alloc]initWithRootViewController:vic];
                    [niv.navigationBar setBarTintColor:redRGB];
                    [self presentViewController:niv animated:YES completion:nil];
                }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"Error: %@", error);
            
            [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"网络异常,请稍后重试"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
            
        }];
    
    
    }else{
        UIAlertView *ale=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"请核验输入信息 " delegate:self  cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [ale show];
        
     }}else{
         UIAlertView *ale=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"两次输入密码不同或者为空 " delegate:self  cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
         [ale show];
     }
    
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
//保存
- (void)writeInfo {
    NSString *strPass = self.PhoneNumber.textField.text;
    NSString *strLoad=self.passWord.textField.text;
    strLoad=[strLoad stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    strPass=[strPass stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if([strPass  isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"友情提示" message:@"帐号输入为空" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles: nil];
        [alert show];
        self.PhoneNumber.textField.text=@"";
        [self.PhoneNumber becomeFirstResponder];
    }
    
    else if([strLoad isEqualToString:@""]){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"友情提示" message:@"密码输入为空" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles: nil];
        [alert show];
        self.passWord.textField.text=@"";
        [self.passWord becomeFirstResponder];
        
    }
    else
    {
        self. Dic =[[NSDictionary alloc]initWithObjectsAndKeys: self.PhoneNumber.textField.text ,@"name",self.passWord.textField.text,@"pass", nil];
        [self.Array addObject:self.Dic];
        
        
        NSString *path=NSHomeDirectory();
        
        path= [path stringByAppendingString:@"/Documents/"];
        NSString *fileName = [path stringByAppendingPathComponent:@"arry.json"];
        
        if([self.Array writeToFile:fileName atomically:YES])
        {
           // NSLog(@"%@",self.Array);
            //NSLog(@"写入成功");
        }
        else
        {
           // NSLog(@"写入失败");
        }
    }
}

@end
