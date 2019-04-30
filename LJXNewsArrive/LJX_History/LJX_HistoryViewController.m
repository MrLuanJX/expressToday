//
//  LJX_HistoryViewController.m
//  LJXNewsArrive
//
//  Created by a on 2019/4/25.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "LJX_HistoryViewController.h"
#import "LJX_DZListCell.h"
#import "LJX_HLCell.h"
#import "LJX_XZCell.h"
#import "LJX_HisCell.h"

#import "LJX_XZModel.h"
#import "LJX_HisModel.h"
#import "LJX_HLModel.h"

#import "LJX_SectionHeaderView.h"
#import "LJX_HistoryListViewController.h"
#import "LJX_HLViewController.h"
#import "LJX_PostViewController.h"
#import "LLWPlusPopView.h"

@interface LJX_HistoryViewController () <UITableViewDelegate , UITableViewDataSource>


@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic , strong) NSMutableArray * hisDataArray;

@property (nonatomic , copy) NSDictionary * dict;

@property (nonatomic , strong) LJX_XZModel * xzModel;

@property (nonatomic , strong) LJX_HLModel * hlModel;

@end

@implementation LJX_HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIView getGradientWithFirstColor:NAUIColorWithRGB(0x191970, 1.0) SecondColor:NAUIColorWithRGB(0x4682B4, 1.0) WithView:self.view];
    
    [self configUI];
        
    self.dict = [UIView currentXZWithCurrentDate:[UIView getCurrentTimes]];
    
    [self dataListRequest];
}

#pragma mark 数据请求
-(void)dataListRequest{
    NSOperationQueue * operationQueue = [[NSOperationQueue alloc]init];
    operationQueue.maxConcurrentOperationCount = 1;
    [operationQueue addOperationWithBlock:^{
        [self hlRequestData];
    }];
    [operationQueue addOperationWithBlock:^{
        [self xzRequestData];
    }];
    [operationQueue addOperationWithBlock:^{
        [self hisRequestData];
    }];    
}

/* 黄历 */
- (void) hlRequestData {
    __weak typeof (self) weakSelf = self;

    NSString * url = [NSString stringWithFormat:@"https://api.jisuapi.com/huangli/date?appkey=%@&year=%@&month=%@&day=%@",JSAPPKEY,self.dict[@"year"],self.dict[@"month"],self.dict[@"day"]];
    
    NSLog(@"hlRequestURL = %@",url);
    
    [LJXRequestTool LJX_requestWithType:LJX_GET URL:url params:nil successBlock:^(id obj) {
        [SVProgressHUD dismiss];

        NSLog(@"obj = %@",obj);
        
        if ([obj[@"status"] integerValue] == 0) {
            weakSelf.hlModel = [LJX_HLModel mj_objectWithKeyValues:obj[@"result"]];
        }
        
//        [weakSelf.tableView reloadData];
        // 类似单选题的多选一、某个section的headerView的大小自适应等，需要重新刷新或布局
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:1];
        [weakSelf.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    } failureBlock:^(NSError *error) {
        NSLog(@"error = %@",error);
        [SVProgressHUD dismiss];
    }];
}

/* 星座 */
- (void) xzRequestData {
    __weak typeof (self) weakSelf = self;

    /* URLDefine  */
    NSString * url = [NSString stringWithFormat:@"http://web.juhe.cn:8080/constellation/getAll?key=%@&consName=%@&type=today",JHXZAPPKEY,self.dict[@"xz"]];
    
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%^{}\"[]|\\<> "].invertedSet];
    
    NSLog(@"xzRequestURL = %@",url);

    [LJXRequestTool LJX_requestWithType:LJX_GET URL:url params:nil successBlock:^(id obj) {
        [SVProgressHUD dismiss];
        
        NSLog(@"xzObj = %@",obj);
        
        if ([obj[@"error_code"] integerValue] == 0) {
            weakSelf.xzModel = [LJX_XZModel mj_objectWithKeyValues:obj];
            NSLog(@"xzModel = %@",self.xzModel);
        }
        
//        [weakSelf.tableView reloadData];
        // 类似单选题的多选一、某个section的headerView的大小自适应等，需要重新刷新或布局
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
        [weakSelf.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    } failureBlock:^(NSError *error) {
        NSLog(@"error = %@",error);
        [SVProgressHUD dismiss];
    }];
}

