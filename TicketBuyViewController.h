//
//  TicketBuyViewController.h
//  HYB
//
//  Created by CUIZE on 16/8/5.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Head.h"
#import "TableViewCellTicket.h"
#import "AFNetworking.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "buyTicketView.h"
#import "SXButton.h"
#import "CityListViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "SMProgressHUD.h"
@interface TicketBuyViewController : UIViewController
@property UISegmentedControl *seg;
@property UITableView *tab1;
@property UITableView *tab2;
@property UITableView *tab3;
@property UIScrollView *scrollview;
@property NSMutableArray *arr1;
@property NSMutableArray *arr2;
@property  NSString *strID;
@property UIButton *btn1;
@property UIButton *btn2;
@property (nonatomic,strong)SXButton *letfButton;
-(void)locValue:(NSString *)strloction;
@property NSString *localString;
@property CLLocationManager *locationManager;
@property(nonatomic,strong)CLGeocoder *geocoder;


@property (nonatomic,strong)NSString *localtext;
@property   UILabel *detailAddressLabel;
@property NSString *strlocal;
@property   UIAlertView *alert; 
//-(void)locValue:(NSString *)strloction;
@property UITextField * addressField;
@property UILabel    *latitudeLabel;
@property UILabel *longitudeLabel;
@property NSString *localID;
@end
