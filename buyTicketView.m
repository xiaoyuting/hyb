//
//  buyTicketView.m
//  HYB
//
//  Created by CUIZE on 16/8/22.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "buyTicketView.h"
#import "AFNetworking.h"
#import "SMProgressHUD.h"
#import "agreementButton.h"
#import "BuyticketWebViewController.h"

@interface buyTicketView ()

@end

@implementation buyTicketView
@synthesize addPrice,reducePrice;
-(id)init{
    if(self){
        self=[super init];
    }
    self.dic=[[NSMutableDictionary alloc]init];
    self.strData=[[NSString alloc]init];
    return self;
}
-(void)viewback{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    

    self.nowPrice=[[NSString alloc]init];
    self.strPaystyle=@"2";
    //NSLog(@"%@",self.dic);
      self.scr=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, w, h-124)];
    [self.view addSubview:self.scr];
  
    self.scr.contentSize=CGSizeMake(w ,0.6*w+5+0.47*h-50+0.2*h+5);
 
       self.priceCount=1;
    self.ticketPriceCount=1;
   
    
    if([self.strData isEqualToString:@"1"]){
        NSDate *  senddate=[NSDate date];
        
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        
        [dateformatter setDateFormat:@"YYYY-MM-dd 今日"];
        
        self.locationString=[dateformatter stringFromDate:senddate];
        
        NSLog(@"locationString:%@",self.locationString);
    }else {
        NSTimeInterval secondsPerDay = 24 * 60 * 60;
        
        //明天时间
        NSDate *tomorrow = [[NSDate alloc] initWithTimeIntervalSinceNow:secondsPerDay];
        //self.strPaystyle=[[NSString alloc]init];
        NSDateFormatter  *date =[[NSDateFormatter alloc] init];
        
        [date setDateFormat:@"YYYY-MM-dd 明日"];
        self.locationString=[date stringFromDate:tomorrow];
        NSLog(@"[date stringFromDate:tomorrow]:%@",[date stringFromDate:tomorrow]);
    }
    
    


   //NSLog(@"%@",self.dic);
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(viewback)];
    self.navigationItem.leftBarButtonItem=left;
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=[self.dic objectForKey:@"productName"];
    self.image=[[UIImageView alloc]initWithFrame:CGRectMake(0, -64, w , 0.6*w )];
    [self.scr addSubview:self.image];
    [super viewDidLoad];
    
    [self show];
    NSURL * url2= [NSURL URLWithString:[NSString stringWithFormat:@"%@", [self.dic objectForKey:@"mainPic"]]];
    [self.image   sd_setImageWithURL:url2 placeholderImage:[UIImage imageNamed:@"user_head.png"]];

    self.backView=[[UIView alloc]initWithFrame:CGRectMake(0, -64, w , h-0.159*h)];
    self.backView.backgroundColor=[UIColor whiteColor];
    self.backView.backgroundColor=[ [UIColor grayColor] colorWithAlphaComponent:0.5];
    [self.scr addSubview:self.backView];
        [self pushcheakerview];
    // Do any additional setup after loading the view.
}
//弹出验证码页面
-(void)pushcheakerview{
    
    self.viewcheak =[[UIView alloc]initWithFrame:CGRectMake(0.1*w , 0.4*h, 0.8*w, 0.4*h)];
    self.viewcheak.backgroundColor=[UIColor whiteColor];
    self.viewcheak.alpha=1;
    self.agreelabdetail=[[UILabel alloc]init ];
    self. agreelabdetail.numberOfLines=0;
    self.agreelabdetail.font=[UIFont systemFontOfSize:14];
    self.agreelabdetail.text=@"尊敬的游客您好。我们已将<购票须知>的相关条款发送到您的手机，请您注意查看确认后并且在60秒内您收到的验证码提交";
    CGSize textSize=[self.agreelabdetail.text boundingRectWithSize:CGSizeMake(w-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    CGFloat textH=textSize.height;
    self.agreelabdetail.frame=CGRectMake(20, 20, 0.8*w-40, textH+20);
    
    [self.viewcheak addSubview:self.agreelabdetail];
  
    self.cheakNumber=[[UITextField alloc]initWithFrame:CGRectMake(20, textH+40+(0.4*h-textH-40)/7.0, (0.8*w-40)*0.7, 30)];
    self.cheakNumber.placeholder =@"请输入验证码";
    self.cheakNumber.keyboardType=UIKeyboardTypeNumberPad;
         self.viewbtncheak.backgroundColor=redRGB;
   
    self.btnPushticket=[[UIButton alloc]initWithFrame:CGRectMake(20, textH+40+(0.4*h-textH-40)*3/7.0, (0.8*w-40)/2.0-10, 30 )];
    [self.btnPushticket setTitle:@"确认" forState:UIControlStateNormal];
    [self.btnPushticket addTarget:self action:@selector(btnPushinfo) forControlEvents:UIControlEventTouchUpInside];
    self.btnPushticket.backgroundColor=redRGB;
    [self.viewcheak addSubview:self.btnPushticket];
    self.btnBack=[[UIButton alloc]initWithFrame:CGRectMake((0.8*w-40)/2.0+30, textH+40+(0.4*h-textH-40)*3/7.0, (0.8*w-40)/2.0-10,  30 )];
    [self.btnBack setTitle:@"返回" forState:UIControlStateNormal];
    [self.btnBack addTarget:self action:@selector(getback) forControlEvents:UIControlEventTouchUpInside];
    self.btnBack.backgroundColor=redRGB;
    [self.viewcheak addSubview:self.btnBack];
    self.cheakNumber.borderStyle=UIButtonTypeRoundedRect;
    [self.viewcheak addSubview:self.cheakNumber];
    [self.backView addSubview:self.viewcheak];
    self.backView.alpha=0;
   // self.viewcheak.hidden=YES;
}
//商业计算
NSString *decimalNumberMutiplyWithString(NSString *multiplierValue,NSString *multiplicandValue)
{
    NSDecimalNumber *multiplierNumber = [NSDecimalNumber decimalNumberWithString:multiplierValue];
    NSDecimalNumber *multiplicandNumber = [NSDecimalNumber decimalNumberWithString:multiplicandValue];
    NSDecimalNumber *product = [multiplicandNumber decimalNumberByMultiplyingBy:multiplierNumber];
    return [product stringValue];
}

//变换价格
-(void)priceChange :(UIButton *)sender{
   
    NSArray *arr=[self.ticketPrice.text componentsSeparatedByString:@"¥"];
        if(sender.tag==0){
          if([[NSString stringWithFormat:@"%@", arr.lastObject ] floatValue] >=[[NSString stringWithFormat:@"%f", ([self.maxPrice floatValue]-[self.rulesPrice floatValue])] floatValue]){
              
              
              NSDecimalNumber *numberA=[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@", self.maxPrice]];//价格
              NSDecimalNumber *numberB=[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",self.count.text]];//数量
              //NSLog(@"count==%@",self.count.text);
             // NSDecimalNumber *numberC=[NSDecimalNumber decimalNumberWithString:self.rulesPrice];//规则
              //A+B
             // NSDecimalNumber *resultANumber=[numberC decimalNumberByAdding:numberA];//改后的价格
             //NSLog(@"resultANumber===%@",resultANumber);
              //A*B
              NSDecimalNumber *resultCNumber=[numberA decimalNumberByMultiplyingBy:numberB];//总价格
              
              //A/B
              // NSDecimalNumber *resultBNumber=[numberA decimalNumberByDividingBy:numberB]; //（B不能为0）
              //A-B
              // NSDecimalNumber *resulteFNumber=[numberA decimalNumberBySubtracting:numberB];
              self.ticketPrice.text=[NSString stringWithFormat:@"¥%@",numberA];
              self.amount.text=[NSString stringWithFormat:@"订单总额:¥%@",resultCNumber ];
              self.nowPrice=[NSString stringWithFormat:@"%@",numberA ];
              
             // NSLog(@"%@=%@=%@",self.amount.text,self.nowPrice,self.count.text);

            
        }else{
         
            
            NSDecimalNumber *numberA=[NSDecimalNumber decimalNumberWithString:arr.lastObject];//价格
            NSDecimalNumber *numberB=[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",self.count.text]];//数量
            NSLog(@"count==%@",self.count.text);
            NSDecimalNumber *numberC=[NSDecimalNumber decimalNumberWithString:self.rulesPrice];//规则
            //A+B
            NSDecimalNumber *resultANumber=[numberC decimalNumberByAdding:numberA];//改后的价格
            NSLog(@"resultANumber===%@",resultANumber);
            //A*B
            NSDecimalNumber *resultCNumber=[resultANumber decimalNumberByMultiplyingBy:numberB];//总价格
           
            //A/B
           // NSDecimalNumber *resultBNumber=[numberA decimalNumberByDividingBy:numberB]; //（B不能为0）
            //A-B
           // NSDecimalNumber *resulteFNumber=[numberA decimalNumberBySubtracting:numberB];
        self.ticketPrice.text=[NSString stringWithFormat:@"¥%@",resultANumber];
        self.amount.text=[NSString stringWithFormat:@"订单总额:¥%@",resultCNumber ];
          self.nowPrice=[NSString stringWithFormat:@"%@",resultANumber ];
        
           // NSLog(@"%@=%@=%@",self.amount.text,self.nowPrice,self.count.text);
        }

    }else if(sender.tag==1){
     
        if([[NSString stringWithFormat:@"%@", arr.lastObject ] floatValue] <=[[NSString stringWithFormat:@"%f", ([self.miniPrice floatValue]+[self.rulesPrice floatValue])] floatValue]){
            NSDecimalNumber *numberA=[NSDecimalNumber decimalNumberWithString:self.miniPrice];//价格
            NSDecimalNumber *numberB=[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",self.count.text]];//数量
           // NSLog(@"count==%@",self.count.text);
           // NSDecimalNumber *numberC=[NSDecimalNumber decimalNumberWithString:self.rulesPrice];//规则
            //A-B
           // NSDecimalNumber *resultANumber=[numberA decimalNumberBySubtracting:numberC];//改后的价格
           // NSLog(@"resultANumber===%@",resultANumber);
            //A*B
            NSDecimalNumber *resultCNumber=[numberA decimalNumberByMultiplyingBy:numberB];//总价格
            
            //A/B
            // NSDecimalNumber *resultBNumber=[numberA decimalNumberByDividingBy:numberB]; //（B不能为0）
            //A-B
            // NSDecimalNumber *resulteFNumber=[numberA decimalNumberBySubtracting:numberB];
            self.ticketPrice.text=[NSString stringWithFormat:@"¥%@",numberA];
            self.amount.text=[NSString stringWithFormat:@"订单总额:¥%@",resultCNumber ];
            self.nowPrice=[NSString stringWithFormat:@"%@",numberA];
            
           // NSLog(@"%@=%@=%@",self.amount.text,self.nowPrice,self.count.text);

        }else{
      
            
            NSDecimalNumber *numberA=[NSDecimalNumber decimalNumberWithString:arr.lastObject];//价格
            NSDecimalNumber *numberB=[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",self.count.text]];//数量
           // NSLog(@"count==%@",self.count.text);
            NSDecimalNumber *numberC=[NSDecimalNumber decimalNumberWithString:self.rulesPrice];//规则
            //A+B
            NSDecimalNumber *resultANumber=[numberA decimalNumberBySubtracting:numberC];//改后的价格
            //NSLog(@"resultANumber===%@",resultANumber);
            //A*B
            NSDecimalNumber *resultCNumber=[resultANumber decimalNumberByMultiplyingBy:numberB];//总价格
            
            //A/B
            // NSDecimalNumber *resultBNumber=[numberA decimalNumberByDividingBy:numberB]; //（B不能为0）
            //A-B
            // NSDecimalNumber *resulteFNumber=[numberA decimalNumberBySubtracting:numberB];
            self.ticketPrice.text=[NSString stringWithFormat:@"¥%@",resultANumber];
            self.amount.text=[NSString stringWithFormat:@"订单总额:¥%@",resultCNumber ];
            self.nowPrice=[NSString stringWithFormat:@"%@",resultANumber ];
            
          //  NSLog(@"%@=%@=%@",self.amount.text,self.nowPrice,self.count.text);

    }
    }
 }
-(void)getcount :(UIButton *)sender{
    NSArray *arr=[self.ticketPrice.text componentsSeparatedByString:@"¥"];
    if(sender.tag==1){
        if(self.priceCount==1){
            NSDecimalNumber *numberA=[NSDecimalNumber decimalNumberWithString:arr.lastObject];
            NSDecimalNumber *numberB=[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",self.priceCount]];
                       //A*B
            NSDecimalNumber *resultCNumber=[numberA decimalNumberByMultiplyingBy:numberB];
//-----------------------------------------------------------------------------
        
            self.amount.text=[NSString stringWithFormat:@"订单总额:¥%@", resultCNumber];
            
            self.count.text=[NSString stringWithFormat:@"%d",self.priceCount];
        }else{
            self.priceCount--;
            NSDecimalNumber *numberA=[NSDecimalNumber decimalNumberWithString:arr.lastObject];
            NSDecimalNumber *numberB=[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",self.priceCount]];
            //A*B
            NSDecimalNumber *resultCNumber=[numberA decimalNumberByMultiplyingBy:numberB];
            //-----------------------------------------------------------------------------
            
            self.amount.text=[NSString stringWithFormat:@"订单总额:¥%@", resultCNumber];
            
            self.count.text=[NSString stringWithFormat:@"%d",self.priceCount];        }
    }
    if(sender.tag==2){
        self.priceCount++;
        NSDecimalNumber *numberA=[NSDecimalNumber decimalNumberWithString:arr.lastObject];
        NSDecimalNumber *numberB=[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",self.priceCount]];
        //A*B
        NSDecimalNumber *resultCNumber=[numberA decimalNumberByMultiplyingBy:numberB];
        //-----------------------------------------------------------------------------
        
        self.amount.text=[NSString stringWithFormat:@"订单总额:¥%@", resultCNumber];
        
        self.count.text=[NSString stringWithFormat:@"%d",self.priceCount];

        
    }
}
//下单按钮
-(void)getPriceBtn{
    

    if(self.addPrice.alpha==0){
        NSDictionary *json = @{
                               @"productTicketRulesEntity":@{
                                       @"productId":[NSString stringWithFormat:@"%@" ,
                                                     [self.dic objectForKey:@"id"]]
                                       }
                               };
        
        AFHTTPRequestOperationManager*manager=[AFHTTPRequestOperationManager manager];
        //申明返回的结果是json类型
        manager.requestSerializer=[AFJSONRequestSerializer serializer];
        //申明请求的数据是json类型
        manager.responseSerializer=[AFJSONResponseSerializer serializer];
        //设置请求头
        [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
        
        
        //发送请求
        [manager POST:@"http://139.196.11.133:9090/ponline/service/rest/shopproduct/getrules.json" parameters:json success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dic=[responseObject objectForKey:@"entity"];
           // NSLog(@"dic===%@",responseObject );
            
            self.maxPrice=[NSString  stringWithFormat:@"%@",[dic objectForKey:@"highestPrice"]];
            self.miniPrice=[NSString stringWithFormat:@"%@",[dic objectForKey:@"minimumPrice"]];
            self.rulesPrice=[NSString stringWithFormat:@"%@",[dic objectForKey:@"rules"]];
           // NSLog(@"%@%@%@",self.maxPrice,self.miniPrice,self.rulesPrice);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"Error: %@", error);
            [UIView animateWithDuration:0.3 animations:^{
                self.addPrice.alpha=0;
                self.reducePrice.alpha=0;
            }];

            [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"网络异常,请稍后重试"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
            
        }];
        

        [UIView animateWithDuration:0.3 animations:^{
            self.addPrice.alpha=1;
            self.reducePrice.alpha=1;
        }];
    }else if(self.addPrice.alpha==1){
        [UIView animateWithDuration:0.3 animations:^{
            self.addPrice.alpha=0;
            self.reducePrice.alpha=0;
        }];

    }
}
//页面显示
-(void)show{
    self.ticketDetail=[[UILabel alloc]initWithFrame:CGRectMake(35, 0.6*w+5-64, w*0.2, h*0.05)];
    UIImageView *pic1=[[UIImageView alloc]initWithFrame:CGRectMake(15, 0.6*w+5-64+0.0125*h, h*0.025,h*0.025)];
    pic1.image=[UIImage imageNamed:@"q1.png"];
    [self.scr addSubview:pic1];
    self.ticketDetail.text=@"门票详情";
    self.ticketDetail.textColor=redRGB;
    self.ticketDetail.font=[UIFont systemFontOfSize:12];
    [self.scr addSubview:self.ticketDetail];
    addPrice=[[UIButton alloc]initWithFrame:CGRectMake(0.9*w , 0.6*w+5-64+0.02*h, 0.1*w, h*0.06)];
    [addPrice   setTitle:@"+" forState:UIControlStateNormal];
    addPrice.backgroundColor=redRGB;
    addPrice.tag=0;
    addPrice.alpha=0;
    [addPrice addTarget:self action:@selector(priceChange:) forControlEvents:UIControlEventTouchUpInside];
    [self.scr addSubview:addPrice];
    reducePrice=[[UIButton alloc]initWithFrame:CGRectMake(0.65*w , 0.6*w+5-64+0.02*h, 0.1*w, h*0.06)];
    [reducePrice   setTitle:@"-" forState:UIControlStateNormal];
    reducePrice.backgroundColor=redRGB;
    reducePrice.tag=1;
    reducePrice.alpha=0;
    [reducePrice addTarget:self action:@selector(priceChange:) forControlEvents:UIControlEventTouchUpInside];
    [self.scr addSubview:reducePrice];

    self.ticketPrice=[[UILabel alloc]initWithFrame:CGRectMake(0.75*w, 0.6*w+5-64, 0.15*w , h*0.1)];
    self.ticketPrice.text=[NSString stringWithFormat:@"¥%@",[self.dic objectForKey:@"salesPrice"]];
    self.nowPrice=[NSString stringWithFormat:@"%@",[self.dic objectForKey:@"salesPrice"]];
    self.ticketPrice.adjustsFontSizeToFitWidth=YES;
    self.ticketPrice.textAlignment=NSTextAlignmentCenter;
    self.ticketPrice.textColor=redRGB;
    if([[NSString stringWithFormat:@"%@" ,
         [self.dic objectForKey:@"isChangePrice"] ] isEqualToString:@"1"]){
           self.ticketPrice.userInteractionEnabled=YES;
    }

    UIButton *btnPrice=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0.15*w, 0.1*h)];
    [btnPrice addTarget:self action:@selector(getPriceBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.ticketPrice addSubview:btnPrice];
    UIImageView *line1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0.6*w+5+0.1*h-64, w, 1)];
    line1.backgroundColor=[UIColor lightGrayColor];
    [self.scr addSubview:line1];
    self.ticketName =[[UILabel alloc]initWithFrame:CGRectMake(15, 0.6*w+5+0.05*h-64, w-15, h*0.05)];
  
    self.ticketName.text=[NSString stringWithFormat:@"%@",[self.dic objectForKey:@"productName"]];
    self.ticketName.font=[UIFont systemFontOfSize:14];
    [self.scr addSubview:self.ticketName];
    [self.scr addSubview:self.ticketPrice];
    self.ticketDate=[[UILabel alloc]initWithFrame:CGRectMake(35, 0.6*w+5+0.1*h-64, w*0.2, h*0.1)];
    UIImageView *pic2=[[UIImageView alloc]initWithFrame:CGRectMake(15, 0.6*w+5+0.1*h-64+0.0375*h, h*0.025,h*0.025)];
    pic2.image=[UIImage imageNamed:@"q2.png"];
    [self.scr addSubview:pic2];
    self.ticketDate.text=@"游玩日期";
    self.ticketDate.textColor=redRGB;
    self.ticketDate.font=[UIFont systemFontOfSize:12];
    [self.scr addSubview:self.ticketDate];
    UIImageView *line2=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0.6*w+5+0.2*h-64, w, 1)];
    line2.backgroundColor=[UIColor lightGrayColor];
    [self.scr addSubview:line2];
    self.dateBtn=[[SXButton alloc]initWithFrame:CGRectMake(0.3*w, 0.6*w+5+0.1*h-64, 0.7*w , h*0.1)];
    [self.dateBtn setImage:[UIImage imageNamed:@"sold_down@2x.png"] forState:UIControlStateNormal];
    [self.dateBtn setTitle:self.locationString forState:UIControlStateNormal];
    [self.dateBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.scr addSubview:self.dateBtn];
    if([self.strData isEqualToString:@"1"]){
        self.dateBtn.enabled=NO;
    }

    [self.dateBtn addTarget:self action:@selector(getdate ) forControlEvents:UIControlEventTouchUpInside];
    self.ticketNumber=[[UILabel alloc]initWithFrame:CGRectMake(35, 0.6*w+5+0.2*h-55, w*0.2, h*0.05)];
    self.ticketNumber.text=@"购票数量";
    UIImageView *pic3=[[UIImageView alloc]initWithFrame:CGRectMake(15, 0.6*w+5+0.2*h-55+0.0125*h, h*0.025,h*0.025)];
    pic3.image=[UIImage imageNamed:@"q3.png"];
    [self.scr addSubview:pic3];
    UILabel *labTishi=[[UILabel alloc]initWithFrame:CGRectMake(15, 0.6*w+5+0.205*h-55+h*0.04+0.0025*h, w-15, h*0.025)];
    labTishi.text=@"*购票完成后,请凭二维码和证件如园(无证件者该票视为无效)";
    labTishi.adjustsFontSizeToFitWidth =YES;
    labTishi.textColor=redRGB;
    labTishi.alpha=0;
    [self.scr addSubview:labTishi];
    if([[NSString stringWithFormat:@"%@", [self.dic  objectForKey:@"personTicketType"]] isEqualToString:@"3"]){
        labTishi.alpha=1;
    }
    self.ticketNumber.textColor=redRGB;
    
    self.ticketNumber.font=[UIFont systemFontOfSize:12];
    [self.scr addSubview:self.ticketNumber];
    UIImageView *labline=[[UIImageView alloc]initWithFrame:CGRectMake( 0, 0.6*w+5+0.205*h-55+h*0.04+h*0.025+0.0125*h, w , 0.01*h)];
    labline.backgroundColor=garyRGB;
    [self.scr addSubview:labline];
    self.btnreduce=[[UIButton alloc]initWithFrame:CGRectMake(w-h*0.14-25 , 0.6*w+5+0.205*h-55, 0.04*h+5 , h*0.04)];
    [self.btnreduce  setTitle:@"-" forState:UIControlStateNormal];
    self.btnreduce.tag=1;
    self.btnreduce.backgroundColor=redRGB;
    [self.scr addSubview:self.btnreduce];
    [self.btnreduce addTarget:self action:@selector(getcount:) forControlEvents:UIControlEventTouchUpInside];
    self.count=[[UILabel alloc]initWithFrame:CGRectMake(w-h*0.1-20 , 0.6*w+5+0.205*h-55, 0.06*h , h*0.04)];
    self.count.text=[NSString stringWithFormat:@"%d",self.priceCount];
    [ self.count.layer setBorderWidth:0.5];
    [ self.count.layer setBorderColor:[UIColor grayColor].CGColor];  //设置边框为白色
    self.count.adjustsFontSizeToFitWidth=YES;
    self.count.textColor=redRGB;
    self.count.textAlignment=NSTextAlignmentCenter;
    [self.scr addSubview:self.count];
    self.btnadd=[[UIButton alloc]initWithFrame:CGRectMake(w-h*0.04-20 , 0.6*w+5+0.205*h-55, 0.04*h+5, h*0.04)];
    [self.btnadd  setTitle:@"+" forState:UIControlStateNormal];
    self.btnadd.tag=2;
    [self.btnadd addTarget:self action:@selector(getcount:) forControlEvents:UIControlEventTouchUpInside];

    self.btnadd.backgroundColor=redRGB;
    [self.scr addSubview:self.btnadd];
    self.amount=[[UILabel alloc]initWithFrame:CGRectMake(0, h-40, 0.5*w, 40)];
    float price=  [[self.dic objectForKey:@"salesPrice"] floatValue]*self.priceCount;
     NSDecimalNumber *numberA=[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",  price]];//价格
    self.amount.text=[NSString stringWithFormat:@"订单总额:¥%@",numberA];
    
    [ self.amount.layer setBorderWidth:0.5];
  [ self.amount.layer setBorderColor:[UIColor grayColor].CGColor];  //设置边框为白色
    self.amount.textColor=redRGB;
    self.amount.textAlignment=NSTextAlignmentCenter;
    self.amount.adjustsFontSizeToFitWidth=YES;
    [self.view addSubview:self.amount];
    self.personlab=[[UILabel alloc]initWithFrame:CGRectMake(15, 0.6*w+5+0.3*h-55, 0.2*w, 0.05*h)];
    self.personlab.text=@"游客姓名";
    self.personlab .adjustsFontSizeToFitWidth=YES;
   self.personlab.textAlignment=NSTextAlignmentCenter;
    [self.scr addSubview:self.personlab];
    self.phonelab=[[UILabel alloc]initWithFrame:CGRectMake(15, 0.6*w+5+0.37*h-55, 0.2*w, 0.05*h)];
    self.phonelab.text=@"游客手机";
    self.phonelab.adjustsFontSizeToFitWidth=YES;
     self.phonelab.textAlignment=NSTextAlignmentCenter;
    [self.scr addSubview:self.phonelab];
    self.persontext=[[UITextField alloc]initWithFrame:CGRectMake(25+0.2*w, 0.6*w+5+0.3*h-55, 0.8*w-50, 0.05*h)];
   // self.persontext.borderStyle=UIButtonTypeRoundedRect;
    self.persontext.layer.cornerRadius=0;
    self.persontext.layer.masksToBounds=YES;
    [self.persontext.layer setBorderWidth:1];
    [self.persontext.layer setBorderColor:backRGB.CGColor];
    [self.scr addSubview:self.persontext];
    self.phonetext=[[UITextField alloc]initWithFrame:CGRectMake(25+0.2*w, 0.6*w+5+0.37*h-55, 0.8*w-50, 0.05*h)];
    self.phonetext.layer.cornerRadius=0;
    self.phonetext.layer.masksToBounds=YES;
    [self.phonetext.layer setBorderWidth:1];
    [self.phonetext.layer setBorderColor:backRGB.CGColor];

     self.phonetext.keyboardType=UIKeyboardTypeNumberPad;
  //  self.phonetext.borderStyle=UIButtonTypeRoundedRect;
    UIImageView *line5=[[UIImageView alloc]initWithFrame:CGRectMake(0,0.6*w+5+0.42*h-50- ((0.6*w+5+0.42*h-50)-(0.6*w+5+0.37*h-64+0.05*h))/2.0, w, 1)];
    line5.backgroundColor=backRGB;
   // [self.scr addSubview:line5];
 [self.scr addSubview:self.phonetext];
    UIImageView *lin=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0.6*w+5+0.42*h-50, w, 0.05*h)];
    lin.backgroundColor=garyRGB;
    [self.scr addSubview:lin];
    UILabel *labpaystle=[[UILabel alloc]initWithFrame:CGRectMake(0,0.6*w+5+0.42*h-50, 0.5*h , 0.05*h)];
    labpaystle.text=@"  支付方式";
    
    [self.scr addSubview:labpaystle ];
   
    
    self.WX=[[PaystyleButton alloc]initWithFrame:CGRectMake(5,0.6*w+5+0.48*h-48,w-10,0.08*h)];
    self.WX.imageleft.image=[UIImage imageNamed:@"hyb16"];
   
    self.WX.lab.text=@"微信支付";
    self.WX.lab.textColor=backRGB;
    //self.WX.layer .borderWidth=1;
   // [self.WX.layer setBorderColor:backRGB.CGColor];
    
    self.WX.tag=0;
     self.WX.imagerihght.image=[UIImage imageNamed:@"pay_checked.png"];
    [self.scr addSubview:self.WX];
    UIImageView *line4=[[UIImageView alloc]initWithFrame:CGRectMake(0,  0.6*w+5+0.58*h-48-((0.6*w+5+0.58*h-48)-(0.6*w+5+0.48*h-48+0.08*h))/2.0, w , 1)];
    line4.backgroundColor=backRGB;
    [self.scr addSubview:line4];
    self.ALPAY=[[PaystyleButton alloc]initWithFrame:CGRectMake( 5,0.6*w+5+0.58*h-48,w-10,0.08*h)];
    self.ALPAY.lab.text=@"支付宝支付";
    self.ALPAY.lab.textColor=backRGB;
 
    self.ALPAY.imageleft.image=[UIImage imageNamed:@"hyb15"];
    self.ALPAY.tag=1;
    [self.scr addSubview:self.ALPAY];
    [self.WX addTarget:self action:@selector(getPaystyle:) forControlEvents:UIControlEventTouchUpInside];
    [self.ALPAY addTarget:self action:@selector(getPaystyle:) forControlEvents:UIControlEventTouchUpInside];

    UIImageView *line3=[[UIImageView alloc]initWithFrame:CGRectMake(0, h-40-20,  w , 20)];
    line3.backgroundColor=garyRGB;
    [self.view addSubview:line3];
   NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"以阅读已接受<购票须知>中的相关条款"];
    
  [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:218/255.0 green:119/255.0 blue:0 alpha:1] range:NSMakeRange(6,6)]; //设置字体颜色
    
     [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:15.0] range:NSMakeRange(6, 6)];
    
    
  agreementButton*agree =[[agreementButton alloc]initWithFrame:CGRectMake(0.1*w+20, h-40-20, 0.8*w-40,  20)];
    agree.lab.attributedText = str;
 agree.pic.image =[UIImage imageNamed:@"cheakTicket.png"];
  
     agree.lab.font=[UIFont systemFontOfSize:15];
    [agree addTarget:self action:@selector(pushwebview) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: agree ];
    self.btnPush=[[UIButton alloc]initWithFrame:CGRectMake(0.5*w, h-40, 0.5*w, 40)];
    self.btnPush.backgroundColor=redRGB;
    [self.btnPush setTitle:@"支付订单" forState:UIControlStateNormal];
     [self.btnPush setTitle:@"支付订单" forState:UIControlStateHighlighted];
    [self.view addSubview:self.btnPush];
    self.btnPush.tag=0;
    [self.btnPush addTarget:self action:@selector(showView:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)pushwebview{
    BuyticketWebViewController *vic=[[ BuyticketWebViewController alloc]init];
    UINavigationController  *niv=[[UINavigationController  alloc]initWithRootViewController:vic];
    [niv.navigationBar setBarTintColor:redRGB];
    vic.strID=@"1";
    [self presentViewController:niv animated:YES completion:nil];
}
//支付选择
-(void)getPaystyle :(UIButton *)sender{
    if(sender.tag==0){
        self.strPaystyle =@"2";
        self.WX.imagerihght.image=[UIImage imageNamed:@"pay_checked.png"];
        self.ALPAY.imagerihght.image=[UIImage imageNamed:@""];
    }else  if(sender.tag==1){
        self.strPaystyle=@"1";
        self.WX.imagerihght.image=[UIImage imageNamed:@""];
        self.ALPAY.imagerihght.image=[UIImage imageNamed:@"pay_checked.png"];

    }
}
-(void)getView :(UIButton *)sender{
    
   
       if(sender.tag==0){
           
           
           //[self.scr addSubview:self.tab];
         //  self.tab.hidden=NO;
           self.scr.contentSize=CGSizeMake(w,1.1*h-104);
           self.WX.frame=CGRectMake(0.25*w-0.11*h+0.1*w+6, 0.6*w+5+0.33*h-62.5+0.1*h+0.44*h-0.4*w-36+0.01*h+0.15 , 0.22*h-0.2*w-12, 0.22*h-0.2*w-12);
           self.ALPAY.frame= CGRectMake( 0.75*w-0.11*h+0.1*w+6, 0.6*w+5+0.33*h-62.5+0.1*h+0.44*h-0.4*w-36+0.01*h+0.15 , 0.22*h-0.2*w-12, 0.22*h-0.2*w-12);
           [UIView animateWithDuration:1 animations:^{
               self.scr.contentOffset=CGPointMake(0, 0.44*h-0.4*w-36);
           }];
           
           self.btnViewadd.tag=1;
       }else if(sender.tag==1){
          // self.tab.hidden=YES;
           self.scr.contentSize=CGSizeMake(w , h-104+0.1*h-(0.44*h-0.4*w-36)+64);
           self.WX.frame= CGRectMake(0.25*w-0.11*h+0.1*w+6, 0.6*w+5+0.33*h-62.5+0.1*h+0.44*h-0.4*w-36+0.01*h+0.15-(0.63*h-0.6*w-109), 0.22*h-0.2*w-12, 0.22*h-0.2*w-12) ;
           self.ALPAY.frame= CGRectMake( 0.75*w-0.11*h+0.1*w+6, 0.6*w+5+0.33*h-62.5+0.1*h+0.44*h-0.4*w-36+0.01*h+0.15-(0.63*h-0.6*w-109), 0.22*h-0.2*w-12, 0.22*h-0.2*w-12);
           
           [UIView animateWithDuration:1 animations:^{
               self.scr.contentOffset=CGPointMake(0,  -64);
           }];
           
           self.btnViewadd.tag=0;
       }

   }
  
-(void)showView :(UIButton *)sender{
    if(sender.tag==0){
    [[SMProgressHUD shareInstancetype]  showLoading];

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
   // NSLog(@"%@",[array.lastObject objectForKey:@"token"]);
    NSDictionary *parameters = @{
                                 @"BusinessUserEntity":@{
                                         @"token":[NSString stringWithFormat:@"%@", [array.lastObject objectForKey:@"token"]],
                                         }};//发送请求
    [manager POST: cheakPersonInfo parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
       // NSLog(@"%@",responseObject);
        NSDictionary *dic=[responseObject objectForKey:@"Result"];
       // NSLog(@"%@",dic);
        if(![[ NSString stringWithFormat:@"%@", [[dic objectForKey:@"businessUser"] objectForKey:@"state"]] isEqualToString:@"2"]){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [[SMProgressHUD shareInstancetype] dismissLoadingView];
            });

            [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"审核尚未通过不能购票" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
        }else{
              if([self. persontext.text isEqualToString:@""]||self.phonetext.text.length!=11){
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [[SMProgressHUD shareInstancetype] dismissLoadingView];
                });

                [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"信息有误"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
            }else{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [[SMProgressHUD shareInstancetype] dismissLoadingView];
                });

                                         [self getphonenumber];
                
                    
              
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [[SMProgressHUD shareInstancetype] dismissLoadingView];
        });

        NSLog(@"Error: %@", error);
        
        [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"网络异常,请稍后重试"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
        
    }];}  }

