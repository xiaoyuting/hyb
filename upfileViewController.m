//
//  upfileViewController.m
//  HYB
//
//  Created by CUIZE on 16/8/15.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "upfileViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "Head.h"
#import "AFNetworking.h"
#import "checkViewController.h"
#import "SMProgressHUD.h"
@interface upfileViewController ()<UIPickerViewDataSource, UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
//view

@property (strong, nonatomic) IBOutlet UIPickerView *myPicker;
@property (strong, nonatomic) IBOutlet UIView *pickerBgView;
@property (strong, nonatomic) UIView *maskView;

 //data
@property (strong, nonatomic) NSDictionary *pickerDic;
@property (strong, nonatomic) NSArray *provinceArray;
@property (strong, nonatomic) NSArray *cityArray;
@property (strong, nonatomic) NSArray *townArray;
@property (strong, nonatomic) NSArray *selectedArray;

@end

@implementation upfileViewController
-(void)viewback{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    UIImageView *backhead=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, w , 56 +0.08*h)];
    backhead.backgroundColor=[UIColor colorWithRed:209/255.0 green:209/255.0 blue:209/255.0 alpha:1];
    [self.view addSubview:backhead ];
    self.title=@"认证资料";
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"zhankaileft"] style:UIBarButtonItemStyleDone target:self action:@selector(viewback)];
    self.navigationItem.leftBarButtonItem=left;
    [super viewDidLoad];
    self.localLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 64, w/4.0, 40)];
    self.localLable.text=@"所在区域";
    
    self.localLable.textColor=[UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:1];
    self.view.backgroundColor=garyRGB;
    self.localLable.adjustsFontSizeToFitWidth=YES;
    self.localLable.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:self.localLable];
    self.leftButton = [SXButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame = CGRectMake(w/4.0, 64, w/4.0, 40);
    UIImageView *line1=[[UIImageView alloc]initWithFrame:CGRectMake(0,  92+0.04*h, w , 1)];
    line1.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    [self.view addSubview:line1];
   [self.leftButton setImage:[UIImage imageNamed:@"zhankaired"] forState:UIControlStateNormal];
    [ self.leftButton setTitle:@"省份" forState:UIControlStateNormal];
    [self.leftButton setTitleColor:[UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:1] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(showMyPicker: ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftButton];
    self.centerButton = [SXButton buttonWithType:UIButtonTypeCustom];
    self.centerButton.frame = CGRectMake(w/2.0, 64, w/4.0, 40);
 
   [self.centerButton setImage:[UIImage imageNamed:@"zhankaired"] forState:UIControlStateNormal];
    [ self.centerButton setTitle:@"城市" forState:UIControlStateNormal];
     [self.centerButton setTitleColor:[UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:1] forState:UIControlStateNormal];
    [self.centerButton addTarget:self action:@selector(showMyPicker: ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.centerButton];
    self.rightButton = [SXButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = CGRectMake(w*3/4.0, 64, w/4.0, 40);
    [self.rightButton setImage:[UIImage imageNamed:@"zhankaired"] forState:UIControlStateNormal];
    [ self.rightButton setTitle:@"地区" forState:UIControlStateNormal];
     [self.rightButton setTitleColor:[UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:1] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(showMyPicker: ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rightButton];
    self.typeLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 120, 0.3*w, 0.08*h)];
    self.typeLable.text=@"  您的身份类型";
    
    self.typeLable.textColor=[UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:1];
    self.typeLable.adjustsFontSizeToFitWidth=YES;
   
    [self.view addSubview:self.typeLable];
    
    self.typeButton =[[SXButton alloc]initWithFrame:CGRectMake(0.4*w, 120, 0.3*w, 0.08*h)];
    [self.typeButton setImage:[UIImage imageNamed:@"zhankaired"] forState:UIControlStateNormal];
    [ self.typeButton setTitle:@"商户   " forState:UIControlStateNormal];
    [self.typeButton setTitleColor:backRGB forState:UIControlStateNormal];
    [self.typeButton addTarget:self action:@selector(typeselect) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:self.typeButton];

        [self getPickerData];
    [self initView];
    [self shopview];
    [self camera];
    self.strUrl1=[[NSString alloc]init];
    self.strUrl2=[[NSString alloc]init];
    self.strUrl3=[[NSString alloc]init];
    self.strUrl4=[[NSString alloc]init];
    self.pushButton=[[UIButton alloc]initWithFrame:CGRectMake(0, h-30, w, 30)];
    //self.pushButton.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    [self.pushButton setTitle:@"提交" forState:UIControlStateNormal];
    [self.pushButton   setTitle:@"提交" forState:UIControlStateHighlighted];
    self.pushButton.backgroundColor=redRGB;
    
    [self.pushButton addTarget:self action:@selector(pushInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.pushButton];

    // Do any additional setup after loading the view.
}
-(void)typeselect{
    NSLog(@"1232");
    NSMutableArray *obj = [NSMutableArray array];
    
    for (NSInteger i = 0; i < [self titles].count; i++) {
        
        WBPopMenuModel * info = [WBPopMenuModel new];
        info.image = [self images][i];
        info.title = [self titles][i];
        [obj addObject:info];
    }
    
    [[WBPopMenuSingleton shareManager]showPopMenuSelecteWithFrame:150
                                                             item:obj
                                                           action:^(NSInteger index) {
                                                               NSLog(@"index:%ld",(long)index);
                                                               if(index==1){
                                                                   [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"别着急我们还在努力开发中"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
                                                               }
                                                           }];

}
- (NSArray *) titles {
    return @[@"商户",
             @"导游"
            // @"创建讨论组",
             //@"发送到电脑",
             //@"面对面快传",
             //@"收钱"
             ];
}

- (NSArray *) images {
    return @[@"right_menu_QR@3x",
             @"right_menu_addFri@3x"
            // @"right_menu_multichat@3x",
            // @"right_menu_sendFile@3x",
            // @"right_menu_facetoface@3x",
             //@"right_menu_payMoney@3x"
             ];
}
//上传资料
-(void)pushInfo{
    NSLog(@"%@",self.leftButton.titleLabel.text);
    if(self.nameText.text.length==0||self.bankName.text.length==0||self.bankNumber.text.length==0||self.personId.text==0 ){
         [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"请确认信息是否完整"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
        
    }else{
        if([self.strUrl1 isEqualToString:@""]||[self.strUrl2 isEqualToString:@""]||[self.strUrl3 isEqualToString:@""]/*&&[self.strUrl4 isEqualToString:@""]*/){
            [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"请查看图片是否上传"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];

        }else{
            if([self.leftButton.titleLabel.text isEqualToString:@"省份"]){
                [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"请选择地址"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];

            }else{
                [[SMProgressHUD shareInstancetype] showLoading];
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
        NSLog(@"%@",[array.lastObject objectForKey:@"token"]);
    NSDictionary *parameters = @{
                                 @"BusinessUserEntity":@{
                                         @"token":[NSString stringWithFormat:@"%@", [array.lastObject objectForKey:@"token"]],
                                         @"realName":self.nameText.text,
                                         @"identitycard":self.strUrl1,
                                         @"idcardBackPic":self.strUrl2,
                                         @"hygieneLicence":self.strUrl4,
                                         @"businesslicence":self.strUrl3,
                                         @"address":  [NSString stringWithFormat:@"%@%@%@", self.leftButton.titleLabel.text, self.centerButton .titleLabel.text ,self.rightButton.titleLabel.text],
                                         @"idCardNo":self.personId.text,
                                         @"bankCardNo":self.bankNumber.text,
                                         @"openBankAddress":self.bankName.text,
                                         @"alipayAccount":self.alPayNumber.text
                                         }
                                 };
    
    
    //发送请求
    [manager POST:PushPersonInfo  parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [[SMProgressHUD shareInstancetype] dismissLoadingView];
        });

        NSDictionary *dic=[responseObject objectForKey:@"Result"];
        NSLog(@"%@",dic);
       
        if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"errorCode"]] isEqualToString:@"-1"]){
            [[[UIAlertView alloc]initWithTitle:@"提示信息" message: [dic objectForKey:@"errorMessage"] delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];}else{
                checkViewController *vic=[[checkViewController alloc]init];
                vic.strID=@"1";
                UINavigationController *niv=[[UINavigationController alloc]initWithRootViewController:vic];
                [niv.navigationBar setBarTintColor:redRGB];
                [self presentViewController:niv animated:YES completion:nil];

            }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [[SMProgressHUD shareInstancetype] dismissLoadingView];
        });

        NSLog(@"Error: %@", error);
        
        [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"网络出错"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
        
    }];}
    }
    }
}
-(void)shopview{
    self.scr=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 120 +0.08*h, w , h-150-0.08*h)];
    
    self.scr.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    self.scr.bounces=NO;
    self.scr.contentSize=CGSizeMake(w , 0.40*h+w+50);
       self.typeLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0 , 0.3*w, 0.08*h)];
    self.typeLable.text=@"  您的身份类型";
    
    self.typeLable.textColor=[UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:1];
     self.typeLable.adjustsFontSizeToFitWidth=YES;
   // UIImageView *vic=[[UIImageView alloc]initWithFrame:CGRectMake(20, 1, w-40, 1)];
    //vic.backgroundColor=[UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:1];
    //[self.scr addSubview:vic];
    //[self.scr addSubview:self.typeLable];
  
    self.typeButton =[[SXButton alloc]initWithFrame:CGRectMake(0.4*w, 0, 0.3*w, 0.08*h)];
    [self.typeButton setImage:[UIImage imageNamed:@"redDown"] forState:UIControlStateNormal];
    [ self.typeButton setTitle:@"商户   " forState:UIControlStateNormal];
    [self.typeButton addTarget:self action:@selector(typeselect) forControlEvents:UIControlEventTouchUpInside];
    //[self.scr  addSubview:self.typeButton];
   self.nameLable=[[UILabel alloc]initWithFrame:CGRectMake(0,0 , 0.3*w, 0.08*h)];
    self.nameLable.text=@"  您的真实姓名";
    self.nameLable.font=[UIFont systemFontOfSize:14];
    self.nameLable.textColor=[UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:1];
    [self.scr addSubview:self.nameLable];
    self.nameText=[[UITextField alloc]initWithFrame:CGRectMake(0.35*w, 0, 0.65*w, 0.08*h)];
    self.nameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameText.textAlignment =NSTextAlignmentLeft;
    UIImageView *line2=[[UIImageView alloc]initWithFrame:CGRectMake(20, 0.08*h, w-40, 1)];
    line2.backgroundColor=[UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:1];
    [self.scr addSubview:line2];
    [self.scr  addSubview:self.nameText];
    self.nameLable.adjustsFontSizeToFitWidth=YES;
    self.personlab =[[UILabel alloc]initWithFrame:CGRectMake(0,0.08*h, 0.3*w, 0.08*h)];
    self.personlab.text=@"  您的身份证号";
    self.personlab .font=[UIFont systemFontOfSize:14];
    self.personlab.textColor=[UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:1];
    
    self.personlab.adjustsFontSizeToFitWidth=YES;
    UIImageView *line3=[[UIImageView alloc]initWithFrame:CGRectMake(20, 0.16*h, w-40, 1)];
    line3.backgroundColor=[UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:1];
    [self.scr addSubview:line3];
    self.personId=[[UITextField alloc]initWithFrame:CGRectMake(0.35*w, 0.08*h, 0.65*w, 0.08*h)];
    self.personId.clearButtonMode=UITextFieldViewModeWhileEditing;
 
    self.personId.textAlignment =NSTextAlignmentLeft;
    
    [self.scr addSubview:self.personId];
    [self.scr addSubview:self.personlab ];
    UILabel *banklanname=[[UILabel alloc]initWithFrame:CGRectMake(0, 0.16*h, 0.3*w, 0.08*h)];
    banklanname .text=@"  开户行名称";
    banklanname.font=[UIFont systemFontOfSize:14];
    banklanname .adjustsFontSizeToFitWidth=YES;
    banklanname.textColor=[UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:1];
    [self.scr addSubview:banklanname];
    
    self.bankName=[[UITextField alloc]initWithFrame:CGRectMake(0.35*w, 0.16*h, 0.65*w, 0.08*h)];
    self.bankName.placeholder=@"例：建设银行池州分行青阳分行";
    self.bankName.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.bankName.adjustsFontSizeToFitWidth =YES;
    self.bankName.textAlignment =NSTextAlignmentLeft;
    [self.scr addSubview:self.bankName];
    UIImageView *line4=[[UIImageView alloc]initWithFrame:CGRectMake(20, 0.24*h, w-40, 1)];
    line4.backgroundColor=[UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:1];
    [self.scr addSubview:line4];
    UILabel *labbankCard=[[UILabel alloc]initWithFrame:CGRectMake(0, 0.24*h, 0.3*w, 0.08*h)];
    labbankCard.text=@"  银行卡号";
    labbankCard.font=[UIFont systemFontOfSize:14];
     labbankCard.adjustsFontSizeToFitWidth=YES;
    labbankCard.textColor=[UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:1];
    labbankCard.adjustsFontSizeToFitWidth=YES;
    [self.scr addSubview:labbankCard];
    self.bankNumber=[[UITextField alloc]initWithFrame:CGRectMake(0.35*w, 0.24*h, 0.65*w, 0.08*h)];
    self.bankNumber.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.bankNumber.keyboardType=UIKeyboardTypeNumberPad;
    self.bankNumber.textAlignment =NSTextAlignmentLeft;
    [self.scr addSubview:self.bankNumber];
    UIImageView *line5=[[UIImageView alloc]initWithFrame:CGRectMake(20, 0.32*h, w-40, 1)];
    line5.backgroundColor=[UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:1];
    [self.scr addSubview:line5];
    UILabel *labalpay=[[UILabel alloc]initWithFrame:CGRectMake(0, 0.32*h, 0.3*w, 0.08*h)];
    labalpay.text=@"  支付宝账号";
    
    labalpay .font=[UIFont systemFontOfSize:14];
     labalpay.adjustsFontSizeToFitWidth=YES;
    labalpay.textColor=[UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:1];
    labalpay.adjustsFontSizeToFitWidth=YES;
    
    [self.scr addSubview:labalpay];
    self.alPayNumber=[[UITextField alloc]initWithFrame:CGRectMake(0.35*w, 0.32*h, 0.65*w, 0.08*h)];
    self.alPayNumber.textAlignment =NSTextAlignmentLeft;
    self.alPayNumber.placeholder =@"(选填)";
    self.alPayNumber.clearButtonMode=UITextFieldViewModeWhileEditing;
    [self.scr addSubview:self.alPayNumber];
    UIImageView *line6=[[UIImageView alloc]initWithFrame:CGRectMake(20, 0.40*h, w-40, 1)];
    line6.backgroundColor=[UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:1];
    [self.scr addSubview:line6];

    self.photo1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0.40*h+3, 0.5*w-1 ,0.5*w-1 )];
        self.photo1.backgroundColor=[UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];
    self.photo1.userInteractionEnabled=YES;
    self.btnpic1=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0.5*w-1 ,0.5*w-1)];
    
    self.btnpic1.tag=1;
    [self.btnpic1 addTarget:self action:@selector(getPic:) forControlEvents:UIControlEventTouchUpInside];
    [self.photo1 addSubview:self.btnpic1];
    
    self.lab1=[[UILabel alloc]initWithFrame:CGRectMake(20,0.40*h+0.5*w+5 , 0.5*w-41 , 15)];
   self.lab1.text=@"上传身份证正面" ;
 
    //self.lab1.font=[UIFont systemFontOfSize:8];
 

    [self.scr addSubview:self.photo1];
    [self.scr addSubview:self.lab1];
    self.photo2=[[UIImageView alloc]initWithFrame:CGRectMake(0.5*w+1, 0.40*h+3, 0.5*w-1 , 0.5*w-1)];
    self.photo2.backgroundColor=[UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];
    self.photo2.userInteractionEnabled=YES;
    self.btnpic2=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0.5*w-1 ,0.5*w-1)];
     self.btnpic2.tag=2;
    [self.btnpic2 addTarget:self action:@selector(getPic:) forControlEvents:UIControlEventTouchUpInside];
    [self.photo2 addSubview:self.btnpic2];
 
    self.lab2=[[UILabel alloc]initWithFrame:CGRectMake(0.5*w+1+20,0.40*h+0.5*w+5, 0.5*w-41 , 15)];
  
    [self.scr addSubview:self.photo2];
    [self.scr addSubview:self.lab2];
    
  self.lab2.text=@"上传身份证反面";
    //self.lab2.font=[UIFont systemFontOfSize:8];
        self.photo3=[[UIImageView alloc]initWithFrame:CGRectMake(0 ,0.40*h+0.5*w+23, 0.5*w-1 , 0.5*w-1 )];
        self.photo3.backgroundColor=[UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];
    self.photo3.userInteractionEnabled=YES;
    self.btnpic3=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0.5*w-1 ,0.5*w-1)];
     self.btnpic3.tag=3;
    [self.btnpic3 addTarget:self action:@selector(getPic:) forControlEvents:UIControlEventTouchUpInside];
    [self.photo3 addSubview:self.btnpic3];
    [self.scr addSubview:self.photo3];
    self.lab3=[[UILabel alloc]initWithFrame:CGRectMake(20,0.40*h+w+25 , 0.5*w-41 ,15)];
 
       self.lab3.text=@"上传营业执照"  ;
 
    // self.lab3.font=[UIFont systemFontOfSize:8];
    [self.scr addSubview:self.lab3];
        self.photo4=[[UIImageView alloc]initWithFrame:CGRectMake(0.5*w+1,0.40*h+0.5*w+23, 0.5*w-1 , 0.5*w-1)];
        self.photo4.backgroundColor=[UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];
      //  [self.shopView addSubview:self.photo4];
   self.lab4=[[UILabel alloc]initWithFrame:CGRectMake(0.5*w+21,0.40*h+w+25 , 0.5*w-41 ,15)];
 
    self.photo4.userInteractionEnabled=YES;
    self.btnpic4=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0.5*w-1 ,0.5*w-1)];
     self.btnpic4.tag=4;
    [self.btnpic4 addTarget:self action:@selector(getPic:) forControlEvents:UIControlEventTouchUpInside];
     self.lab4.text=  @"上传卫生许可证"  ;
    [self.photo4  addSubview:self.btnpic4];
   
     //self.lab4.font=[UIFont systemFontOfSize:8];
   
    [self.scr addSubview:self.lab4];
    [self.scr addSubview:self.photo4];
    [self setlab:self.lab1];
    [self setlab:self.lab2];
    [self setlab:self.lab3];
    [self setlab:self.lab4];
    self.photo1.image=[UIImage imageNamed:@"upfile2.jpg"];
    self.photo2.image=[UIImage imageNamed:@"upfile1.jpg"];
    self.photo3.image=[UIImage imageNamed:@"upfile3.jpg"];
    self.photo4.image=[UIImage imageNamed:@"upfile4.jpg"];
    self.photo1.tag=0;
      self.photo2.tag=0;
      self.photo3.tag=0;
      self.photo4.tag=0;
    [self.view addSubview:self.scr];

}
-(void)pushPic :(UIButton *)sender{
    
    if(sender.tag==1){
if(self.photo1.tag==0){
  
        }else{
        AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
               [manager POST:picChange  parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            [formData appendPartWithFileData:UIImageJPEGRepresentation(self.photo1.image, 0.3) name:@"upfile" fileName:@"text.png" mimeType:@"text/plain"];
        } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            NSLog(@"身份证正面上传== %@", responseObject);
            self.strUrl1=[ responseObject   objectForKey:@"picUrl"];
            self.photo1.tag=0;
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            NSLog(@"错误信息=====%@", error);
            self.photo1.tag=0;
        }];}
 
    }else if(sender.tag==2){
        if(self.photo2.tag==0){
            
        }else
        {
        AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
                [manager POST:picChange  parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            [formData appendPartWithFileData:UIImageJPEGRepresentation(self.photo2.image, 0.3) name:@"upfile" fileName:@"text.png" mimeType:@"text/plain"];
        } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            NSLog(@"身份证正面上传== %@", responseObject);
            self.strUrl2=[ responseObject   objectForKey:@"picUrl"];
            self.photo2.tag=0;
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            NSLog(@"错误信息=====%@", error);
            self.photo2.tag=0;
        }];
        
        }
 
    }else if(sender.tag==3){
        if(self.photo3.tag==0){
            
        }else{
        AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
        [manager POST:picChange  parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            [formData appendPartWithFileData:UIImageJPEGRepresentation(self.photo3.image, 0.3) name:@"upfile" fileName:@"text.png" mimeType:@"text/plain"];
        } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            NSLog(@"身份证正面上传== %@", responseObject);
            self.strUrl3=[ responseObject   objectForKey:@"picUrl"];
            self.photo3.tag=0;
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            NSLog(@"错误信息=====%@", error);
            self.photo3.tag=0;
        }];
        }
        }else if(sender.tag==4){
        if(self.photo4.tag==0){
            }
            else
            {
        AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
        [manager POST:picChange  parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            [formData appendPartWithFileData:UIImageJPEGRepresentation(self.photo4.image, 0.3) name:@"upfile" fileName:@"text.png" mimeType:@"text/plain"];
        } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            NSLog(@"身份证正面上传== %@", responseObject);
            self.strUrl4=[ responseObject  objectForKey:@"picUrl"];
            self.photo4.tag=0;
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            NSLog(@"错误信息=====%@", error);
            self.photo4.tag=0;
        }];
        
        }}
}
-(void)getPic :(UIButton *)sender{
    if(sender.tag==1){
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机", @"相册", nil];
        sheet.tag=1;
    [sheet showInView:self.view.window];
    }
   else if(sender.tag==2){
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机", @"相册", nil];
        sheet.tag=2;
        [sheet showInView:self.view.window];
    }

   else if(sender.tag==3){
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机", @"相册", nil];
       sheet.tag=3;
        [sheet showInView:self.view.window];
    }

   else if(sender.tag==4){
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机", @"相册", nil];
       sheet.tag=4;
        [sheet showInView:self.view.window];
    }

  
    
}
-(void)camera{
    _imagePickerController1 = [[UIImagePickerController alloc] init];
    _imagePickerController2=[[UIImagePickerController alloc]init];
    _imagePickerController1.delegate = self;
    _imagePickerController2.delegate=self;
    //相机类型（拍照、录像...）
    _imagePickerController1.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController2.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController1.allowsEditing = YES;
    _imagePickerController2.allowsEditing = YES;
    _imagePickerController1.mediaTypes = @[(NSString *)kUTTypeImage];
    _imagePickerController2.mediaTypes = @[(NSString *)kUTTypeImage];
    _imagePickerController3 = [[UIImagePickerController alloc] init];
    _imagePickerController4=[[UIImagePickerController alloc]init];
    _imagePickerController3.delegate = self;
    _imagePickerController4.delegate=self;
    //相机类型（拍照、录像...）
    _imagePickerController3.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController4.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController3.allowsEditing = YES;
    _imagePickerController4.allowsEditing = YES;
    _imagePickerController3.mediaTypes = @[(NSString *)kUTTypeImage];
    _imagePickerController4.mediaTypes = @[(NSString *)kUTTypeImage];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//适用获取所有媒体资源，只需判断资源类型
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    if ([self.imagePickerController1  isEqual:picker]){
        NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
        //判断资源类型
        if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
            NSLog( @"头像被点击1");
            //如果是图片
            //UIImageView *imageView=[[UIImageView alloc]init];
            //imageView.image = info[UIImagePickerControllerEditedImage];
           // [self getimage:imageView.image];
            self.photo1.tag=1;
            self.photo1.image=info[UIImagePickerControllerEditedImage];
            AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
            [manager POST:picChange  parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                
                [formData appendPartWithFileData:UIImageJPEGRepresentation(self.photo1.image, 0.3) name:@"upfile" fileName:@"text.png" mimeType:@"text/plain"];
            } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
               // NSLog(@"身份证正面上传== %@", responseObject);
                self.strUrl1=[ responseObject   objectForKey:@"picUrl"];
                self.lab1.text=@"上传成功";
            } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                NSLog(@"错误信息=====%@", error);
                 self.lab1.text=@"网络不好请重新选择";
                  [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"请重新选择图片"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
            }];
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }}
    if([self.imagePickerController2 isEqual:picker]){
        NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
        //判断资源类型
        if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
            //如果是图片
            NSLog( @"背景被点击2");
          //  UIImageView *imageView=[[UIImageView alloc]init];
            //imageView.image = info[UIImagePickerControllerEditedImage];
            //[self getimagebac:imageView.image];
            self.photo2.tag=1;
            self.photo2.image=info[UIImagePickerControllerEditedImage];
            AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
            [manager POST:picChange  parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                
                [formData appendPartWithFileData:UIImageJPEGRepresentation(self.photo2.image, 0.3) name:@"upfile" fileName:@"text.png" mimeType:@"text/plain"];
            } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
               // NSLog(@"身份证正面上传== %@", responseObject);
                self.strUrl2=[ responseObject   objectForKey:@"picUrl"];
                 self.lab2.text=@"上传成功";
            } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                NSLog(@"错误信息=====%@", error);
                 self.lab2.text=@"网络不好请重新选择";
                  [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"请重新选择图片"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
            }];

            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
    if([self.imagePickerController3 isEqual:picker]){
        NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
        //判断资源类型
        if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
            //如果是图片
            NSLog( @"背景被点击3");
            //UIImageView *imageView=[[UIImageView alloc]init];
            //imageView.image = info[UIImagePickerControllerEditedImage];
            self.photo3.tag=1;
            //[self getimagebac:imageView.image];
      self.photo3.image=info[UIImagePickerControllerEditedImage];
            AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
            [manager POST:picChange  parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                
                [formData appendPartWithFileData:UIImageJPEGRepresentation(self.photo3.image, 0.3) name:@"upfile" fileName:@"text.png" mimeType:@"text/plain"];
            } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
               // NSLog(@"身份证正面上传== %@", responseObject);
                self.strUrl3=[ responseObject   objectForKey:@"picUrl"];
                 self.lab3.text=@"上传成功";
            } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                NSLog(@"错误信息=====%@", error);
                self.lab3.text=@"网络不好请重新选择";
  [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"请重新选择图片"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
            }];

            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }

    if([self.imagePickerController4 isEqual:picker]){
        NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
        //判断资源类型
        if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
            //如果是图片
            NSLog( @"背景被点击4");
            self.photo4.tag=1;
           // UIImageView *imageView=[[UIImageView alloc]init];
           // imageView.image = info[UIImagePickerControllerEditedImage];
            //[self getimagebac:imageView.image];
    self.photo4.image=info[UIImagePickerControllerEditedImage];
            AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
            [manager POST:picChange  parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                
                [formData appendPartWithFileData:UIImageJPEGRepresentation(self.photo4.image, 0.3) name:@"upfile" fileName:@"text.png" mimeType:@"text/plain"];
            } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                NSLog(@"身份证正面上传== %@", responseObject);
                self.strUrl4=[ responseObject  objectForKey:@"picUrl"];
                 self.lab4.text=@"上传成功";
            } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                NSLog(@"错误信息=====%@", error);
                 self.lab4.text=@"网络不好请重新选择";
                 [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"请重新选择图片"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
            }];

            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }

}


