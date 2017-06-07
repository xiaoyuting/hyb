//
//  payResultViewcontroller.m
//  HYB
//
//  Created by CUIZE on 16/8/30.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "payResultViewcontroller.h"
#import "mainViewController.h"

@implementation payResultViewcontroller
-(id)init{
    if(self){
        self=[super init];
    }
    self.dic=[[NSMutableDictionary alloc]init];
    return self;
    
    
    
}
- (void)viewDidLoad {
    self.title=@"付款";
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.imageview=[[UIImageView alloc]initWithFrame:CGRectMake(w*0.2, 64+0.04*h, 40, 40)];
    [self.view addSubview:self.imageview];
    self.labtitle=[[UILabel alloc]initWithFrame:CGRectMake( w*0.2+40, 64+0.04*h  , w-160, 40)];
    self.labdetail.textColor=redRGB;
       self.labtitle.textColor=redRGB;
    self.labtitle.font=[UIFont systemFontOfSize:40];
    self.labtitle.textAlignment=NSTextAlignmentLeft;
    [self.view addSubview:self.labtitle ];
    self.labdetail=[[UILabel alloc]init ];
 
   
    [self.view addSubview:self.labdetail];
    self.btn=[[UIButton alloc]initWithFrame:CGRectMake(20, 300+0.2*h, w-40, 40)];
    self.btn.backgroundColor=redRGB;
    [self.view addSubview:self.btn];
    [self.btn addTarget:self action:@selector(getstyle:) forControlEvents:UIControlEventTouchUpInside];
    if([[NSString stringWithFormat:@"%@", [self.dic objectForKey:@"str"] ] isEqualToString:@"1"]){
        self.labtitle.text=@"支付成功";
        self.labtitle .adjustsFontSizeToFitWidth=YES;
                self.labdetail.numberOfLines=0;
       self.labdetail.font=[UIFont systemFontOfSize:16];
        self.labdetail.text=[NSString stringWithFormat:@"您的订单(%@)已经付款成功！",[self.dic objectForKey:@"number"]];

        self.labdetail.textAlignment=NSTextAlignmentCenter;
        CGSize textSize=[ self.labdetail.text boundingRectWithSize:CGSizeMake(w-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
        
        CGFloat textH=textSize.height;
         self.labdetail.frame=CGRectMake(20,  130+0.08*h, w-40, textH);

        self.imageview.image=[UIImage imageNamed:@"hybture"];
        UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake( 0, 140+0.08*h+textH , w , 30) ];
         UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(0, 175+0.08*h+textH, w , 30) ];
         UILabel *lab3=[[UILabel alloc]initWithFrame:CGRectMake( 0,  210+0.08*h+textH, w , 30) ];
        lab1.textAlignment=NSTextAlignmentCenter;
          lab2.textAlignment=NSTextAlignmentCenter;
        lab3.textAlignment=NSTextAlignmentCenter;
        lab1.text=@"友情提示:游客手机取票方式";
        lab2.text=@"1.微信支付:通过公众号“支付成功通知”取票";
        lab3.text=@"2.支付宝: 通过服务窗“详情”取票";
        lab1.adjustsFontSizeToFitWidth=YES;
        lab2.adjustsFontSizeToFitWidth=YES;
        lab3.adjustsFontSizeToFitWidth=YES;
        lab1.textColor=[UIColor orangeColor];
          lab2.textColor=[UIColor orangeColor];
          lab3.textColor=[UIColor orangeColor];
        [self.view addSubview:lab1];
        [self.view addSubview:lab2];
        [self.view addSubview:lab3];
        self.btn.tag=1;
        [self.btn setTitle:@"确认" forState:UIControlStateNormal];
    }else if([[NSString stringWithFormat:@"%@", [self.dic objectForKey:@"str"] ] isEqualToString:@"2"]){
           self.imageview.image=[UIImage imageNamed:@"hybfalse"];
         self.labtitle.text=@"支付失败";
        self.labtitle .adjustsFontSizeToFitWidth=YES;

        self.labdetail.numberOfLines=0;
        self.labdetail.font=[UIFont systemFontOfSize:16];
         self.labdetail.text=@"您的订单支付失败！请取消订单重新支付";
        self.labdetail.textAlignment=NSTextAlignmentCenter;
        CGSize textSize=[ self.labdetail.text boundingRectWithSize:CGSizeMake(w-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
        
        CGFloat textH=textSize.height;
        self.labdetail.frame=CGRectMake(20,  130+0.08*h, w-40, textH);
       
        self.btn.tag=2;
        [self.btn setTitle:@"请重新下单" forState:UIControlStateNormal];
    }
}
-(void)getstyle :(UIButton *)sender{
    
    if(sender.tag==1){
        mainViewController *vic=[[mainViewController alloc]init];
        vic.selectedIndex = 1;
            [self presentViewController:vic animated:YES completion:nil];
            
       

    }else if(sender.tag==2){
        [self dismissViewControllerAnimated:NO completion:^{
            NSLog(@"21321");
            [self.delegate getpushView];
        }];
       
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    }

@end
