//
//  regitDetailViewController.m
//  HYB
//
//  Created by CUIZE on 16/8/19.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "regitDetailViewController.h"
#import "Head.h"
#import "LoadView.h"
@interface regitDetailViewController ()

@end

@implementation regitDetailViewController

- (void)viewDidLoad {
    self.headImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, w, 0.1*h)];
    self.headImage .backgroundColor=[UIColor redColor];
    [self.view addSubview:self.headImage];
    self.detailImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 70+0.1*h, w, 0.2*h)];
    self.detailImage .backgroundColor=[UIColor redColor];
    [self.view addSubview:self.detailImage];
    self.btnback=[[UIButton alloc]initWithFrame:CGRectMake(50, 0.3*h+100, 2-100, 0.05*h)];
    [self.btnback setTitle:@"返回首页" forState:UIControlStateNormal];
    [self.btnback addTarget:self action:@selector(back ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnback];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)back{
    LoadView *vic=[[LoadView alloc]init];
    UINavigationController *niv=[[UINavigationController alloc]initWithRootViewController:vic];
    [niv.navigationBar setBarTintColor:redRGB];
    [self presentViewController:niv animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
