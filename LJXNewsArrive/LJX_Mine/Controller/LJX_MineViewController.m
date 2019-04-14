//
//  LJX_MineViewController.m
//  LJXNewsArrive
//
//  Created by 栾金鑫 on 2019/4/13.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "LJX_MineViewController.h"
#import "LJX_MineCell.h"
#import "LJX_MineModel.h"
#import "LJX_MineListModel.h"
#import "LJX_MineFooterView.h"
#import "LJX_AboutViewController.h"

static CGFloat const imageBGHeight = 200; // 背景图片的高度
static NSString * const identifier = @"cell"; // cell重用标识符

@interface LJX_MineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic , strong) LJX_MineModel * model;
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) UIImageView *imageBG;
@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) LJX_MineFooterView * footView;

@end

@implementation LJX_MineViewController

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTableView];
}

- (void)setupNav {
    self.automaticallyAdjustsScrollViewInsets=NO; // 不自动切64
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.navigationItem.titleView = self.titleLabel;
}

-(void)setupTableView {
    
    __weak typeof (self) weakSelf = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
    
    [self.tableView addSubview:self.imageBG];
}

#pragma mark - tableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.model.list;
    return arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    LJX_MineCell * mineCell = [LJX_MineCell dequeueReusableCellWithTableView:tableView Identifier:@"cell"];
   
    mineCell.index = indexPath;
    
    mineCell.mineModel = self.model.list[indexPath.row];
    
    return mineCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[LJX_AboutViewController new] animated:YES];
    }
}

#pragma mark -  重点的地方在这里 滚动时候进行计算
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat offsetH = imageBGHeight + offsetY ;
    if (offsetH < 0) {
        CGRect frame = self.imageBG.frame;
        frame.size.height = imageBGHeight - offsetH;
        frame.origin.y = -imageBGHeight + offsetH;
        self.imageBG.frame = frame;
    }
    
    CGFloat alpha = offsetH / imageBGHeight;
    
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[[UIColor whiteColor] colorWithAlphaComponent:alpha]] forBarMetrics:UIBarMetricsDefault];
    self.titleLabel.alpha = alpha;
}

#pragma mark - privateLazy
- (UIImageView *)imageBG {
    if (_imageBG == nil) {
        _imageBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BGimage.jpg"]];
        _imageBG.frame = CGRectMake(0, -imageBGHeight, NAScreenW, imageBGHeight);
        _imageBG.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageBG;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.frame = [UIScreen mainScreen].bounds;
        _tableView.contentInset = UIEdgeInsetsMake(imageBGHeight, 0, self.tabBarHeight, 0);
        _tableView.tableFooterView = [UIView new];//self.footView;
        _tableView.estimatedRowHeight = 50;
    }
    return _tableView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = NAUIColorWithRGB(0x282828,1.0);
        [_titleLabel sizeToFit];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.alpha = 0;
        _titleLabel.font = NAFontSize(18);
        _titleLabel.text = @"我的";
    }
    return _titleLabel;
}

#pragma mark - 返回一张纯色图片
/** 返回一张纯色图片 */
- (UIImage *)imageWithColor:(UIColor *)color {
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return theImage;
}

-(LJX_MineModel *)model{
    if (!_model) {
        _model = [LJX_MineModel new];
        
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        NSArray *title = @[@"我的证照",@"我的办理",@"我的预约",@"我的订单",@"修改密码",@"当前版本号"];
        NSArray *icon = @[@"icon_idphoto",@"icon_handle",@"icon_appointment",@"icon_order",@"icon_feedback",@"icon_about"];
        for (int i = 0; i < title.count; i++) {
            LJX_MineListModel *listModel = [[LJX_MineListModel alloc]init];
            listModel.name = title[i];
            listModel.icon = icon[i];
            [arr addObject:listModel];
        }
        _model.list = arr;
    }
    return _model;
}

//-(LJX_MineFooterView *)footView{
//    if (!_footView) {
//        _footView = [LJX_MineFooterView new];
//    }
//    return _footView;
//}

@end
