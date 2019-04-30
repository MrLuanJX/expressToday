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
#import "LJX_DZViewController.h"
#import "LJX_HistoryViewController.h"
#import "LJX_PostViewController.h"

@interface LJX_TabBarController ()<UITabBarControllerDelegate>

@property (nonatomic , assign) NSInteger indexFlag; // 记录上一次点击tabbar，使用时，记得先在init或viewDidLoad里 初始化 = 0

@end

@implementation LJX_TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.indexFlag = 0;
    
    self.delegate = self;

    [self createTab];
}

-(void) createTab{
    LJX_HomeViewController  * homeVC=[LJX_HomeViewController new];
    LJX_MineViewController * mineVC = [LJX_MineViewController new];
    LJX_DZViewController * dzVC = [LJX_DZViewController new];
    LJX_HistoryViewController * hisVC = [LJX_HistoryViewController new];
    
    LJX_PostViewController * postVC = [LJX_PostViewController new];
    postVC.tabBarItem.imageInsets = UIEdgeInsetsMake( -30 , 0 , 0 , 0 );
    
    LJX_NavigationViewController * homeNav=[self createVC:homeVC Title:@"首页" imageName:@"home_normal" SelectImageName:@"home_highlight"];
    
    LJX_NavigationViewController * dzNav=[self createVC:dzVC Title:@"精选段子" imageName:@"fishpond_normal" SelectImageName:@"fishpond_highlight"];
    
    LJX_NavigationViewController * postNav=[self createVC:postVC Title:@"分类" imageName:@"post_highlight" SelectImageName:@"post_highlight"];  // fenlei-Selected
    
    LJX_NavigationViewController * hisNav=[self createVC:hisVC Title:@"今日解析" imageName:@"message_normal" SelectImageName:@"message_highlight"];

    LJX_NavigationViewController * mineNav=[self createVC:mineVC Title:@"我的" imageName:@"account_normal" SelectImageName:@"account_highlight"];
    
    self.viewControllers = @[homeNav,dzNav,postNav,hisNav,mineNav];
    
    [self.tabBar setShadowImage:[UIImage imageWithColor:NAUIColorWithRGB(0xE0E0E0, 1.0)]];
    
    [self.tabBar setBackgroundImage:[[UIImage alloc]init]];
    
    [self setItems];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    NSInteger index = [self.tabBar.items indexOfObject:item];
    
    [self animationWithIndex:index];
}

- (void)animationWithIndex:(NSInteger) index {
    
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
 
    for (UIView *tabBarButton in self.tabBar.subviews) {
        
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];  
    pulse.duration = 0.2;
    pulse.repeatCount= 1;  
    pulse.autoreverses= YES;  
    pulse.fromValue= [NSNumber numberWithFloat:0.7];  
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    if (index - 1 < 0) {
        index = self.tabBar.subviews.count - 1;
    }
    [[tabbarbuttonArray[index - 1] layer]
     addAnimation:pulse forKey:nil];
}

#pragma mark 判断是否登录若没登录跳转到登录页面
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
   
    if([viewController.tabBarItem.title isEqualToString:@"我的"]){
                
        NSUserDefaults *user= [NSUserDefaults standardUserDefaults];
        NSString *member_id=[user objectForKey:@"member_id"];
        NSLog(@" member_id %@ ",member_id);
        
        if ([member_id isKindOfClass:[NSNull class]] || (member_id == nil) || (member_id == NULL) || [member_id isEqualToString:@"NO"]) {
        
            NSLog(@" 未登录状态 ");
            LJX_LoginViewController *view=[[LJX_LoginViewController alloc]init];
            LJX_NavigationViewController *nav = [[LJX_NavigationViewController alloc] initWithRootViewController:view];
//            nav.navigationBarHidden = YES;
            [self presentViewController:nav animated:YES completion:nil];
            
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - 修改TabBar高度
- (void)viewWillLayoutSubviews{
    
    CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
    tabFrame.size.height = 55;
    tabFrame.origin.y = NAScreenH- 55;
    
    if ((void)(SAFE_AREA_INSETS_BOTTOM),safeAreaInsets().bottom > 0.0) {
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
