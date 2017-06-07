//
//  BuyticketWebViewController.m
//  HYBao
//
//  Created by CUIZE on 16/9/8.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "BuyticketWebViewController.h"
#import "MJRefresh.h"
#import "Head.h"
@interface BuyticketWebViewController ()<UIWebViewDelegate>
@property UIWebView *webView;
@property UIScrollView *scrollView;
@property NSString *strload;
@property NSURL *url;
@property  UIBarButtonItem *left;

@end

@implementation BuyticketWebViewController
-(id)init{
    self=[super init];
    self.strID=[[NSString alloc]init];
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    if([self.strID isEqualToString:@"1"]){
    self.title=@"购票须知";
        self.strload=[NSString stringWithFormat:@"%@",@"http://piaowu.hiyo.cc/wxtest/hyTicket/activity/protocol/notice.html"];}else{
            self.title=@"通用协议";
            self.strload=[NSString  stringWithFormat:@"%@",@"http://piaowu.hiyo.cc/wxtest/hyTicket/activity/protocol/protocol.html"];
        }
    self.url = [NSURL URLWithString:self.strload];
    
    self.webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, w , h)];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
     self.left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"zhankaileft"] style:UIBarButtonItemStyleDone target:self action:@selector(getback)];
    UIScrollView *scrollView = self.webView.scrollView;
    self.navigationItem.leftBarButtonItem=self.left;
    // 添加下拉刷新控件
    scrollView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.webView reload];
    }];
    scrollView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.webView reload];
    }];

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
@end
