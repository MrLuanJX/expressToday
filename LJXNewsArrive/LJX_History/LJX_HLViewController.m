//
//  LJX_HLViewController.m
//  LJXNewsArrive
//
//  Created by a on 2019/4/29.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "LJX_HLViewController.h"
#import "WHUCalendarPopView.h"
#import "LJX_HLCell.h"

@interface LJX_HLViewController () <UITableViewDataSource , UITableViewDelegate>

@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic , strong) WHUCalendarPopView * pop;


@end

@implementation LJX_HLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
     self.title = [NSString stringWithFormat:@"%@年%@月%@日运势",self.dict[@"year"],self.dict[@"month"],self.dict[@"day"]];
    
    [self setupNavRight];
    
    [self configUI];
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
        
        weakSelf.title = [NSString stringWithFormat:@"%@年%@月%@日历史",weakSelf.dict[@"year"],weakSelf.dict[@"month"],weakSelf.dict[@"day"]];
        
        [weakSelf hlRequestData];
    };
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellId = @"hlCell";
    
    LJX_HLCell * listCell = [LJX_HLCell dequeueReusableCellWithTableView:tableView Identifier:cellId cellTag:1];
    
    listCell.hlModel = self.hlModel;
    
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


@end
