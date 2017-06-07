//
//  checkViewController.m
//  HYB
//
//  Created by CUIZE on 16/8/24.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "checkViewController.h"
#import "Head.h"
#import "upfileViewController.h"
#import "mainViewController.h"
@interface checkViewController ()

@end

@implementation checkViewController
-(id)init{
    if(self){
        self=[super init];
        
    }
    self.failStr=[[NSString alloc]init];
    self.strID=[[NSString alloc]init];
    return self;
}
- (void)viewDidLoad {
    self.view.backgroundColor=garyRGB;
    self.title=@"身份认证";
    [super viewDidLoad];
    [self showlab];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewback{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)showlab{
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"zhankaileft"] style:UIBarButtonItemStyleDone target:self action:@selector(viewback)];
    self.navigationItem.leftBarButtonItem=left;
    UIImageView *back1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, w , 80)];
    back1.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:back1];
    UIImageView *vic=[[UIImageView alloc]initWithFrame:CGRectMake(70, 89, w-140, 1)];
    vic.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:vic];
    self.lab1=[[UIButton  alloc]initWithFrame:CGRectMake(40, 74, 30, 30)];
    self.lab2=[[UIButton alloc]initWithFrame:CGRectMake(0.5*w-15, 74, 30, 30)];
    self.lab3=[[UIButton alloc]initWithFrame:CGRectMake(w-70, 74, 30, 30)];
    [self.lab1 setTitle:@"1" forState:UIControlStateNormal];
    [self.lab2 setTitle:@"2" forState:UIControlStateNormal];
    [self.lab3 setTitle:@"3" forState:UIControlStateNormal];
 
    [self lab:self.lab1];
    [self lab:self.lab2];
    [self lab:self.lab3];
     [self.view addSubview:self.lab3];
     [self.view addSubview:self.lab1];
     [self.view addSubview:self.lab2];
    self.lab11=[[UILabel  alloc]initWithFrame:CGRectMake(30, 109, 60, 30)];
    self.lab21=[[UILabel alloc]initWithFrame:CGRectMake(0.5*w-30, 109, 60, 30)];
    self.lab31=[[UILabel alloc]initWithFrame:CGRectMake(w-90, 109, 60, 30)];
    [self labtext:self.lab11 :@"填写信息"];
     [self labtext:self.lab21 :@"等待审核"];
     [self labtext:self.lab31 :@"认证完成"];
    [self.view addSubview:self.lab31];
    [self.view addSubview:self.lab11];
    [self.view addSubview:self.lab21];
    UIImageView *back2=[[UIImageView alloc]initWithFrame:CGRectMake(0, 160, w , 180)];
    back2.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:back2];
    self.Uiimage=[[UIImageView alloc]initWithFrame:CGRectMake(0.5*w-30, 180, 60, 60)];
    self.Uiimage.layer.cornerRadius=30;
    self.Uiimage.layer.masksToBounds=YES;
    [self.Uiimage.layer setBorderWidth:1];
    [self.Uiimage.layer setBorderColor:[UIColor clearColor].CGColor];
   // self.Uiimage.image=[UIImage imageNamed:@"hybwait"];
    
    [self.view addSubview:self.Uiimage];
    self.lab4=[[UILabel alloc]initWithFrame:CGRectMake(40, 250, w-80, 50)];
    self.lab4.textColor=redRGB;
    [self labtext:self.lab4 :@"申请已成功提交，正在审核中"];
    [self.view addSubview:self.lab4];
    self.faillab=[[UILabel alloc]initWithFrame:CGRectMake(0, 300, w , 30)];
    self.faillab.textColor=backRGB;
    self.faillab.textAlignment=NSTextAlignmentCenter;
    self.faillab.adjustsFontSizeToFitWidth=YES;
    //self.faillab.font=[UIFont systemFontOfSize:];
    [self.view addSubview:self.faillab];
    self.lab41=[[UILabel alloc]initWithFrame:CGRectMake(60, 300, w-120, 20)];
    self.lab41.textColor=redRGB;
  
    [self.view addSubview:self.lab41];
    self.uibutton =[[UIButton alloc]initWithFrame:CGRectMake(40, 350, w-80, 50)];
    self.uibutton.backgroundColor=redRGB;
        [self.view addSubview:self.uibutton];
    [self.uibutton addTarget:self action:@selector(getpushview) forControlEvents:UIControlEventTouchUpInside];
    if([self.strID isEqualToString:@"1"])
    {
        [self labtext:self.lab41 :@"我们会尽快处理您的认证申请，审核结果会及时通知您"];
        [self.lab2 setImage:[UIImage imageNamed:@"forgot_index_current.png"] forState:UIControlStateNormal];
        self.Uiimage.image=[UIImage imageNamed:@"hybwait"];

        [self.uibutton setTitle:@"进入首页" forState:UIControlStateNormal];

    }
    else if([self.strID isEqualToString:@"2"])
    {  [self labtext:self.lab41 :@"我们会尽快处理您的认证申请，审核结果会及时通知您"];
        [self.lab2 setImage:[UIImage imageNamed:@"forgot_index_current.png"] forState:UIControlStateNormal];
        self.Uiimage.image=[UIImage imageNamed:@"hybwait"];

        [self.uibutton setTitle:@"确认" forState:UIControlStateNormal];
        }
    else if([self.strID isEqualToString:@"3"]){
        [self.lab3 setImage:[UIImage imageNamed:@"forgot_index_current.png"] forState:UIControlStateNormal];
        self.Uiimage.image=[UIImage imageNamed:@"hybture"];

        [self.uibutton setTitle:@"确认" forState:UIControlStateNormal];
        [self labtext:self.lab4 :@"恭喜您认证成功!"];
    }else if([self.strID isEqualToString:@"4"]){
        self.lab31.text=@"认证失败";
        self.Uiimage.image=[UIImage imageNamed:@"hybfalse"];
        self.faillab .text=self.failStr;
        [self.lab3 setImage:[UIImage imageNamed:@"forgot_index_current.png"] forState:UIControlStateNormal];
        [self.uibutton setTitle:@"重新提交" forState:UIControlStateNormal];
        [self labtext:self.lab4 :@"对不起!您认证失败"];
        
            //self.lab4=[[UILabel alloc]initWithFrame:CGRectMake(40, 250, w-80, 50)];
    }

}
-(void)getpushview{
    if([self.strID isEqualToString:@"1"])
    {
        mainViewController *vic=[[mainViewController alloc]init];
        
        [self presentViewController:vic animated:YES completion:nil];
    }
    else if([self.strID isEqualToString:@"2"])
    {
        [self dismissViewControllerAnimated:YES completion:nil];

    }
    else if([self.strID isEqualToString:@"3"]){
        [self dismissViewControllerAnimated:YES completion:nil];

    }
    else if([self.strID isEqualToString:@"4"])
    {
        upfileViewController *vic=[[upfileViewController alloc] initWithNibName:@"LocationPickerVC" bundle:nil];
        UINavigationController *niv=[[UINavigationController alloc]initWithRootViewController:vic];
        [niv.navigationBar setBarTintColor:redRGB];
        [self presentViewController:niv animated:YES completion:nil];

    }

}
-(void)lab :(UIButton *)lab1{
   lab1.layer.cornerRadius =15;
    lab1.layer.masksToBounds = YES;
    [ lab1.layer setBorderWidth:1];
    lab1.backgroundColor=garyRGB;
    [lab1.layer setBorderColor:[UIColor clearColor].CGColor];  //设置边框为白色
    lab1.titleLabel.textAlignment=NSTextAlignmentCenter;
    lab1.titleLabel.adjustsFontSizeToFitWidth=YES;
}
-(void)labtext :(UILabel *)lab :(NSString *)str{
    lab.textAlignment=NSTextAlignmentCenter;
    lab.adjustsFontSizeToFitWidth=YES;
    lab.text=str;
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
