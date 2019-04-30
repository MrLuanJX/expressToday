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
#import "LJX_FeedbackViewController.h"
#import "LJX_SetupViewController.h"

static CGFloat const imageBGHeight = 200; // 背景图片的高度
static NSString * const identifier = @"cell"; // cell重用标识符

@interface LJX_MineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic , strong) LJX_MineModel * model;
@property (nonatomic , strong) UITableView * tableView;
@property (nonatomic , strong) UIImageView *imageBG;
@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) LJX_MineFooterView * footView;
@property (nonatomic , assign) CGFloat fileSize;

@end

@implementation LJX_MineViewController

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTableView];
    
    NSString *libPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    self.fileSize = [self folderSizeAtPath:libPath];
    
}

- (void)setupNav {
    
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
    
    mineCell.folderSize = [NSString stringWithFormat:@"%.2lf",self.fileSize];
    
    return mineCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[LJX_SetupViewController new] animated:YES];
    }
    
    if (indexPath.row == 1) {
        [self.navigationController pushViewController:[LJX_FeedbackViewController new] animated:YES];
    }
    
    if (indexPath.row == 2) {
        [self.navigationController pushViewController:[LJX_AboutViewController new] animated:YES];
    }
    
    if (indexPath.row == 3) {
        [self clearFile];
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
        NSArray *title = @[@"设置",@"意见反馈",@"关于我们",@"清理缓存",@"当前版本"];
        NSArray *icon = @[@"icon_idphoto",@"icon_feedback",@"icon_about",@"icon_handle",@"icon_appointment"];
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

- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

- (long long)fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

#pragma mark - 清理缓存

- (void) clearFile {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSLog(@"%@", cachPath);
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
        NSLog(@"files : %lu",(unsigned long)[files count]);
        
        for (NSString * p in files) {
            NSError *error;
            
            NSString *path = [cachPath stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
        
        [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];
    });
}

-(void)clearCacheSuccess{
    NSLog(@"清理成功");
    [SVProgressHUD showSuccessWithStatus:@"清理成功"];
    self.fileSize = 0;
    [self.tableView reloadData];
}
@end
