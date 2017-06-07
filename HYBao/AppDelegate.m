//
//  AppDelegate.m
//  HYBao
//
//  Created by CUIZE on 16/9/1.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "AppDelegate.h"
#import "LoadView.h"
#import "IQKeyboardManager.h"
@interface AppDelegate ()<UIAlertViewDelegate>
@property NSDictionary *dicUpdate;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 控制点击背景是否收起键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    // 控制键盘上的工具条文字颜色是否用户自定义
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = YES;
    
    // 控制是否显示键盘上的工具条
    //     [IQKeyboardManager sharedManager].enableAutoToolbar = NO;

    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
     [NSThread sleepForTimeInterval:3];
    self.dicUpdate=[[NSDictionary alloc]init];
    [self VersionButton];
    LoadView *vic=[[LoadView alloc]init];
    UINavigationBar *bar = [UINavigationBar appearance];
    // bar.barTintColor = MAINCOLOR;
    bar.tintColor = [UIColor whiteColor];
    bar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    UINavigationController *nic=[[UINavigationController  alloc]initWithRootViewController:vic];
    [nic.navigationBar setBarTintColor:redRGB];
    self.window.rootViewController = nic;
    // Override point for customization after application launch.
    return YES;
}
-(void)VersionButton{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleVersion"];
    NSLog(@"版本号＝＝%@",appVersion);
    NSDictionary *dic=@{@"versionEntity":@{
        @"versionCode":appVersion,
        @"type":@"2"}};
    NSLog(@"%@",dic);
    AFHTTPRequestOperationManager*manager=[AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //申明请求的数据是json类型
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    //设置请求头
    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
    
    
    //发送请求
    [manager POST:cheaKappversion  parameters:dic  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"123%@",responseObject);
        NSDictionary *dic=[responseObject objectForKey:@"Result"];
        self.dicUpdate=[NSDictionary dictionaryWithDictionary:[dic objectForKey:@"versionEntity"]];
        if([[NSString stringWithFormat:@"%@",[self.dicUpdate  objectForKey:@"state"]] isEqualToString:@"1"]){
            UIAlertView *alear=[[UIAlertView alloc]initWithTitle:@"更新提示" message:[NSString stringWithFormat:@"新版本已发布"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"更新", nil];
            alear.delegate=self;
            [alear show];

        }
            
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
       // [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"网络出错"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
        
    }];
  


   
}

-(void)cheakAppUpdate:(NSString *)Appinfo{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleVersion"];
    NSLog(@"版本号＝＝%@",appVersion);
    if(![appVersion  isEqualToString:Appinfo]){
           }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
        NSLog(@"%@",[NSString stringWithFormat:@"%@",[self.dicUpdate objectForKey:@"downloadUrl"]]);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.dicUpdate objectForKey:@"downloadUrl"]]]];
  
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