-(void)getphonenumber{
    NSDictionary *json = @{
                           @"UserEntity":@{
                                   @"phone":self.phonetext.text,
                                   @"smstype":@"25"
                                   }
                           };
    AFHTTPRequestOperationManager*manager=[AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //申明请求的数据是json类型
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    //设置请求头
    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
    
    
    //发送请求
    [manager POST:getNumb  parameters:json success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic=[responseObject objectForKey:@"Result"];
        
        if([[ NSString stringWithFormat:@"%@",[dic objectForKey:@"errorCode"]] isEqualToString:@"0"]){
            self.btnPush.tag=1;
           
        if( self.backView.alpha==1){
            
            self.backView.alpha=0;
            self.viewcheak.backgroundColor=[UIColor whiteColor];
        }else{
            
            [UIView animateWithDuration:1 animations:^{
                self.backView.alpha=1;
                [self.cheakNumber becomeFirstResponder];
                 [[[UIAlertView alloc]initWithTitle:@"提示信息" message:  [NSString stringWithFormat:@"%@", [dic objectForKey:@"errorMessage"]] delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
                            }];
            
        }}else{

        [[[UIAlertView alloc]initWithTitle:@"提示信息" message:  [NSString stringWithFormat:@"%@", [dic objectForKey:@"errorMessage"]] delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"网络出了点问题，请稍后重试"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
        
    }];
 

}
             //下单
-(void)btnPushinfo{
    if(self.cheakNumber.text.length==0){
    [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"请输入验证码"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
    }else
    {
        self.btnPush.tag=0;
        [[SMProgressHUD shareInstancetype]  showLoading];
   
    
    NSArray *arr=[self.dateBtn.titleLabel.text componentsSeparatedByString:@" "];
           NSString *path=NSHomeDirectory();
       NSString * path2=[path stringByAppendingString:@"/Documents/"];
        NSString * path1=[path2 stringByAppendingString:@"/token.json"];
       NSArray *array=[[NSArray alloc]init];
        array=[NSArray arrayWithContentsOfFile:path1];
        if(![[NSString stringWithFormat:@"%@" ,
             [self.dic objectForKey:@"isChangePrice"] ] isEqualToString:@"1"]){
            self.nowPrice=@"0";
        }

    NSArray *ticketinfo=[NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:[self.dic objectForKey:@"id"], @"ticketId",arr[0], @"ticketDay",self.count.text, @"quantity",self.nowPrice,@"inputPrice", nil] ,nil];
    
    NSDictionary *dic = @{
                           @"id":@"8395626",
                           @"method":@"order.ticket.createOrder",
                           @"params":@{
                                   @"desc":@"",
                                   @"seledPayType":self.strPaystyle,
                                   @"mobilePhone":self.phonetext.text,
                                   @"ticketList":ticketinfo,
                                   
                @"wechatId":[NSString stringWithFormat:@"%@", [array.lastObject objectForKey:@"ID"]],
                @"name":self.persontext.text,
                @"certNo":[NSString stringWithFormat:@"%@", [array.lastObject objectForKey:@"idCardNo"]],
                @"source":@"",
                @"fromChannel":@"hyb_ios",
                @"openId":@"NULL"},
                           @"jsonrpc":@"2.0"};
 
     NSData *data=[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *json =@{@"transitEntity":@{
        @"code": self.cheakNumber.text,
        @"phoneNum": self.phonetext.text,
        @"smsType": @"25",
        @"requestBody":str
        }  };
 //   NSLog(@"324324%@",json);
    AFHTTPRequestOperationManager*manager=[AFHTTPRequestOperationManager manager];
//申明返回的结果是json类型
manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //申明请求的数据是json类型
manager.responseSerializer=[AFJSONResponseSerializer serializer];
        //设置请求
[manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
[manager.requestSerializer setValue:@"application/json;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
    //发送请求
[manager POST:Order  parameters:json success:^(AFHTTPRequestOperation *operation, id responseObject) {
  
                                 NSDictionary *dic=[responseObject objectForKey:@"Result"];
    
    if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"errorCode"]] isEqualToString:@"-1"]){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [[SMProgressHUD shareInstancetype] dismissLoadingView];
        });

        [[[UIAlertView alloc]initWithTitle:@"提示信息" message:[NSString stringWithFormat:@"%@",[dic objectForKey:@"errorMessage"] ]  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
    }else{
    
NSData *jsonData = [[dic objectForKey:@"responseBody"] dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:jsonData
                                                           
                options:NSJSONReadingMutableContainers error:&err];
             NSLog(@"dic1===%@",dic1);
    if([dic1 objectForKey:@"result"]==nil){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [[SMProgressHUD shareInstancetype] dismissLoadingView];
        });

         [[[UIAlertView alloc]initWithTitle:@"提示信息" message:[NSString stringWithFormat:@"%@",[[dic1 objectForKey:@"error"] objectForKey:@"message"] ]  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
    }else
    {                                     PaydetaileController *vic=[[PaydetaileController alloc]init];
                                     UINavigationController *niv=[[UINavigationController alloc]initWithRootViewController:vic];
                                     [niv.navigationBar setBarTintColor:redRGB];
    
                                     NSArray *arr=[self.amount.text componentsSeparatedByString:@":"];
                       NSLog(@"DIC!==%@",dic1);
                                     vic.dic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:self.count.text,@"count",arr.lastObject,@"price",self.ticketName.text,@"name",[[dic1 objectForKey:@"result"] objectForKey:@"payQrUrl"],@"image",[[dic1 objectForKey:@"result"] objectForKey:@"orderNo"],@"orderNo",self.dateBtn.titleLabel.text,@"time",nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [[SMProgressHUD shareInstancetype] dismissLoadingView];
    });
             self.backView.alpha=0;
              self.cheakNumber.text=@"";
        [self presentViewController:niv animated:YES completion:nil];}}
    
                                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                         
                                         [[SMProgressHUD shareInstancetype] dismissLoadingView];
                                     });

                                   NSLog(@"Error: %@", error);
                                     
                                     [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"网络异常,请稍后重试"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
                                     
                                 }];}
}
-(void)getback{
    [UIView animateWithDuration:1 animations:^{
        self.backView.alpha=0;
        self.btnPush.tag=0;
    }];
    

    }
-(void)getdate{
    GuWeiDatePickerView *pickerView =  [[GuWeiDatePickerView alloc] initWithFrame:CGRectMake(100, 200, 200, 300)];
    pickerView.pickerBlock = ^(NSString *date){
        [self.dateBtn setTitle:date forState:UIControlStateNormal];
      
        
    };
    [self.view addSubview:pickerView];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event         {
    [self.view endEditing:YES];
}

@end
