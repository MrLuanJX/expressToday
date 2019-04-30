//
//  LJX_HomePageViewController.m
//  LJXNewsArrive
//
//  Created by 栾金鑫 on 2019/4/13.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "LJX_HomePageViewController.h"
#import "LJX_HomePageCell.h"
#import "LJX_HomeBaseModel.h"
#import "LJX_HomeModel.h"
#import "LJX_HomeDetailViewController.h"
#import "LJX_LeftHomePageCell.h"
#import "LJX_RightHomePageCell.h"

@interface LJX_HomePageViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic , strong) NSMutableArray * dataArray;

@property (nonatomic , strong) NSMutableArray * types;

@property (nonatomic , strong) LJX_HomeBaseModel * homeBaseModel;

@property (nonatomic , assign) NSInteger requestIndex;

@end

@implementation LJX_HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self addTableView];

    self.requestIndex = self.currentIndex;

    [self requestData];
}

- (void)requestData {
    __weak typeof (self) weakSelf = self;
    
    [self.dataArray removeAllObjects];
    
    NSString * url = [NSString stringWithFormat:@"%@?type=%@&key=%@",JHHomeList,self.types[self.currentIndex],JHAPPKEY];
    NSLog(@"url= %@",url); 
    [SVProgressHUD showWithStatus:@"正在加载....."];

    [LJXRequestTool LJX_requestWithType:LJX_GET URL:url params:nil successBlock:^(id obj) {
        [SVProgressHUD dismiss];
        NSLog(@"obj = %@",obj);
        if ([obj[@"error_code"] integerValue] == 0) {
            NSMutableArray * array = [LJX_HomeModel mj_objectArrayWithKeyValuesArray:obj[@"result"][@"data"]];
            
            if (array.count > 0) {
                [weakSelf.dataArray addObjectsFromArray:array];
                
            }
            [weakSelf.tableView reloadData];
        }
    } failureBlock:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

-(void)addTableView{
    __weak typeof (self) weakSelf = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count > 0 ? self.dataArray.count : 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LJX_HomeModel * homeModel = [LJX_HomeModel new];
    if (self.dataArray.count > 0) {
        homeModel = self.dataArray[indexPath.row];
    }
    
    if (NANULLString(homeModel.thumbnail_pic_s02) || NANULLString(homeModel.thumbnail_pic_s03)) {
        // 随机数
        int value = arc4random() % (2);;
        if (value == 0) {
            LJX_LeftHomePageCell * leftCell = [LJX_LeftHomePageCell dequeueReusableCellWithTableView:tableView Identifier:@"leftCell"];
            if (self.dataArray.count > 0) {
                leftCell.homeListModel = self.dataArray[indexPath.row];
            }
            return leftCell;
        } else {
            LJX_RightHomePageCell * rightCell = [LJX_RightHomePageCell dequeueReusableCellWithTableView:tableView Identifier:@"rightCell"];
            if (self.dataArray.count > 0) {
                rightCell.homeListModel = self.dataArray[indexPath.row];
            }
            return rightCell;
        }
    } else{
        
        LJX_HomePageCell * bussinessManagementCell = [LJX_HomePageCell dequeueReusableCellWithTableView:tableView Identifier:@"bussinessManagementCell"];
        
        bussinessManagementCell.index = indexPath;
        
        if (self.dataArray.count > 0) {
            bussinessManagementCell.homeListModel = self.dataArray[indexPath.row];
        }
        return bussinessManagementCell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.dataArray.count > 0) {
        LJX_HomeModel * homeModel = self.dataArray[indexPath.row];
        LJX_HomeDetailViewController * detailVC = [LJX_HomeDetailViewController new];
        detailVC.url = homeModel.url;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

- (LJX_HomeBaseModel *)homeBaseModel {
    if (!_homeBaseModel) {
        _homeBaseModel = [LJX_HomeBaseModel new];
    }
    return _homeBaseModel;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 50;
    }
    return _tableView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}

-(NSMutableArray *)types{
    if (!_types) {
        _types = [NSMutableArray arrayWithObjects:@"top",@"shehui",@"guonei",@"guoji",@"yule",@"tiyu",@"junshi",@"keji",@"caijing",@"shishang", nil];
    }
    return _types;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

@end
