//
//  WebViewController.m
//  HYBao
//
//  Created by CUIZE on 16/9/1.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "WebViewController.h"
#import "MJRefresh.h"
#import "Head.h"
@interface WebViewController ()<UIWebViewDelegate>
@property UIWebView *webView;
@property UIScrollView *scrollView;
@property NSString *strload;
@property NSURL *url;
@property  UIBarButtonItem *left;
@end

@implementation WebViewController

- (void)viewDidLoad {
    self.title=@"公告";
    self.view.backgroundColor=[UIColor whiteColor];
    self.strload=[NSString stringWithFormat:@"http://piaowu.hiyo.cc/%@/hyTicket/activity/hiyaoApp/notice.html",OrderIP];
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

    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)getback{
    [self.navigationController popViewControllerAnimated:YES];
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
