//
//  BBSSecondViewController.m
//  cate
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 张衡. All rights reserved.
//
#define kBBSsecond @"http://apis.znw.me/index.php/Moment/moments/get/channel/mid/1294487/isTable/0/appid/3/mk/4406fd692c2b9d550ef7e807c601c503/p/1"
#import "BBSSecondViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "Header.h"
#import "BBSSecondModel.h"
#import <UIImageView+WebCache.h>
#import "BBSSecondTableViewCell.h"
@interface BBSSecondViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *des;
@property (weak, nonatomic) IBOutlet UILabel *biaoti;
@property (weak, nonatomic) IBOutlet UILabel *renqi;
@property (weak, nonatomic) IBOutlet UILabel *neirong;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) NSMutableDictionary *dictionary;
@property (nonatomic, strong) NSMutableArray *textArray;
@property (nonatomic, strong) NSMutableArray *nameArray;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong)NSMutableArray *allarray;
@end

@implementation BBSSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //请求头部标题
    [self workOne];
    [self workTwo];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kwidth, kheight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.headView;
    self.tableView.rowHeight = 395;
        [self.tableView registerNib:[UINib nibWithNibName:@"BBSSecondTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.nameArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BBSSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.allarray[indexPath.section][indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}



- (void)workOne{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger POST:@"http://apis.znw.me/index.php/Channel/channel?" parameters:@{@"mid":@"1294487",@"channelId":self.channelid,@"appid":@"3",@"mk":@"44064406fd692c2b9d550ef7e807c601c503"} progress:^(NSProgress * _Nonnull uploadProgress) {
//        ZHLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        ZHLog(@"%@",responseObject);
        NSDictionary *dic = responseObject;
        NSString *message = dic[@"message"];
       NSArray *data = dic[@"data"];
        if ([message isEqualToString:@"操作成功"]) {
            self.dictionary = data[0];
           self.des.text = self.dictionary[@"des"];
            NSString *ima = self.imagee;
            NSString *ima2 = [ima stringByReplacingOccurrencesOfString:@"webp" withString:@"jpg"];
            [self.headImage sd_setImageWithURL:[NSURL URLWithString:ima2] placeholderImage:nil];
            self.renqi.text = [NSString stringWithFormat:@"人气:%@",_dictionary[@"follower_count"]];
            self.neirong.text = [NSString stringWithFormat:@"内容:%@",_dictionary[@"moment_count"]];
            self.biaoti.text = self.dictionary[@"subject"];
                        }
                 [self.tableView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        ZHLog(@"%@",error);
    }];
}
- (void)workTwo{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger GET:[NSString stringWithFormat:@"%@/channelId/%@",kBBSsecond,self.channelid] parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
//        ZHLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //ZHLog(@"%@",responseObject);
        NSDictionary *dic = responseObject;
        NSString *message = dic[@"message"];
        NSArray *data = dic[@"data"];
       
        if ([message isEqualToString:@"操作成功"]) {
            for (NSDictionary *dic1 in data) {
                BBSSecondModel *model = [[BBSSecondModel alloc] initWithDictionary:dic1];
                [self.textArray addObject:model];
                
                
//                [self.textArray addObject:dic1[@"text"]];
                NSMutableDictionary *dic2 = dic1[@"fromUser"];
                
                BBSSecondModel *model1 = [[BBSSecondModel alloc] initWithDictionary:dic2];
                [self.nameArray addObject:model1];
                
                //[self.nameArray addObject:dic2[@"name"]];
                for (NSDictionary *dic3 in dic1[@"images"]) {
                    
                    BBSSecondModel *model2 = [[BBSSecondModel alloc] initWithDictionary:dic3];
                    [self.imageArray addObject:model2];
                    
                   // [self.imageArray addObject:dic3[@"large"]];
                }
               
            }
            [self.allarray addObject:self.textArray];
            [self.allarray addObject:self.nameArray];
            [self.allarray addObject:self.imageArray];

             //ZHLog(@"%@",self.textArray);
            //ZHLog(@"%@",self.allarray);
            [self.tableView reloadData];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        ZHLog(@"%@",error);
    }];
}
- (NSMutableArray *)allarray{
    if (_allarray == nil) {
        self.allarray = [NSMutableArray new];
    }
    return _allarray;
}
- (NSMutableArray *)imageArray{
    if (_imageArray == nil) {
        self.imageArray = [NSMutableArray new];
    }
    return _imageArray;
}
- (NSMutableArray *)nameArray{
    if (_nameArray == nil) {
        self.nameArray = [NSMutableArray new];
    }
    return _nameArray;
}
- (NSMutableDictionary *)dictionary{
    if (_dictionary == nil) {
        self.dictionary = [NSMutableDictionary new];
    }
    return _dictionary;
}
- (NSMutableArray *)array{
    if (_array == nil) {
        self.array = [NSMutableArray new];
    }
    return _array;
}
- (NSMutableArray *)textArray{
    if (_textArray == nil) {
        self.textArray = [NSMutableArray new];
    }
    return _textArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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