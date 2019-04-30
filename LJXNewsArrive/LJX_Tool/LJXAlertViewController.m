//
//  LJXAlertViewController.m
//  LJXNewsArrive
//
//  Created by a on 2019/4/30.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "LJXAlertViewController.h"

@interface LJXAlertViewController () <UIAlertViewDelegate>

@end

@implementation LJXAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (void) alertShowWithController:(UIViewController *)viewController WithAlertType:(LJXAlertType)alertType AlertTitle:(NSString *)alertTitle Message:(NSString *)message {
        
    if (NANULLString(alertTitle)) {
        alertTitle = @"提示";
    }
    if (NANULLString(message)) {
        message = @"提示消息";
    }
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:alertTitle message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (alertType != 2) {
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            viewController.tabBarController.selectedIndex = 0;
            
        }];
        [alertController addAction:okAction];
        if (alertType != 1) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancelAction];
        }
    }
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}

@end
