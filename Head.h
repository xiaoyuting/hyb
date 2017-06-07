//
//  Head.h
//  HIYAOXYT
//
//  Created by CUIZE on 16/5/23.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#ifndef Head_h
#define Head_h
#import "UIView+RGSize.h"
 
 
#define kScreen_Height      ([UIScreen mainScreen].bounds.size.height)
#define kScreen_Width       ([UIScreen mainScreen].bounds.size.width)
#define kScreen_Frame       (CGRectMake(0, 0 ,kScreen_Width,kScreen_Height))
#define  w     [[UIScreen mainScreen]bounds].size.width
#define  h      [[UIScreen mainScreen]bounds].size.height
#define  rc    195/255.0
#define gc    80/255.0
#define bc     82/255.0
#define backRGB   [UIColor colorWithRed:129/255.0 green:129/255.0 blue:129/255.0 alpha:1]
#define garyRGB   [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1]
#define lineRGB   [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1]

//[UIColor colorWithRed:195/255.0 green:80/255.0 blue:82/255.0 alpha:1];
#define  redRGB  [[UIColor alloc]initWithRed:rc green:gc  blue:bc alpha:1]
#define IPproduce           @"http://139.196.253.143:6060"
//#define IPproduce           @"http://buy.hiyo.cc:5050"
#define OrderIP  @"wxtest"
//#define OrderIP  @"proxy"

#define  Load            [NSString stringWithFormat:@"%@/user/service/rest/user/loginhiyobao.json",IPproduce]//登录接口
#define  getNumb         [NSString stringWithFormat:@"%@/user/service/rest/user/sendcode",IPproduce]//获取验证码
#define getBackPassword  [NSString stringWithFormat:@"%@/user/service/rest/user/resetuserpassword.json",IPproduce]//找回密码
#define  Register        [NSString stringWithFormat:@"%@/user/service/rest/user/registermerchant.json",IPproduce]//注册接口
#define picChange        [NSString stringWithFormat:@"%@/user/upLoadPhoto?fileFolder=upoload",IPproduce]//上传图片
#define PersonInfo       [NSString stringWithFormat:@"%@/user/service/rest/user/getuserdetail.json",IPproduce]//个人信息
#define Notification     [NSString stringWithFormat:@"%@/user/service/rest/message/gethymessageList.json",IPproduce]//消息通知
#define upfile           [NSString stringWithFormat:@"%@/user/service/rest/user/authenticationname.json",IPproduce]//上传验证资料
#define BankCard         [NSString stringWithFormat:@"%@/user/service/rest/account/getaccountbank.json",IPproduce]//银行卡信息
#define MoneyPerson      [NSString stringWithFormat:@"%@/user/service/rest/account/getaccount.json",IPproduce]//个人余额
#define Moneymessage     [NSString stringWithFormat:@"%@/user/service/rest/account/getaccountopertion.json",IPproduce]//卖出记录
#define changeCard       [NSString stringWithFormat:@"%@/user/service/rest/account/updateaccountbank.json",IPproduce]//修改支付宝银行卡
#define PushMoney        [NSString stringWithFormat:@"%@/user/service/rest/account/witndrawlist.json",IPproduce]//提现记录
#define changeSex        [NSString stringWithFormat:@"%@/user/service/rest/user/updateuser.json",IPproduce]//修改性别
#define PicStr           [NSString stringWithFormat:@"%@/user/service/rest/user/updateuser.json",IPproduce]//图片地址
#define cheakPersonInfo   [NSString stringWithFormat:@"%@/user/service/rest/user/checkauthentication.json",IPproduce]//身份认证进度
#define BuyTicket         [NSString stringWithFormat:@"http://piaowu.hiyo.cc/%@/doProxy",OrderIP]//门票信息
#define PriceRule        [NSString stringWithFormat:@"%@/ponline/service/rest/shopproduct/getrules.json",IPproduce]//改价规则
#define Order            [NSString stringWithFormat:@"%@/user/service/rest/transit/transittoorder.json",IPproduce]//下单
#define PayResult        [NSString stringWithFormat:@"http://piaowu.hiyo.cc/%@/doProxy",OrderIP]//支付结果
#define PushPersonInfo    [NSString stringWithFormat:@"%@/user/service/rest/user/authenticationname.json",IPproduce]//提交认证资料
#define cheaKappversion   [NSString stringWithFormat:@"%@/user/service/rest/user/checkversion.json",IPproduce]//检测版本

 //[NSString stringWithFormat:@"http://piaowu.hiyo.cc/%@/doProxy",Order]
#endif /* Head_h */
