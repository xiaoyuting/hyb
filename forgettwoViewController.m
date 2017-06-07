//
//  forgettwoViewController.m
//  HYB
//
//  Created by CUIZE on 16/8/15.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "forgettwoViewController.h"
#import "Head.h"
#import "AFNetworking.h"
#import "LoadView.h"
@interface forgettwoViewController ()

@end

@implementation forgettwoViewController
-(id)init{
    if(self){
        self=[super init];
    }
    self.strPhone=[[NSString alloc]init];
    self.strCode=[[NSString alloc]init];
    return self;
}
-(void)viewback{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(viewback)];
    self.navigationItem.leftBarButtonItem=left;
    self.title=@"找回密码";
    
    self.view.backgroundColor=garyRGB;
    self.headImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, w, 0.1*h)];
    
    self.headImage.image=[UIImage   imageNamed:@"keyword2.png"];
    [self.view addSubview:self.headImage];
    UIImageView *line =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0.1*h+70, w , 0.3*h-40)];
    line.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:line];
        self.password=[[LYTextField alloc]initWithFrame:CGRectMake(0.2*w   ,h*0.2 +40, 0.6*w , 0.05*h )];
    self.password.textField.placeholder=@"新密码";
    self.password.textField.textColor=backRGB;
    self.password.lineView.backgroundColor=backRGB;
    [self.password.textField setTintColor:backRGB];
    self.password.textField.secureTextEntry=YES;
    [self.view addSubview:self.password];
     self.repeatPassword=[[LYTextField alloc]initWithFrame:CGRectMake(0.2*w  , 0.25*h+50 ,  0.6*w , 0.05*h)];
    
    self.repeatPassword.textField.placeholder=@"重复密码";
    self.repeatPassword.textField.textColor=backRGB;
    self.repeatPassword.lineView.backgroundColor=backRGB;
    [self.repeatPassword.textField setTintColor:backRGB];
    self.repeatPassword.textField.secureTextEntry=YES;
    [self.view addSubview:self.repeatPassword];
    
    self.nextBtn=[[UIButton alloc]initWithFrame:CGRectMake(0.1*w, 0.4*h+40, 0.8*w, 0.05*h)];
    self.nextBtn.backgroundColor=redRGB;
    [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextBtn addTarget:self action:@selector(nexttwo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextBtn];
    self.nextBtn.tag=0;
    self.viewDetail=[[UIView alloc]initWithFrame:CGRectMake(0, 0.1*h+70, w , 0.3*h-40)];
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0.5*self.viewDetail.frame.size.width-0.1*self.viewDetail.frame.size.height, 0.1*self.viewDetail.frame.size.height,0.2*self.viewDetail.frame.size.height , 0.2*self.viewDetail.frame.size.height)];
    
    image.backgroundColor=[UIColor redColor];
    [self.viewDetail addSubview:image];
    self.viewDetail.backgroundColor=[UIColor whiteColor];
    UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(0.2*self.viewDetail.frame.size.width,0.35*self.viewDetail.frame.size.height , 0.6*self.viewDetail.frame.size.width, 0.2*self.viewDetail.frame.size.height)];
    lab1.adjustsFontSizeToFitWidth=YES;
    lab1.textColor=redRGB;
    lab1.textAlignment=NSTextAlignmentCenter;
    lab1.text=@"恭喜你操作成功!";
    [self.viewDetail  addSubview:lab1];
    UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(0.2*self.viewDetail.frame.size.width,0.55*self.viewDetail.frame.size.height , 0.6*self.viewDetail.frame.size.width, 0.18*self.viewDetail.frame.size.height)];
    lab2.adjustsFontSizeToFitWidth=YES;
  lab2.textColor=backRGB;
    lab2.textAlignment=NSTextAlignmentCenter;
    lab2.font=[UIFont systemFontOfSize:9];
    lab2.text=@"密码修改成功，请牢记您的密码\n您可以使用新修改的密码登陆";
   
    //[self.viewDetail  addSubview:lab2];
    UILabel *lab3=[[UILabel alloc]initWithFrame:CGRectMake(0.2*self.viewDetail.frame.size.width+20,0.73*self.viewDetail.frame.size.height , 0.6*self.viewDetail.frame.size.width-40, 0.28*self.viewDetail.frame.size.height)];
    lab3.adjustsFontSizeToFitWidth=YES;
    lab3.textColor=backRGB;
    lab3.textAlignment=NSTextAlignmentCenter;
    lab3.text=@"您可以使用新修改的密码登陆";
     lab3.font=[UIFont systemFontOfSize:9];
  //  [self.viewDetail  addSubview:lab3];
    UIImageView *vicImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.viewDetail.frame.size.width, self.viewDetail.frame.size.height) ];
    vicImage.image=[UIImage imageNamed:@"keyword4.png"];
    [self.viewDetail addSubview:vicImage];
    [self.view addSubview:self.viewDetail];
    self.viewDetail.alpha=0;
    [super viewDidLoad];
}
// 修改密码
-(void)nexttwo :(UIButton *)sender{
    if(sender.tag==0){
    if(self.self.password.textField.text.length==0){
        [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"密码为空"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];

    }else{
        if([self.password.textField.text isEqualToString:self.repeatPassword.textField.text]){
    NSDictionary *json = @{
                           @"UserEntity":@{
                                   @"loginname":self.strPhone,
                                   @"pwd":self.password.textField.text,
                                   @"newpwd":self.repeatPassword.textField.text,
                                   @"code":self.strCode,
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
    [manager POST:getBackPassword parameters:json success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic=[responseObject objectForKey:@"Result"];
        //NSLog(@"dic===%@",dic);
        if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"errorCode"] ] isEqualToString:@"-1"])
        {
            [[[UIAlertView alloc]initWithTitle:@"提示信息" message:  [NSString stringWithFormat:@"%@", [dic objectForKey:@"errorMessage"]] delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];}
        else if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"errorCode"] ] isEqualToString:@"0"]){
            self.headImage.image=[UIImage   imageNamed:@"keyword3.png"];
            self.nextBtn.tag=1;
            self.viewDetail.alpha=1;
            [self.nextBtn setTitle:@"返回登陆" forState:UIControlStateNormal];
            self.navigationItem.leftBarButtonItem=nil;
            }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"网络异常,请稍后重试"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
        
    }];}else{
        [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"两次输入密码不同"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];

    }
    
    }
    }else if(sender.tag==1){
        LoadView *vic=[[LoadView alloc]init];
        NSDictionary *Dic =[[NSDictionary alloc]initWithObjectsAndKeys: @"" ,@"name",@"",@"pass", nil];
        NSArray *Array=[[NSArray alloc]initWithObjects:Dic, nil];
        NSString *path=NSHomeDirectory();
        
        path= [path stringByAppendingString:@"/Documents/"];
        NSString *fileName = [path stringByAppendingPathComponent:@"arry.json"];
        
        if([Array writeToFile:fileName atomically:YES])
        {
           // NSLog(@"%@",Array);
         //   NSLog(@"写入成功");
        }
        else
        {
          //  NSLog(@"写入失败");
        }

        
        UINavigationController *nic=[[UINavigationController  alloc]initWithRootViewController:vic];
        [nic.navigationBar setBarTintColor:redRGB];
        [self presentViewController:nic animated:YES completion:^{
            
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event         {
    [self.view endEditing:YES];
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
