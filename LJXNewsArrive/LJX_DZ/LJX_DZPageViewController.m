//
//  LJX_DZPageViewController.m
//  LJXNewsArrive
//
//  Created by a on 2019/4/17.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "LJX_DZPageViewController.h"
#import "LJX_DZListCell.h"
#import "LJX_DZModel.h"

@interface LJX_DZPageViewController () <UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic , strong) NSMutableArray * dataArray;

/* 请求参数数组 */
@property (nonatomic , strong) NSMutableArray * types;

@property (nonatomic , assign) NSInteger page;

@end

@implementation LJX_DZPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTableView];
    
    self.page = 1;

    [self requestData];
    
    [self refresh];
}

- (void) refresh {
    __weak typeof (self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.dataArray removeAllObjects];
        weakSelf.page = 1;
        [weakSelf requestData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf requestData];
    }];
}

- (void) requestData {
    [SVProgressHUD showWithStatus:@"正在加载....."];
    __weak typeof (self) weakSelf = self;
    
    NSString * url = [NSString stringWithFormat:@"%@type=%@&count=%@&page=%@",LJX_DZBaseURL,self.types[self.currentIndex],@"10",[NSString stringWithFormat:@"%ld",(long)self.page]];
    NSLog(@"url= %@",url);

    [LJXRequestTool LJX_requestWithType:LJX_GET URL:url params:nil successBlock:^(id obj) {
        [SVProgressHUD dismiss];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
        NSLog(@"obj = %@",obj);
        
        if ([obj[@"error_code"] integerValue] == 0) {
            NSMutableArray * array = [LJX_DZModel mj_objectArrayWithKeyValuesArray:obj[@"result"]];
            
            if (array.count > 0) {
                [weakSelf.dataArray addObjectsFromArray:array];
            }
            
            if (array.count == 0) {
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            [weakSelf.tableView reloadData];
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"error = %@",error);
        [SVProgressHUD dismiss];
    }];
}

- (void)addTableView{
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
    
    static NSString *CellIdentifier = @"listCell";
    
    LJX_DZListCell * listCell = [LJX_DZListCell dequeueReusableCellWithTableView:tableView Identifier:CellIdentifier];
        
    if (self.dataArray.count > 0) {
        listCell.currentType = self.currentIndex;
        listCell.dzModel = self.dataArray[indexPath.row];
    }
    return listCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.dataArray.count > 0 && self.currentIndex != 2) {
        
        LJX_DZModel * dzModel = self.dataArray[indexPath.row];
    
        [self photoBrowserURL: dzModel.images];
    }
}

- (void) photoBrowserURL :(NSString *)url {
    HZPhotoBrowser *browser = [[HZPhotoBrowser alloc] init];
    browser.isFullWidthForLandScape = YES;
    browser.isNeedLandscape = YES;
    browser.currentImageIndex = 0;
    browser.imageArray = @[
                           [NSString stringWithFormat:@"%@", url]
                           ];
    [browser show];
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
        _types = [NSMutableArray arrayWithObjects:@"image",@"gif",@"text", nil];
    }
    return _types;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
}

@end