/* 历史 */
- (void) hisRequestData {
    __weak typeof (self) weakSelf = self;
    
    NSString * url = [NSString stringWithFormat:@"https://api.jisuapi.com/todayhistory/query?appkey=%@&month=%@&day=%@",JSAPPKEY,[NSString stringWithFormat:@"%d",[self.dict[@"month"] intValue]],self.dict[@"day"]];
    
    NSLog(@"hisRequestURL = %@",url);
    
    [LJXRequestTool LJX_requestWithType:LJX_GET URL:url params:nil successBlock:^(id obj) {
        [SVProgressHUD dismiss];
        
        NSLog(@"obj = %@",obj);
        
        if ([obj[@"status"] integerValue] == 0) {
        
            NSMutableArray * array = [LJX_HisModel mj_objectArrayWithKeyValuesArray:obj[@"result"]];
            
            if (array.count > 0) {
                [weakSelf.hisDataArray addObjectsFromArray:array];
            }

//            [weakSelf.tableView reloadData];
            // 类似单选题的多选一、某个section的headerView的大小自适应等，需要重新刷新或布局
            NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:2];
            [weakSelf.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"error = %@",error);
        [SVProgressHUD dismiss];
    }];
}

-(void) configUI {
    __weak typeof  (self) weakSelf = self;
    
    [self.view addSubview: self.tableView];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.navigationController.navigationBar.height);
        make.left.right.bottom.mas_equalTo(0);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 3;
    }else
        return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    static NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    return cell;
    */
    if (indexPath.section == 2) {           // 今日历史
        LJX_HisCell * listCell = [LJX_HisCell dequeueReusableCellWithTableView:tableView Identifier:@"hisListCell"];
        
        if (self.hisDataArray.count > 0) {
            listCell.hisModel = self.hisDataArray[indexPath.row];
        }
        
        return listCell;
    } else if (indexPath.section == 0) {    // 今日星座
        LJX_XZCell * xzCell = [LJX_XZCell dequeueReusableCellWithTableView:tableView Identifier:@"xzCell"];

        xzCell.xzModel = self.xzModel;

        return xzCell;
    } else {                                // 今日黄历
        LJX_HLCell * hlCell = [LJX_HLCell dequeueReusableCellWithTableView:tableView Identifier:@"hlCell" cellTag:0];
                
        hlCell.hlModel = self.hlModel;
        
        return hlCell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    __weak typeof (self) weakSelf = self;
    LJX_SectionHeaderView * sectionH = [LJX_SectionHeaderView new];
    sectionH.index = section;
    sectionH.moreBtnActionBlock = ^(NSInteger index) {
        NSLog(@"当前点击了第%ld区",(long)index);
        
        if (index == 2) {
            dispatch_async(dispatch_get_main_queue(), ^{
                LJX_HistoryListViewController * hisListVC = [LJX_HistoryListViewController new];
                hisListVC.dict = weakSelf.dict;
                hisListVC.hisListDataArray = weakSelf.hisDataArray;
                [weakSelf.navigationController pushViewController:hisListVC animated:YES];
            });
        } else {
            LJX_HLViewController * hlVC = [LJX_HLViewController new];
            hlVC.dict = weakSelf.dict;
            hlVC.hlModel = weakSelf.hlModel;
            [weakSelf.navigationController pushViewController:hlVC animated:YES];
        }
    };
    return sectionH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return NAFit(50);
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

-(NSMutableArray *)hisDataArray{
    if (!_hisDataArray) {
        _hisDataArray = @[].mutableCopy;
    }
    return _hisDataArray;
}

- (LJX_XZModel *)xzModel {
    if (!_xzModel) {
        _xzModel = [LJX_XZModel new];
    }
    return _xzModel;
}

@end
