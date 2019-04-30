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

- (void) developerOpenApiRegist {
    
    NSDictionary * dict = @{
                            @"name" : @"ljx005210",
                            @"passwd" : @"123456",
                            @"email" : @"15652550778@163.com"
                            };
    NSLog(@"dict = %@",dict);
    [LJXRequestTool LJX_requestWithType:LJX_GET URL:@"https://api.apiopen.top/developerRegister" params:dict successBlock:^(id obj) {
        NSLog(@"obj = %@",obj);

        NSUserDefaults *tokenUDF = [NSUserDefaults standardUserDefaults];
        [tokenUDF setValue:obj[@"result"][@"apikey"] forKey:@"apikey"];
        [tokenUDF synchronize];
    } failureBlock:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
}

- (void) loginDeveloperOpenApi{
    NSDictionary * dict = @{
                            @"name" : @"ljx005210",
                            @"passwd" : @"123456",
                            };
    
    [LJXRequestTool LJX_requestWithType:LJX_GET URL:@"https://api.apiopen.top/developerLogin" params:dict successBlock:^(id obj) {
        NSUserDefaults *tokenUDF = [NSUserDefaults standardUserDefaults];
        [tokenUDF setValue:obj[@"result"][@"apikey"] forKey:@"apikey"];
        [tokenUDF synchronize];
        
        NSLog(@"loginObj = %@",obj);
        
    } failureBlock:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
}


@end
