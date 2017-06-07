//
//  editPersonView.m
//  HYB
//
//  Created by CUIZE on 16/8/18.
//  Copyright © 2016年 CUIZE. All rights reserved.
//

#import "editPersonView.h"
#import "Head.h"
#import "AFNetworking.h"
#import "SMProgressHUD.h"
@interface editPersonView ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@end

@implementation editPersonView
-(id)init{
    if(self){
        self=[super init];
    }
    self.dicinfo=[[NSMutableDictionary alloc]init];
    self.backgroundImage=[[UIImageView alloc]init];
   
    return self;
}
- (void)viewDidLoad {
    self.title=@"我的资料";
   UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"zhankaileft"] style:UIBarButtonItemStyleDone target:self action:@selector(viewback)];
    self.navigationItem.leftBarButtonItem=left;

    self.arrinfo=[[NSMutableArray alloc]initWithObjects:[[NSDictionary alloc]initWithObjectsAndKeys:@"4.png",@"pic",@"修改头像",@"textlab",@"",@"detaillab", nil],[[NSDictionary alloc]initWithObjectsAndKeys:@"8.png",@"pic",@"姓名",@"textlab",[self.dicinfo objectForKey:@"realName"],@"detaillab", nil],[[NSDictionary alloc]initWithObjectsAndKeys:@"9.png",@"pic",@"性别",@"textlab",[self.dicinfo objectForKey:@"sex"],@"detaillab", nil],[[NSDictionary alloc]initWithObjectsAndKeys:@"10.png",@"pic",@"所在地区",@"textlab", [self.dicinfo objectForKey:@"address"],@"detaillab", nil], nil];
 
    _imagePickerController1 = [[UIImagePickerController alloc] init];
         _imagePickerController1.delegate = self;
         //相机类型（拍照、录像...）
    _imagePickerController1.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    _imagePickerController1.allowsEditing = YES;
         _imagePickerController1.mediaTypes = @[(NSString *)kUTTypeImage];
 
    
    self.tabedit=[[UITableView alloc]initWithFrame:CGRectMake(0,-64 , w, h+64 ) style:UITableViewStylePlain];
    self.tabedit.delegate=self;
    self.tabedit.dataSource=self;
    self.tabedit.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tabedit.tableHeaderView=[self viewhead];
    [self.view addSubview:self.tabedit];
       [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(UIView *)viewhead{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, w , w)];
    self.backgroundImage.frame=CGRectMake(0, 0, w , w);
    [ view addSubview:self.backgroundImage];
    return view;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrinfo.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str=@"cell";
   PersonTableViewCell  *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil){
        cell=[[PersonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    NSDictionary *dic=self.arrinfo[indexPath.row];
    if(indexPath.row==0){
        cell.image2.image= self.backgroundImage.image;
        cell.image3.image=[UIImage  imageNamed:@"7.png"];
    }
    if(indexPath.row==2){
        cell.image3.image=[UIImage  imageNamed:@"7.png"];
    }
    cell.lab1.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"textlab"]];
    cell.lab2.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"detaillab"] ];
    cell.image1.image=[UIImage imageNamed:[dic objectForKey:@"pic"]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机", @"相册", nil];
        sheet.tag=1;
        [sheet showInView:self.view.window];
    }
    if(indexPath.row==2){
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男", @"女", nil];
        sheet.tag=2;
        [sheet showInView:self.view.window];
    }

}
-(void)viewback{
    [self.imagedelege  back:self.backgroundImage.image];
    [self.navigationController popViewControllerAnimated:YES];
}
//适用获取所有媒体资源，只需判断资源类型
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    if ([self.imagePickerController1  isEqual:picker]){
        NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
        
        //判断资源类型
        if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
            NSLog( @"头像被点击");
            //如果是图片
            UIImageView *imageView=[[UIImageView alloc]init];
            imageView.image = info[UIImagePickerControllerEditedImage];
          
            self.backgroundImage.image=imageView.image;
             
            AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
            [manager POST:picChange  parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                              [formData appendPartWithFileData:UIImageJPEGRepresentation(imageView.image, 0.3) name:@"upfile" fileName:@"text.png" mimeType:@"text/plain"];
            } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
              //  NSLog(@"身份证正面上传== %@", responseObject);
                self.picStr=[ responseObject   objectForKey:@"picUrl"];
                
           
               // NSLog(@"picchange str");

                [self pushpicinfo];
            
            } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                NSLog(@"错误信息=====%@", error);
            }];
            

     
            [self dismissViewControllerAnimated:YES completion:nil];
            
    
         }

    }}


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
        
    }
    
    if(actionSheet.tag==2) {
        if(buttonIndex == 0)
            
        {
            [[SMProgressHUD shareInstancetype] showLoading];
            [self.arrinfo removeAllObjects];
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
                                         @"UserEntity":@{
                                                 @"token":[NSString stringWithFormat:@"%@", [array.lastObject objectForKey:@"token"]],
                                                 @"sex":@"男"
                                                 }
                                         };
            
            
            //发送请求
            [manager POST:changeSex parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [[SMProgressHUD shareInstancetype] dismissLoadingView];
                });

                
                NSDictionary *dic=[responseObject objectForKey:@"Result"];
            //    NSLog(@"%@",dic);
                NSDictionary *dicsex=[dic objectForKey:@"user"];
               // NSLog(@"%@",dic);
                self.arrinfo=[[NSMutableArray alloc]initWithObjects:[[NSDictionary alloc]initWithObjectsAndKeys:@"4.png",@"pic",@"修改头像",@"textlab",@"",@"detaillab", nil],[[NSDictionary alloc]initWithObjectsAndKeys:@"8.png",@"pic",@"姓名",@"textlab",[self.dicinfo objectForKey:@"realName"],@"detaillab", nil],[[NSDictionary alloc]initWithObjectsAndKeys:@"9.png",@"pic",@"性别",@"textlab",[dicsex objectForKey:@"sex"],@"detaillab", nil],[[NSDictionary alloc]initWithObjectsAndKeys:@"10.png",@"pic",@"所在地区",@"textlab", [self.dicinfo objectForKey:@"address"],@"detaillab", nil], nil];
                NSIndexPath *path = [NSIndexPath indexPathForRow:2 inSection:0];
                
              
                [self.tabedit reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];

