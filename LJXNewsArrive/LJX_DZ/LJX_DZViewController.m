//
//  LJX_DZViewController.m
//  LJXNewsArrive
//
//  Created by a on 2019/4/17.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "LJX_DZViewController.h"
#import "LJX_DZPageViewController.h"

@interface LJX_DZViewController () <WMPageControllerDataSource,WMPageControllerDelegate>

@property (nonatomic , strong) NSMutableArray * models;

@property (nonatomic , assign) NSInteger currentIndex;

@end

@implementation LJX_DZViewController

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
    LJX_DZPageViewController * detailVC = [[LJX_DZPageViewController alloc]init];
    
    if (index > self.models.count) {
        return  [[LJX_DZPageViewController alloc]init];
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
        _models = [NSMutableArray arrayWithObjects:@"图说",@"搞笑动图",@"段子", nil];
    }
    return _models;
}


@end
