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
    
    [LJXRequestTool LJX_requestWithType:LJX_GET URL:url params:nil successBlock:^(id obj) {
        
        NSLog(@"obj = %@",obj);
        if ([obj[@"error_code"] integerValue] == 0) {
            NSMutableArray * array = [LJX_HomeModel mj_objectArrayWithKeyValuesArray:obj[@"result"][@"data"]];
            
            if (array.count > 0) {
                [weakSelf.dataArray addObjectsFromArray:array];
                
            }
            [weakSelf.tableView reloadData];
        }
    } failureBlock:^(NSError *error) {
        
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
    
    LJX_HomePageCell * bussinessManagementCell = [LJX_HomePageCell dequeueReusableCellWithTableView:tableView Identifier:@"bussinessManagementCell"];
    
    bussinessManagementCell.index = indexPath;
    
    bussinessManagementCell.homeListModel = self.dataArray[indexPath.row];
    
    return bussinessManagementCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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

@end