#pragma mark 图片保存完毕的回调
- (void) image: (UIImage *) image didFinishSavingWithError:(NSError *) error contextInfo: (void *)contextInf{
    NSLog(@"huidiao");
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
        if(actionSheet.tag==1) {
        if(buttonIndex == 0)
        {
            _imagePickerController1.sourceType =  UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:_imagePickerController1 animated:YES completion:nil];
            
        }
        if(buttonIndex == 1)
        {
            _imagePickerController1.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentViewController:_imagePickerController1 animated:YES completion:nil];
            
        }
        
        }  if(actionSheet.tag==2) {
            if(buttonIndex == 0)
            {
                _imagePickerController2.sourceType =  UIImagePickerControllerSourceTypeCamera;
                
                [self presentViewController:_imagePickerController2 animated:YES completion:nil];
                
            }
            if(buttonIndex == 1)
            {
                _imagePickerController2.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                
                [self presentViewController:_imagePickerController2 animated:YES completion:nil];
                
            }
            
        }
    if(actionSheet.tag==3) {
        if(buttonIndex == 0)
        {
            _imagePickerController3.sourceType =  UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:_imagePickerController3 animated:YES completion:nil];
            
        }
        if(buttonIndex == 1)
        {
            _imagePickerController3.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentViewController:_imagePickerController3 animated:YES completion:nil];
            
        }
        
    }
    if(actionSheet.tag==4) {
        if(buttonIndex == 0)
        {
            _imagePickerController4.sourceType =  UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:_imagePickerController4 animated:YES completion:nil];
            
        }
        if(buttonIndex == 1)
        {
            _imagePickerController4.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentViewController:_imagePickerController4 animated:YES completion:nil];
            
        }
        
    }

    
}


