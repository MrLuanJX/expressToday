//
//  AppDelegate+Category.m
//  LJXNewsArrive
//
//  Created by 栾金鑫 on 2019/4/13.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "AppDelegate+Category.h"

@implementation AppDelegate (Category)

/*配置弹框*/
-(void)configMBProgress{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMaximumDismissTimeInterval:1.5];
}


#pragma mark 友盟统计
-(void)configUMengAnalytics{
    [UMConfigure initWithAppkey:@"AppKey" channel:@"App Store"];
    [UMConfigure setLogEnabled:YES];
}

@end
