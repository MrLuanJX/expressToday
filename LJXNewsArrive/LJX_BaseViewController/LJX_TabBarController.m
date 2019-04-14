//
//  LJX_TabBarController.m
//  LJXNewsArrive
//
//  Created by 栾金鑫 on 2019/4/13.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "LJX_TabBarController.h"
#import "LJX_NavigationViewController.h"
#import "LJX_HomeViewController.h"
#import "LJX_MineViewController.h"

@interface LJX_TabBarController ()<UITabBarControllerDelegate>

@end

@implementation LJX_TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createTab];
}

-(void) createTab{
    LJX_HomeViewController  * homeVC=[LJX_HomeViewController new];
    LJX_MineViewController *mineVC = [LJX_MineViewController new];
    
    LJX_NavigationViewController * homeNav=[self createVC:homeVC Title:@"首页" imageName:@"home_normal" SelectImageName:@"home_highlight"];
    LJX_NavigationViewController * mineNav=[self createVC:mineVC Title:@"我的" imageName:@"account_normal" SelectImageName:@"account_highlight"];
    
    self.viewControllers = @[homeNav,mineNav];
    
    [self.tabBar setShadowImage:[UIImage imageWithColor:NAUIColorWithRGB(0xE0E0E0, 1.0)]];
    
    [self.tabBar setBackgroundImage:[[UIImage alloc]init]];
    
    [self setItems];
    
    self.delegate = self;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
}

#pragma mark 判断是否登录若没登录跳转到登录页面
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    //判断点击的tabBarItem的title是不是 借款，如果是继续执行
    /*
     if (NULLString([UserTool objectForKey:Cust_NO])) {
     //        ZHLogInViewController * logVC = [[ZHLogInViewController alloc] init];
     //        [((ZHNavigationController *)tabBarController.selectedViewController) pushViewController:logVC animated:YES];
     ZHHLoginView *loginView = [ZHHLoginView showLoginView];
     [loginView show];
     return NO;
     }
     return YES;
     */

    return YES;
}

#pragma mark - 修改TabBar高度
- (void)viewWillLayoutSubviews{
    
    CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
    tabFrame.size.height = 55;
    tabFrame.origin.y = NAScreenH- 55;
    if (KIsiPhoneX) {
        tabFrame.size.height=89;
        tabFrame.origin.y = NAScreenH- 89;
    }
    self.tabBar.frame = tabFrame;
    self.tabBar.backgroundColor=[UIColor whiteColor];
}

#pragma mark - private method
- (LJX_NavigationViewController *)createVC:(UIViewController *)vc Title:(NSString *)title imageName:(NSString *)imageName SelectImageName:(NSString*)selectName{
    
    LJX_NavigationViewController * NVI =[[LJX_NavigationViewController alloc]initWithRootViewController:vc];
    vc.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    return NVI;
}

/**
 *  设置item文字属性
 */
- (void)setItems{
    //设置文字属性
    NSMutableDictionary *attrsNomal = [NSMutableDictionary dictionary];
    //文字颜色
    attrsNomal[NSForegroundColorAttributeName] =  NAUIColorWithRGB(0x333333, 1.0);
    //文字大小
    attrsNomal[NSFontAttributeName] = NAFontSize(10);
    NSMutableDictionary *attrsSelected = [NSMutableDictionary dictionary];
    //选中文字颜色
    attrsSelected[NSForegroundColorAttributeName] = NAThemeColor;
    //统一整体设置
    UITabBarItem *item = [UITabBarItem appearance]; //拿到底部的tabBarItem
    [item setTitleTextAttributes:attrsNomal forState:UIControlStateNormal];
    [item setTitleTextAttributes:attrsSelected forState:UIControlStateSelected];
}

@end