#pragma mark - init view
- (void)initView {
    
    self.maskView = [[UIView alloc] initWithFrame:kScreen_Frame];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0;
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
    
    self.pickerBgView.width = kScreen_Width;
}
#pragma mark - get data
- (void)getPickerData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    self.pickerDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    self.provinceArray = [self.pickerDic allKeys];
    self.selectedArray = [self.pickerDic objectForKey:[[self.pickerDic allKeys] objectAtIndex:0]];
    
    if (self.selectedArray.count > 0) {
        self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
    }
    
    if (self.cityArray.count > 0) {
        self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
    }
    
}

#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArray.count;
    } else if (component == 1) {
        return self.cityArray.count;
    } else {
        return self.townArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [self.provinceArray objectAtIndex:row];
    } else if (component == 1) {
        return [self.cityArray objectAtIndex:row];
    } else {
        return [self.townArray objectAtIndex:row];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return 110;
    } else if (component == 1) {
        return 100;
    } else {
        return 110;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.selectedArray = [self.pickerDic objectForKey:[self.provinceArray objectAtIndex:row]];
        if (self.selectedArray.count > 0) {
            self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
        } else {
            self.cityArray = nil;
        }
        if (self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
        } else {
            self.townArray = nil;
        }
    }
    [pickerView selectedRowInComponent:1];
    [pickerView reloadComponent:1];
    [pickerView selectedRowInComponent:2];
    
    if (component == 1) {
        if (self.selectedArray.count > 0 && self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:row]];
        } else {
            self.townArray = nil;
        }
        [pickerView selectRow:1 inComponent:2 animated:YES];
    }
    
    [pickerView reloadComponent:2];
}

