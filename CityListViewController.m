//
//  CityListViewController.m
//  CityList
//
//  Created by Chen Yaoqiang on 14-3-6.
//
//

#import "CityListViewController.h"
#import "Head.h"
@interface CityListViewController ()

@end

@implementation CityListViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.arrayHotCity = [NSMutableArray arrayWithObjects:@"上海市",@"扬州市",@"南京市",@"池州市", nil];
        self.keys = [NSMutableArray array];
        self.arrayCitys = [NSMutableArray array];
        self.labPoint=[[UILabel alloc]init];
        self.str=[[NSString alloc]init];
    }
    return self;
}
-(UIView*)headView{
    self.labDetail=[[UILabel alloc]init];

    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0,w,40)];
    if([self.str isEqualToString:@""]){
        self.labPoint.frame=CGRectMake(0, 0, 120, 40);
        self.labPoint.text=@"定位失败，请点击重试";
        self.labPoint.adjustsFontSizeToFitWidth=YES;
        self.labPoint.textAlignment=NSTextAlignmentCenter;
        self.labPoint.font=[UIFont systemFontOfSize:14];
        self.labDetail.frame=CGRectMake(120, 0, 60 , 40);
        self.labDetail.font=[UIFont systemFontOfSize:10];
        self.labDetail.text=@"GPS定位";
        self.labDetail.textColor=[UIColor grayColor];
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0,w , 40)];
        btn.tag=1;
        [btn addTarget:self action:@selector(Local:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        [view addSubview:self.labDetail];
        [view addSubview:self.labPoint];
    }else{
        self.labPoint.frame=CGRectMake(0, 0, 80, 40);
        self.labPoint.text=self.str;
        self.labPoint.font=[UIFont systemFontOfSize:14];
        self.labPoint.adjustsFontSizeToFitWidth=YES;
        self.labPoint.textAlignment=NSTextAlignmentCenter;
        self.labDetail.frame=CGRectMake(80 , 0, 60 , 40);
        self.labDetail.text=@"GPS定位";
        self.labDetail.textColor=[UIColor grayColor];
        self.labDetail.font=[UIFont systemFontOfSize:10];
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(0, 0,w , 40)];
        btn1.tag=2;
        [btn1 addTarget:self action:@selector(Local:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn1];

        [view addSubview:self.labDetail];
        [view addSubview:self.labPoint];

    }
    return view;
}
-(void)Local :(UIButton *)sender{
    if(sender.tag==1){
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            
            [[UIApplication sharedApplication] openURL:url];
            
        }
        
    }else if(sender.tag==2){
        [self.delegate locValue:self.str];
        [self back];
    }
}

- (void)viewDidLoad
{
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back )];
    self.title = @"选择地址";

    
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    [super viewDidLoad];
    
    [self getCityData];
    
	// Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
    //_tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorColor = [UIColor colorWithRed:131/255.0 green:219/255.0 blue:209/255.0 alpha:1];
    _tableView.tableHeaderView=[self headView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark - 获取城市数据
-(void)getCityData
{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"citydict"
                                                   ofType:@"plist"];
    self.cities = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    [self.keys addObjectsFromArray:[[self.cities allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    
    //添加热门城市
    NSString *strHot = @"热";
    [self.keys insertObject:strHot atIndex:0];
    [self.cities setObject:_arrayHotCity forKey:strHot];
}

#pragma mark - tableView
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    bgView.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 250, 20)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:12];
    
    NSString *key = [_keys objectAtIndex:section];
    if ([key rangeOfString:@"热"].location != NSNotFound) {
        titleLabel.text = @"热门城市";
    }
    else
        titleLabel.text = key;
    
    [bgView addSubview:titleLabel];
    
    return bgView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"123");
     NSString *key = [_keys objectAtIndex:indexPath.section];
    [self.delegate locValue:[[_cities objectForKey:key] objectAtIndex:indexPath.row]];
    [self back];
    
}  

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _keys;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [_keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSString *key = [_keys objectAtIndex:section];
    NSArray *citySection = [_cities objectForKey:key];
    return [citySection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    NSString *key = [_keys objectAtIndex:indexPath.section];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.textLabel setTextColor:[UIColor colorWithRed:131/255.0 green:219/255.0 blue:209/255.0 alpha:1]];
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    cell.textLabel.text = [[_cities objectForKey:key] objectAtIndex:indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
