//
//  aboutViewController.m
//  HYBao
//
//  Created by CUIZE on 16/9/1.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "aboutViewController.h"
#import "webBookViewController.h"
#import "Head.h"
#import "aboutButton.h"
@interface aboutViewController ()
@property UIImageView *headimage;
@property UIImageView *centerimage;
@property aboutButton *btn1;
@property aboutButton *btn2;
@property aboutButton *btn3;
@end

@implementation aboutViewController
-(void)viewback{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"zhankaileft"] style:UIBarButtonItemStyleDone target:self action:@selector(viewback)];
    self.navigationItem.leftBarButtonItem=left;
    [super viewDidLoad];
    self.title=@"关于我们";
    UIImageView *back1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, w , 127/339.0*0.5*w+40)];
    back1.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:back1];
    self.view.backgroundColor=garyRGB;
    self.headimage=[[UIImageView alloc]initWithFrame:CGRectMake(0.25*w, 84,0.5*w ,  127/339.0*0.5*w)];
    self.headimage.image=[UIImage imageNamed:@"hyb12"];
       UILabel * lab =[[ UILabel  alloc]initWithFrame:CGRectMake(0,127/339.0*0.5*w+110 , w, 585/885.0*w)];
     lab.numberOfLines=0;
    lab.backgroundColor=[UIColor whiteColor];
    lab.font=[UIFont systemFontOfSize:14];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"上海萃泽旅游发展有限公司是一家利用云计算、物联网等新技术，通过互联网，借助便捷的智能终端，重构传统旅游供应链的创新者。\n旗下的“嗨摇”产品是基于用户场景，深度定制开发，为景区集游客提供全方位的购票、导航、解说、购物、等供应链一体化服务。达到旅游前，旅游中，旅游后都能主动感知旅游资源，旅游经济，旅游活动等方面的信息。提升游客在吃、住、行、游、购、娱各个旅游环节中的附加值。"];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.headIndent = 30;//缩进
    style.tailIndent=w-30;
    style.alignment=NSTextAlignmentLeft;
    style.firstLineHeadIndent =30;

    style.lineSpacing = 2;//行距
    [text addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
   lab.adjustsFontSizeToFitWidth=YES;
     lab.attributedText = text;
    
   [self.view addSubview:lab];
      UILabel *labBook=[[UILabel alloc]initWithFrame:CGRectMake(0, 127/339.0*0.5*w+110+585/885.0*w+10 , w , (h-(127/339.0*0.5*w+110+585/885.0*w+10))/6.0)];
    labBook.text=@"  我有疑问";
    [self.view addSubview:labBook];
         self.btn1=[[aboutButton alloc]initWithFrame:CGRectMake(0, 127/339.0*0.5*w+110+585/885.0*w+10+(h-(127/339.0*0.5*w+110+585/885.0*w+10))/6.0, w , (h-(127/339.0*0.5*w+110+585/885.0*w+10))/6.0)];
    self.btn1.backgroundColor=[UIColor whiteColor];
    self.btn1.lab.text=@"如何退票?";
    self.btn1.tag=1;
    [self.btn1 addTarget:self action:@selector(getviewDetail:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn1];
    self.btn2=[[aboutButton alloc]initWithFrame:CGRectMake(0, 127/339.0*0.5*w+110+585/885.0*w+10+(h-(127/339.0*0.5*w+110+585/885.0*w+10))/3.0, w , (h-(127/339.0*0.5*w+110+585/885.0*w+10))/6.0)];
      self.btn2.backgroundColor=[UIColor whiteColor];
    self.btn2.lab.text=@"如何入园?";
    self.btn2.tag=2;
    [self.btn2 addTarget:self action:@selector(getviewDetail:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn2];
    self.btn3=[[aboutButton alloc]initWithFrame:CGRectMake(0, 127/339.0*0.5*w+110+585/885.0*w+10+(h-(127/339.0*0.5*w+110+585/885.0*w+10))/2.0, w , (h-(127/339.0*0.5*w+110+585/885.0*w+10))/6.0)];
      self.btn3.backgroundColor=[UIColor whiteColor];
    self.btn3.lab.text=@"联系客服";
    self.btn3.tag=3;
    [self.btn3 addTarget:self action:@selector(getviewDetail:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn3];

    UILabel * lab2 =[[ UILabel  alloc]initWithFrame:CGRectMake(0, h-((h-(127/339.0*0.5*w+110+585/885.0*w+10))/3.0), w , (h-(127/339.0*0.5*w+110+585/885.0*w+10))/3.0)];
    lab2.numberOfLines=0;
    //lab2.backgroundColor=[UIColor redColor];
  //  127/339.0*0.5*w+110+585/885.0*w+10+2*((h-(127/339.0*0.5*w+110+585/885.0*w+10))/3.0-10)
   // lab2.backgroundColor=[UIColor whiteColor];
    lab2.font=[UIFont systemFontOfSize:14];
    NSMutableAttributedString *text2 = [[NSMutableAttributedString alloc] initWithString:@"Copyright©2016\n上海萃泽旅游发展有限公司"];
    NSMutableParagraphStyle *style2 = [[NSMutableParagraphStyle alloc] init];
    style2.headIndent = 30;//缩进
    style2.tailIndent=w-30;
    style2.alignment=NSTextAlignmentCenter;
    style2.firstLineHeadIndent =30;
    
    style2.lineSpacing = 1;//行距
    [text2 addAttribute:NSParagraphStyleAttributeName value:style2 range:NSMakeRange(0, text2.length)];
    lab2.adjustsFontSizeToFitWidth=YES;
    lab2.attributedText = text2;
    [self.view addSubview:lab2];
    [self.view addSubview:self.headimage];
    UILabel *version=[[UILabel alloc]initWithFrame:CGRectMake(0.25*w , h-((h-(127/339.0*0.5*w+110+585/885.0*w+10))/3.0), 0.5*w , 20)];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // 当前应用名称
   // NSString *appCurName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    //NSLog(@"当前应用名称：%@",appCurName);
    // 当前应用软件版本  比如：1.0.1
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    //NSLog(@"当前应用软件版本:%@",appCurVersion);
    // 当前应用版本号码   int类型
    NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
   // NSLog(@"当前应用版本号码：%@",appCurVersionNum);

    version.text=[NSString stringWithFormat:@"版本:%@.%@",appCurVersion,appCurVersionNum];
    version.textAlignment=NSTextAlignmentCenter;
    version.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:version];

     // Do any additional setup after loading the view.h-
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getviewDetail :(UIButton *)sender{
    if(sender.tag==1){
        webBookViewController *vic=[[webBookViewController alloc]init];
        vic.viewID=@"1";
        UINavigationController *niv=[[UINavigationController alloc]initWithRootViewController:vic];
        [niv.navigationBar setBarTintColor:redRGB];
        [self presentViewController:niv animated:YES completion:nil];
    }else if(sender.tag==2){
        webBookViewController *vic=[[webBookViewController alloc]init];
        vic.viewID=@"2";
        UINavigationController *niv=[[UINavigationController alloc]initWithRootViewController:vic];
        [niv.navigationBar setBarTintColor:redRGB];
        [self presentViewController:niv animated:YES completion:nil];

        
    }else{
        NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"4008-215-998"];
        UIWebView *callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
        
      
    }
}

@end