//[[[UIAlertView alloc]initWithTitle:@"提示信息" message: [dic objectForKey:@"errorMessage"] delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [[SMProgressHUD shareInstancetype] dismissLoadingView];
                });

                NSLog(@"Error: %@", error);
                
                [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"网络异常,请稍后重试"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
                
            }];
 
            
        }
        if(buttonIndex == 1)
        {  [[SMProgressHUD shareInstancetype] showLoading];

            [self.arrinfo removeAllObjects];
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
                                         @"UserEntity":@{
                                                 @"token":[NSString stringWithFormat:@"%@", [array.lastObject objectForKey:@"token"]],
                                                 @"sex":@"女"
                                                 }
                                         };
            
            
            //发送请求
            [manager POST: changeSex  parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [[SMProgressHUD shareInstancetype] dismissLoadingView];
                });

                
                NSDictionary *dic=[responseObject objectForKey:@"Result"];
                NSDictionary *dicsex=[dic objectForKey:@"user"];
               //NSLog(@"%@",dic);
                self.arrinfo=[[NSMutableArray alloc]initWithObjects:[[NSDictionary alloc]initWithObjectsAndKeys:@"修改头像",@"textlab",@"",@"detaillab", nil],[[NSDictionary alloc]initWithObjectsAndKeys:@"姓名",@"textlab",[self.dicinfo objectForKey:@"realName"],@"detaillab", nil],[[NSDictionary alloc]initWithObjectsAndKeys:@"性别",@"textlab",[dicsex objectForKey:@"sex"],@"detaillab", nil],[[NSDictionary alloc]initWithObjectsAndKeys:@"所在地区",@"textlab", [self.dicinfo objectForKey:@"address"],@"detaillab", nil], nil];
                NSIndexPath *path = [NSIndexPath indexPathForRow:2 inSection:0];
                
                // sender.isZan=YES;
                [self.tabedit reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];

               // [[[UIAlertView alloc]initWithTitle:@"提示信息" message: [dic objectForKey:@"errorMessage"] delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [[SMProgressHUD shareInstancetype] dismissLoadingView];
                });

                NSLog(@"Error: %@", error);
                
               [[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"网络异常,请稍后重试"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
                
            }];
            

        }
        
    }

    
    
}
-(void)pushpicinfo{
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
                                 @"UserEntity":@{
                                         @"token":[NSString stringWithFormat:@"%@", [array.lastObject objectForKey:@"token"]],
                                         @"photo":self.picStr
                                         }
                                 };
    
      // NSLog(@"213%@",parameters );
    //发送请求
    [manager POST:PicStr  parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic=[responseObject objectForKey:@"Result"];
       // NSLog(@"////%@",dic);
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
        
        // sender.isZan=YES;
        [self.tabedit reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];

       
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        //[[[UIAlertView alloc]initWithTitle:@"提示信息" message:@"网络出错"  delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil]  show];
        
    }];
}

@end
