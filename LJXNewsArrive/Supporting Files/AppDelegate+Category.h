//
//  AppDelegate+Category.h
//  LJXNewsArrive
//
//  Created by 栾金鑫 on 2019/4/13.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (Category)

/*配置弹框SVProgressHUD*/
-(void)configMBProgress;

/*友盟统计*/
-(void)configUMengAnalytics;

- (void) developerOpenApiRegist;

- (void) loginDeveloperOpenApi;
@end
