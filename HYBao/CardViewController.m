//
//  CardViewController.m
//  HYBao
//
//  Created by CUIZE on 16/9/7.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "CardViewController.h"
#import "Head.h"
#import "AFNetworking.h"
@interface CardViewController ()
@property (strong,nonatomic)UIBarButtonItem *left;
@property (strong,nonatomic)UIBarButtonItem *right;
@end

@implementation CardViewController
-(id)init{
    self=[super init];
    self.data=[[NSMutableDictionary  alloc]init];
    return self;
}
-(void)viewback{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
     self.left  =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"zhankaileft"] style:UIBarButtonItemStyleDone target:self action:@selector(viewback)];
    
    self.navigationItem.leftBarButtonItem=self.left;
self.title=@"我的银行卡";
    self.view.backgroundColor= garyRGB;
    self.WXbtn=[[CardButton alloc]initWithFrame:CGRectMake(5, 69, w-10, h*0.2)];
    self.WXbtn.layer.cornerRadius=6;
    self.WXbtn.backgroundColor= redRGB;
    self.WXbtn.name.text=[NSString stringWithFormat:@"%@",[self.data objectForKey:@"openBank"]];
    self.WXbtn.detail.text=[NSString stringWithFormat:@"%@",[self.data objectForKey:@"openBankAddress"]];
   self.WXbtn.pic1.image=[UIImage imageNamed:@"bank.png"];
    self.WXbtn. number.text= [NSString stringWithFormat:@"**** **** **** %@", [[NSString stringWithFormat:@"%@",[self.data objectForKey:@"bankCardNo"]] substringFromIndex:[NSString stringWithFormat:@"%@",[self.data objectForKey:@"bankCardNo"]].length-4] ];
    self.WXbtn.tag=1;
    [self.WXbtn addTarget:self action:@selector(getCardInfo:) forControlEvents:UIControlEventTouchUpInside];
    if([[NSString stringWithFormat:@"%@", [self.data objectForKey:@"state" ]] isEqualToString:@"2"]){
        self.WXbtn.tag=8;
    }
    [self.view addSubview:self.WXbtn];
    
    
    self.ALIPYbtn=[[CardButton alloc]initWithFrame:CGRectMake(5, 79+h*0.2, w-10, h*0.2)];
    self.ALIPYbtn.layer.cornerRadius=6;
    self.ALIPYbtn.name.text=@"支付宝账号";
    self.ALIPYbtn.tag=2;
    [self.ALIPYbtn addTarget:self action:@selector(getCardInfo:) forControlEvents:UIControlEventTouchUpInside];
    self.ALIPYbtn.backgroundColor=[UIColor colorWithRed:67/255.0 green:139/255.0 blue:231/255.0 alpha:1];
     self.ALIPYbtn.pic1.image=[UIImage imageNamed:@"pay.png"];
    [self.view addSubview:self.ALIPYbtn];
    [super viewDidLoad];
    if([[NSString stringWithFormat:@"%@",[self.data objectForKey:@"alipayAccount"]] isEqualToString:@""]){
        self.ALIPYbtn.number.text=@"点击添加支付宝";
    
    }else{
        self.ALIPYbtn.number.text=[NSString stringWithFormat:@"%@",[self.data objectForKey:@"alipayAccount"]];
    }
    self.viewDetail=[[UIView alloc]initWithFrame:CGRectMake(2, 69, w-4 , 0.4*h+30)];
    self.viewDetail.backgroundColor= garyRGB;
    self.viewDetail.layer.cornerRadius=10;
    
    
    //self.labName=[[UILabel alloc]initWithFrame:CGRectMake(0, self.viewDetail.frame.size.height*0.35, self.viewDetail.frame.size.width*0.3, self.viewDetail.frame.size.height*0.15)];
   
    //self.labName.textAlignment=NSTextAlignmentRight;
   // [self.viewDetail addSubview:self.labName];
    self.name=[[LYTextField alloc]initWithFrame:CGRectMake(self.viewDetail.frame.size.width*0.2,  self.viewDetail.frame.size.height*0.35, self.viewDetail.frame.size.width*0.6, self.viewDetail.frame.size.height*0.15)];
    self.name.lineView.backgroundColor=backRGB;
    self.name.textField.textColor=backRGB;
    [self.name.textField setTintColor:backRGB];
    [self.viewDetail addSubview:self.name];
    //self.textName=[[UITextField alloc]initWithFrame:CGRectMake(self.viewDetail.frame.size.width*0.3, self.viewDetail.frame.size.height*0.35, self.viewDetail.frame.size.width*0.7, self.viewDetail.frame.size.height*0.15)];
   // self.textName.borderStyle=UITextBorderStyleLine;
    //[self.viewDetail addSubview:self.textName];
   // self.labNumber=[[UILabel alloc]initWithFrame:CGRectMake(0, self.viewDetail.frame.size.height*0.55, self.viewDetail.frame.size.width*0.3, self.viewDetail.frame.size.height*0.15)];
       // self.labNumber.textAlignment=NSTextAlignmentRight;
    self.number=[[LYTextField alloc]initWithFrame:CGRectMake(self.viewDetail.frame.size.width*0.2, self.viewDetail.frame.size.height*0.55, self.viewDetail.frame.size.width*0.6, self.viewDetail.frame.size.height*0.15)];
    self.number.textField.textColor=backRGB;
    [self.number.textField setTintColor:backRGB];
    self.number.lineView.backgroundColor=backRGB;
    [self.viewDetail addSubview:self.number];
  //  self.textNumber=[[UITextField alloc]initWithFrame:CGRectMake(self.viewDetail.frame.size.width*0.3, self.viewDetail.frame.size.height*0.55, self.viewDetail.frame.size.width*0.7, self.viewDetail.frame.size.height*0.15)];
  
    //self.textNumber.borderStyle=UITextBorderStyleLine;
