//
//  LJX_BaseViewController.m
//  LJXNewsArrive
//
//  Created by 栾金鑫 on 2019/4/13.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "LJX_BaseViewController.h"

@interface LJX_BaseViewController ()

@end

@implementation LJX_BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
}

//获取导航栏的高度
-(CGFloat)navigationHeight {
    CGFloat navheight = self.navigationController.navigationBar.frame.size.height;
    CGFloat stateheight = [UIApplication sharedApplication].statusBarFrame.size.height;
    return navheight + stateheight;
}

-(CGFloat)tabBarHeight{
    return self.tabBarController.tabBar.height;
}
@end
