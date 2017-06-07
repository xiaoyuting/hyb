//
//  SetViewController.m
//  HYBao
//
//  Created by CUIZE on 16/9/2.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "SetViewController.h"
#import "LoadView.h"
@interface SetViewController ()

@end

@implementation SetViewController
-(void)viewback{
    [self.navigationController popViewControllerAnimated:YES];}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"设置";
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"zhankaileft"] style:UIBarButtonItemStyleDone target:self action:@selector(viewback)];
    self.navigationItem.leftBarButtonItem=left;
    self.view.backgroundColor=garyRGB;
    self.btn1=[[aboutButton alloc]initWithFrame:CGRectMake(0, 74, w, h/12.0)];
    self.btn1.tag=1;
    self.btn1.lab.text=@"账户安全";
    self.btn1.backgroundColor=[UIColor whiteColor];
    self.btn1.foot.alpha=0;
     self.btn1.right.alpha=0;
    [self.view addSubview:self.btn1];
    [self.btn1 addTarget:self action:@selector(getaboutButton :) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn2=[[aboutButton alloc]initWithFrame:CGRectMake(0, 84+h/12.0, w, h/12.0)];
    self.btn2.tag=2;
    self.btn2.backgroundColor=[UIColor whiteColor];

    self.btn2.lab.text=@"新消息提醒";
    [self.view addSubview:self.btn2];
    [self.btn2 addTarget:self action:@selector(getaboutButton :) forControlEvents:UIControlEventTouchUpInside];
    self.btn3=[[aboutButton alloc]initWithFrame:CGRectMake(0, 84+h/6.0, w, h/12.0)];
    self.btn3.tag=3;
    self.btn3.backgroundColor=[UIColor whiteColor];

    self.btn3.lab.text=@"隐私";
    [self.view addSubview:self.btn3];
    [self.btn3 addTarget:self action:@selector(getaboutButton :) forControlEvents:UIControlEventTouchUpInside];
    self.btn4=[[aboutButton alloc]initWithFrame:CGRectMake(0, 84+h/4.0, w, h/12.0)];
    self.btn4.tag=4;
    self.btn4.foot.alpha=0;
    self.btn4.backgroundColor=[UIColor whiteColor];

    self.btn4.lab.text=@"通用";
    [self.view addSubview:self.btn4];
    [self.btn4 addTarget:self action:@selector(getaboutButton :) forControlEvents:UIControlEventTouchUpInside];
    self.btnleave=[[UIButton alloc]initWithFrame:CGRectMake(0, 84+h/4.0+10+ h/12.0, w ,  h/12.0)];
    self.btnleave .backgroundColor=[UIColor whiteColor];
    [self.btnleave setTitle:@"退出登陆" forState:UIControlStateNormal];
    [self.btnleave  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:self.btnleave];
    [self.btnleave addTarget:self action:@selector(pushview) forControlEvents:UIControlEventTouchUpInside];
    }
-(void)pushview{
    NSMutableArray *Array=[NSMutableArray array];
    
    [ Array addObject:[[NSDictionary alloc]initWithObjectsAndKeys: @"" ,@"name",@"",@"pass", nil]];
    
    
    NSString *path=NSHomeDirectory();
    
    path= [path stringByAppendingString:@"/Documents/"];
    NSString *fileName = [path stringByAppendingPathComponent:@"arry.json"];
    
    if([ Array writeToFile:fileName atomically:YES])
    {
        NSLog(@"%@", Array);
        NSLog(@"写入成功");
    }
    else
    {
        NSLog(@"写入失败");
    }

    
    LoadView *vic=[[LoadView alloc]init];
    
    
    UINavigationController *nic=[[UINavigationController  alloc]initWithRootViewController:vic];
    [nic.navigationBar setBarTintColor:redRGB];
    [self presentViewController:nic animated:YES completion:^{
        
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getaboutButton :(aboutButton *)sender{
    [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"功能正在建设中"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
}


@end
