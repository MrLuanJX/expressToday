//
//  LJX_PostViewController.m
//  LJXNewsArrive
//
//  Created by a on 2019/4/29.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "LJX_PostViewController.h"
#import "LLWPlusPopView.h"
#import "LJX_MineViewController.h"
#import "LJXAlertViewController.h"

@interface LJX_PostViewController ()

@end

@implementation LJX_PostViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self configUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void) configUI {
    __weak typeof (self) weakSelf = self;
    
    NSMutableArray *imgs = @[].mutableCopy;
    for (NSInteger i = 0; i < 6; i ++) {
        [imgs addObject:[NSString stringWithFormat:@"publish_%zi", i]];
    }
    NSArray *titles = @[@"今日星运", @"今日黄历", @"今日历史", @"今日诗词", @"今日解梦", @"今日谜语"]; // ,  @"文字"
    [LLWPlusPopView showWithImages:imgs titles:titles selectBlock:^(NSInteger index) {
        NSLog(@"index:%zi", index);
        
        
        [LJXAlertViewController alertShowWithController:weakSelf WithAlertType:1 AlertTitle:@"温馨提示" Message:@"未完待续"];
//        [self.navigationController pushViewController:[LJX_MineViewController new] animated:YES];
        
    } view:self.view];
}



@end
