//
//  LJX_HistoryListViewController.m
//  LJXNewsArrive
//
//  Created by a on 2019/4/28.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "LJX_HistoryListViewController.h"
#import "LJX_HisCell.h"
#import "WHUCalendarPopView.h"

@interface LJX_HistoryListViewController () <UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic , strong) WHUCalendarPopView * pop;

@end

@implementation LJX_HistoryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIView getGradientWithFirstColor:NAUIColorWithRGB(0x191970, 1.0) SecondColor:NAUIColorWithRGB(0x4682B4, 1.0) WithView:self.view];
    
    self.title = [NSString stringWithFormat:@"%@年%@月%@日历史",self.dict[@"year"],self.dict[@"month"],self.dict[@"day"]];
    
    [self configUI];
    
//    [self hisRequestData];
    
    [self setupNavRight];
}

/* 历史 */
- (void) hisRequestData {
    __weak typeof (self) weakSelf = self;
    
    [self.hisListDataArray removeAllObjects];

    NSString * url = [NSString stringWithFormat:@"https://api.jisuapi.com/todayhistory/query?appkey=%@&month=%@&day=%@",JSAPPKEY,[NSString stringWithFormat:@"%d",[self.dict[@"month"] intValue]],self.dict[@"day"]];
    
    NSLog(@"hisRequestURL = %@",url);
    
    [LJXRequestTool LJX_requestWithType:LJX_GET URL:url params:nil successBlock:^(id obj) {
        [SVProgressHUD dismiss];
        
        NSLog(@"obj = %@",obj);
        
        if ([obj[@"status"] integerValue] == 0) {
            
            NSMutableArray * array = [LJX_HisModel mj_objectArrayWithKeyValuesArray:obj[@"result"]];
            
            if (array.count > 0) {
                [weakSelf.hisListDataArray addObjectsFromArray:array];
            }
        }
        [weakSelf.tableView reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"error = %@",error);
        [SVProgressHUD dismiss];
    }];
}

- (void) setupNavRight {
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(calendarAction) image:@"calendar-20" highImage:@"calendar-20"];
}

- (void) calendarAction {
    [_pop show];
}

-(void) configUI {
    __weak typeof  (self) weakSelf = self;
    [self.view addSubview: self.tableView];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.navigationController.navigationBar.height);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    _pop = [[WHUCalendarPopView alloc] init];
    _pop.onDateSelectBlk=^(NSDate* date){
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy年MM月dd日"];
        NSString *dateString = [format stringFromDate:date];
        NSLog(@"%@",dateString);
        
        weakSelf.dict = [UIView currentXZWithCurrentDate:dateString];
        
        NSLog(@"当前星座是: %@; %@/年---%@/月---%@/日",weakSelf.dict[@"xz"],weakSelf.dict[@"year"],weakSelf.dict[@"month"],weakSelf.dict[@"day"]);
        
        [weakSelf.hisListDataArray removeAllObjects];
        
        weakSelf.title = [NSString stringWithFormat:@"%@年%@月%@日历史",weakSelf.dict[@"year"],weakSelf.dict[@"month"],weakSelf.dict[@"day"]];
        
        [weakSelf hisRequestData];
    };
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    return self.hisListDataArray.count > 0 ? self.hisListDataArray.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString * cellId = @"hisCell";
    
    LJX_HisCell * listCell = [LJX_HisCell dequeueReusableCellWithTableView:tableView Identifier:cellId];
    
    if (self.hisListDataArray.count > 0) {
        listCell.hisModel = self.hisListDataArray[indexPath.row];
    }
    
    return listCell;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 50;
        _tableView.rowHeight =UITableViewAutomaticDimension;
    }
    return _tableView;
}

-(NSMutableArray *)hisListDataArray{
    if (!_hisListDataArray) {
        _hisListDataArray = @[].mutableCopy;
    }
    return _hisListDataArray;
}


@end