#pragma mark - private method
- (void)showMyPicker:(id)sender {
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.pickerBgView];
    self.maskView.alpha = 0;
    self.pickerBgView.top = self.view.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0.3;
        self.pickerBgView.bottom = self.view.height;
    }];
}

- (void)hideMyPicker {
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0;
        self.pickerBgView.top = self.view.height;
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
        [self.pickerBgView removeFromSuperview];
    }];
}

#pragma mark - xib click

- (IBAction)cancel:(id)sender {
    [self hideMyPicker];
}

- (IBAction)ensure:(id)sender {
    
    [self.leftButton setTitle:[self.provinceArray objectAtIndex:[self.myPicker selectedRowInComponent:0]] forState:UIControlStateNormal];
    [self.centerButton setTitle:[self.cityArray objectAtIndex:[self.myPicker selectedRowInComponent:1]] forState:UIControlStateNormal];
    [self.rightButton setTitle:[self.townArray objectAtIndex:[self.myPicker selectedRowInComponent:2]] forState:UIControlStateNormal];
    [self hideMyPicker];
}
-(void)setlab :(UILabel *)lab{
    lab.textAlignment=NSTextAlignmentCenter;
    lab.adjustsFontSizeToFitWidth=YES;
    lab.textColor=redRGB;
     lab.font= [UIFont fontWithName:@"Helvetica-Bold" size:12];;

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event         {
    [self.view endEditing:YES];
}

@end