//    self.name=[[LYTextField alloc]initWithFrame:CGRectMake(0, 10, self.viewDetail.frame.size.width-10,  self.viewDetail.frame.size.height*0.15)];
//    [self.viewDetail addSubview:self.name];
  //  [self.viewDetail addSubview:self.textNumber];
   // [self.viewDetail addSubview:self.labNumber];
    
         self.viewDetail.alpha=0;
    [self.view addSubview:self.viewDetail];
    
}
-(void)pushInfobank{
    if([self.number.textField.text isEqualToString:@""]||[self.name.textField.text isEqualToString:@""]){
          [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"请检查信息是否完整"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
    }else{
        AFHTTPRequestOperationManager*manager=[AFHTTPRequestOperationManager manager];
        //申明返回的结果是json类型
        manager.requestSerializer=[AFJSONRequestSerializer serializer];
        //申明请求的数据是json类型
        manager.responseSerializer=[AFJSONResponseSerializer serializer];
        //设置请求头
        NSString *path=NSHomeDirectory();
        NSString * path2=[path stringByAppendingString:@"/Documents/"];
        NSString * path1=[path2 stringByAppendingString:@"/token.json"];
        NSArray *array=[[NSArray alloc]init];
        array=[NSArray arrayWithContentsOfFile:path1];
        [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
        
        NSDictionary *parameters = @{
                                     @"AccountEntity":@{
                                             @"token":[NSString stringWithFormat:@"%@", [array.lastObject objectForKey:@"token"]],
                                             @"bankCardNo":self.number.textField.text,
                                             @"openBankAddress": self.name.textField.text
                                             
                                             }
                                     };//发送请求
        NSLog(@"===%@",parameters);
        [manager POST:changeCard parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dic=[responseObject objectForKey:@"Result"];
            
            if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"errorCode"]] isEqualToString:@"-1"]){
                [[[UIAlertView alloc]initWithTitle:@"提示信息" message:[NSString stringWithFormat:@"%@",[dic objectForKey:@"errorMessage"]]  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
            }else{
                
                NSLog(@"%@",dic);
                self.WXbtn.name.text=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"accountBank"]objectForKey:@"openBank"]];
                self.WXbtn.detail.text=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"accountBank"] objectForKey:@"openBankAddress"]];
                self.WXbtn.pic1.image=[UIImage imageNamed:@"bank.png"];
                self.WXbtn. number.text= [NSString stringWithFormat:@"**** **** **** %@", [[NSString stringWithFormat:@"%@",[[dic objectForKey:@"accountBank"]objectForKey:@"bankCardNo"]] substringFromIndex:[NSString stringWithFormat:@"%@",[[dic objectForKey:@"accountBank"]  objectForKey:@"bankCardNo"]].length-4] ];
                self.navigationItem.rightBarButtonItem=nil;
                 self.title=@"支付宝账号";
                self.viewDetail.alpha=0;
                self.name.textField.text=@"";
                self.number.textField.text=@"";
               // self.labNumber.alpha=1;
                self.number.alpha=1;
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"Error: %@", error);
            
            [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"网络异常,请稍后重试"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
            
        }];
        
        
    }
 
}
-(void)pushInfoalipay{
    if([self.name.textField.text isEqualToString:@""]){
        
        [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"请输入账号"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
        
        
    }else{
        AFHTTPRequestOperationManager*manager=[AFHTTPRequestOperationManager manager];
        //申明返回的结果是json类型
        manager.requestSerializer=[AFJSONRequestSerializer serializer];
        //申明请求的数据是json类型
        manager.responseSerializer=[AFJSONResponseSerializer serializer];
        //设置请求头
        NSString *path=NSHomeDirectory();
        NSString * path2=[path stringByAppendingString:@"/Documents/"];
        NSString * path1=[path2 stringByAppendingString:@"/token.json"];
        NSArray *array=[[NSArray alloc]init];
        array=[NSArray arrayWithContentsOfFile:path1];
        [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
        
        NSDictionary *parameters = @{
                                     @"AccountEntity":@{
                                             @"token":[NSString stringWithFormat:@"%@", [array.lastObject objectForKey:@"token"]],
                                             @"alipayAccount":self.name.textField.text
                                             
                                             }};//发送请求
        
        [manager POST:changeCard   parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dic=[responseObject objectForKey:@"Result"];
               
            if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"errorCode"]] isEqualToString:@"-1"]){
                [[[UIAlertView alloc]initWithTitle:@"提示信息" message:[NSString stringWithFormat:@"%@",[dic objectForKey:@"errorMessage"]]  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
            }else{
                
                NSLog(@"%@",dic);
                self.ALIPYbtn.number.text=[NSString stringWithFormat:@"%@",[[dic objectForKey:@"accountBank"]objectForKey:@"alipayAccount"]];
                self.navigationItem.rightBarButtonItem=nil;
                self.navigationItem.leftBarButtonItem=self.left;
                 self.title=@"支付宝账号";
                self.viewDetail.alpha=0;
                self.name.textField.text=@"";
                self.number.textField.text=@"";
                //self.labNumber.alpha=1;
                self.number.alpha=1;
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"Error: %@", error);
            
            [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"网络出错"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
            
        }];
        
        
    }

}
-(void)backView{
    [UIView animateWithDuration:0.3 animations:^{
         self.title=@"我的银行卡";
        self.navigationItem.rightBarButtonItem=nil;
        self.viewDetail.alpha=0;
        self.name.textField .text=@"";
        self.number.textField.text=@"";
        //self.labNumber.alpha=1;
        self.navigationItem.leftBarButtonItem=self.left;
        self.number.alpha=1;
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getCardInfo :(UIButton *)sender{
    self.navigationItem.leftBarButtonItem=nil;
    UIBarButtonItem * left  =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"zhankaileft"] style:UIBarButtonItemStyleDone target:self action:@selector(backView)];
    self.navigationItem.leftBarButtonItem=left;
    if(sender.tag==1){
        [UIView animateWithDuration:0.3 animations:^{
            
self.right=[[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(pushInfobank)];
            self.navigationItem.rightBarButtonItem=self.right;
           self.title=@"银行卡";
          self.name.textField.placeholder=@"开 户 行";
            // self.labName.text=@"开 户 行:";
            self.number.textField.placeholder  =@"银行卡号";

            self.viewDetail.alpha=1;
            
            
            
            
        }];
        
        
        
    }else if(sender.tag==2){
        [UIView animateWithDuration:0.3 animations:^{
        
            self.title=@"支付宝账号";
        self.name.textField.placeholder=@"支付宝账号";
           // self.labName.text=@"支付宝账号:";
           
            
            self.right=[[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(pushInfoalipay)];
            self.navigationItem.rightBarButtonItem=self.right;
            
            
            //self.labNumber.alpha=0;
            self.number.alpha=0;
            self.viewDetail.alpha=1;
        }];

    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event  {
    [self.view endEditing:YES];
}
@end
