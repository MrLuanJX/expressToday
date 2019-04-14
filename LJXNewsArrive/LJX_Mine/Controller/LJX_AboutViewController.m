//
//  LJX_AboutViewController.m
//  LJXNewsArrive
//
//  Created by 栾金鑫 on 2019/4/13.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "LJX_AboutViewController.h"
#import "WaterView.h"

@interface LJX_AboutViewController ()

@end

@implementation LJX_AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor redColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    WaterView *progressView = [[WaterView alloc] initWithFrame:CGRectMake(0, 0, 200, 200) setProgress:0.75 Duration:3.5 title:@"幸福指数"];
    progressView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    [self.view addSubview:progressView];

}

@end
