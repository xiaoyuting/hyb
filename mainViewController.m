//
//  mainViewController.m
//  HYB
//
//  Created by CUIZE on 16/8/5.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "mainViewController.h"
#import "Head.h"
@interface mainViewController ()

@end

@implementation mainViewController
 - (void)viewDidLoad {
 
    [super viewDidLoad];
    // 3个界面初始化
    TicketBuyViewController *buy=[[TicketBuyViewController alloc]init];
     
    UINavigationController *buyVic=[[UINavigationController alloc]initWithRootViewController:buy];
    [buyVic.navigationBar setBarTintColor:redRGB];
    TicketlistView *list=[[TicketlistView alloc]init];
    
    UINavigationController *listVic=[[UINavigationController alloc]initWithRootViewController:list];
     [listVic.navigationBar setBarTintColor:redRGB];
   PersonInfoView *person=[[PersonInfoView alloc]init];
    UINavigationController *personVic=[[UINavigationController alloc]initWithRootViewController:person];
     [personVic.navigationBar setBarTintColor:redRGB];
    self.viewControllers=[NSArray arrayWithObjects:buyVic,listVic,personVic, nil];
    self.tabBar.tintColor = redRGB;
    [self setMyTabBarItem:buy title:@"首页" image:[UIImage imageNamed:@"hyb18"]];
    [self setMyTabBarItem:list title:@"已售" image:[UIImage imageNamed:@"hyb182"]];
    [self setMyTabBarItem:person title:@"我的" image:[UIImage imageNamed:@"hyb183"]];
      }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 封装设置tabbaritem方法
- (void)setMyTabBarItem:(UIViewController *)myView title:(NSString *)title image:(UIImage *)image {
    myView.title = title; // 文字 （nav,tabbaritem)
    myView.navigationController.tabBarItem.image = image;
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
