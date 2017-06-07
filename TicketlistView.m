//
//  TicketlistView.m
//  HYB
//
//  Created by CUIZE on 16/8/5.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "TicketlistView.h"
#import "MJRefresh.h"
#import "Head.h"
@interface TicketlistView ()<UIWebViewDelegate>
@property UIWebView *webView;
@property UIScrollView *scrollView;
@property NSString *strload;
@property NSURL *url;
@property  UIBarButtonItem *left;
@end

@implementation TicketlistView

- (void)viewDidLoad {
    self.title=@"已售";
    self.view.backgroundColor=[UIColor whiteColor];
    NSString *path=NSHomeDirectory();
    NSString * path2=[path stringByAppendingString:@"/Documents/"];
    NSString * path1=[path2 stringByAppendingString:@"/token.json"];
    NSArray *array=[[NSArray alloc]init];
    array=[NSArray arrayWithContentsOfFile:path1];
    
    NSLog(@"%@",array);
    self.strload=[NSString stringWithFormat:@"http://piaowu.hiyo.cc/%@/hyTicket/activity/hiyaoApp/tickets.html?openid=%@&userId=%@",OrderIP,[array.firstObject objectForKey:@"idCardNo"],[array.firstObject objectForKey:@"ID"]];
    NSLog(@"%@",self.strload);
    self.url = [NSURL URLWithString:self.strload];
    
    self.webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, w , h)];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
//    self.left=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(getback)];
//    
    UIScrollView *scrollView = self.webView.scrollView;
   // self.navigationItem.leftBarButtonItem=self.left;
    // 添加下拉刷新控件
    scrollView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.webView reload];
    }];
    scrollView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.webView reload];
    }];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)getback{
    [self dismissViewControllerAnimated:YES completion:nil];
    // [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)webViewDidFinishLoad:(nonnull UIWebView *)webView
{
    // NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    //    if(![currentURL isEqualToString:self.strload]){
    //        self.navigationItem.leftBarButtonItem=self.left;
    //
    //    }else{
    //        self.navigationItem.leftBarButtonItem=nil;
    //    }
    [self.webView.scrollView.mj_header endRefreshing];
    [self.webView.scrollView.mj_footer endRefreshing];
    
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
