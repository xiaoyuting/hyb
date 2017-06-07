//
//  forgetViewController.m
//  HYB
//
//  Created by CUIZE on 16/8/15.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "forgetViewController.h"
#import "Head.h"
#import "AFNetworking.h"
@interface forgetViewController ()

@end

@implementation forgetViewController
-(void)viewback{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    self.title=@"找回密码";
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(viewback)];
   UIImageView *line =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0.1*h+70, w , 0.3*h-40)];
    line.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:line];
    self.navigationItem.leftBarButtonItem=left;
    self.view.backgroundColor=garyRGB;
    self.headImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, w, 0.1*h)];
    self.headImage .backgroundColor=[UIColor redColor];
    self.headImage.image=[UIImage   imageNamed:@"keyword1.png"];
    [self.view addSubview:self.headImage];
     self.phoneNumber=[[LYTextField alloc]initWithFrame: CGRectMake(0.2*w   ,h*0.2 +40, 0.6*w , 0.05*h )];
    self.phoneNumber.textField.placeholder=@"请输入手机号";
    self.phoneNumber.lineView.backgroundColor=backRGB;
    self.phoneNumber.textField.keyboardType=UIKeyboardTypeNumberPad;
    self.phoneNumber.textField.textColor=backRGB;
    [self.phoneNumber.textField setTintColor:backRGB];
    [self.view addSubview: self.phoneNumber];
   
    
    self.testBtn=[[UIButton alloc]initWithFrame:CGRectMake  (0.6*w ,0.25*h+50  , 0.2*w, 0.05*h)];
    
    self.testBtn.titleLabel.adjustsFontSizeToFitWidth=YES;
    [self.testBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.testBtn setTitleColor:redRGB forState:UIControlStateNormal];
    self.testBtn.layer.cornerRadius=6;
    [self.testBtn.layer setBorderColor:redRGB.CGColor];
    [self.testBtn.layer  setBorderWidth:1];
    [self.testBtn addTarget:self action:@selector(gettextNum) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.testBtn];
    self.cheakNumber=[[LYTextField alloc]initWithFrame:CGRectMake(0.2*w , 0.25*h+50 ,  0.2*w+40, 0.05*h)];
    self.cheakNumber.textField.placeholder=@"请输入验证码";
    self.cheakNumber.textField.textColor=backRGB;
    self.cheakNumber.lineView.backgroundColor=backRGB;
    self.cheakNumber.textField.keyboardType=UIKeyboardTypeNumberPad;
    [self.cheakNumber.textField setTintColor:backRGB];
    [self.view addSubview:self.cheakNumber];
    
     
    self.nextBtn=[[UIButton alloc]initWithFrame:CGRectMake(0.1*w, 0.4*h+40, 0.8*w, 0.05*h)];
    self.nextBtn.backgroundColor=redRGB;
    [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextBtn addTarget:self action:@selector(nexttwo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextBtn];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)gettextNum{
    if(self.phoneNumber.textField.text.length==11){
    __block int timeout=30; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.testBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                self.testBtn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [self.testBtn setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                self.testBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    NSDictionary *json = @{
                           @"UserEntity":@{
                                   @"phone":self.phoneNumber.textField.text,
                                   @"smstype":@"2"
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
        
        NSDictionary *dic=[responseObject objectForKey:@"Result"];
       // NSLog(@"dic===%@",dic);
        
        [[[UIAlertView alloc]initWithTitle:@"提示信息" message:  [NSString stringWithFormat:@"%@", [dic objectForKey:@"errorMessage"]] delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"网络异常,请稍后重试"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
        
    }];}else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"请检查输入的手机号码" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];

    }


}
-(void)change{
    }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)nexttwo{
    if(self.phoneNumber.textField.text.length==11){
        if(self.cheakNumber.textField.text.length==4){
            forgettwoViewController *vic=[[forgettwoViewController alloc]init];
            vic.strCode=self.cheakNumber.textField.text;
            vic.strPhone=self.phoneNumber.textField.text;
            UINavigationController *niv=[[UINavigationController  alloc]initWithRootViewController:vic];
            [niv.navigationBar setBarTintColor:redRGB];
            [self presentViewController:niv animated:YES completion:nil];
        }else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"请检查验证码" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alert show];

        }
   
    }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"请检查手机号" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event         {
    [self.view endEditing:YES];
}

@end
