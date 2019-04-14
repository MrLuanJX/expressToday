//
//  LJX_HomeViewController.m
//  LJXNewsArrive
//
//  Created by 栾金鑫 on 2019/4/13.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "LJX_HomeViewController.h"
#import "LJX_HomePageViewController.h"

@interface LJX_HomeViewController ()<WMPageControllerDataSource,WMPageControllerDelegate>

@property (nonatomic , strong) NSMutableArray * models;

@property (nonatomic , assign) NSInteger currentIndex;

@end

@implementation LJX_HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    [self configUI];
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.itemMargin = 10;
        self.selectIndex = 0;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.automaticallyCalculatesItemWidths = YES;
        self.titleColorSelected = NAUIColorWithRGB(0x3D79FD, 1.0);
        self.menuView.height = NAFit(50);
    }
    return self;
}

#pragma mark - configUI
- (void)configUI {
    self.delegate = self;
    self.dataSource = self;
    self.automaticallyCalculatesItemWidths = YES;
    
}

#pragma mark - WMPageController 的代理方法
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    if (self.models.count == 0 || !self.models) {
        return 0;
    }
    return self.models.count;
}

- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    LJX_HomePageViewController * detailVC = [[LJX_HomePageViewController alloc]init];
    
    if (index > self.models.count) {
        return  [[LJX_HomePageViewController alloc]init];
    }
    
    detailVC.currentIndex = index;
    
    return detailVC;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.models[index];
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
    return CGRectMake(leftMargin, originY, self.view.frame.size.width - 2*leftMargin, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}

#pragma mark - WMMenuView 的代理方法
- (void)menuView:(WMMenuView *)menu didSelesctedIndex:(NSInteger)index currentIndex:(NSInteger)currentIndex {
    [super menuView:menu didSelesctedIndex:index currentIndex:currentIndex];
}

-(NSMutableArray *)models{
    if (!_models) {
        _models = [NSMutableArray arrayWithObjects:@"头条",@"社会",@"国内",@"国际",@"娱乐",@"体育",@"军事",@"科技",@"财经",@"时尚", nil];
    }
    return _models;
}

@end
