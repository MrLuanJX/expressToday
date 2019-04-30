//
//  LJXAlertViewController.h
//  LJXNewsArrive
//
//  Created by a on 2019/4/30.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LJX_Buttons = 0,
    LJX_singleButton,
    LJX_NoneButton,
} LJXAlertType;

NS_ASSUME_NONNULL_BEGIN

@interface LJXAlertViewController : UIViewController

@property (nonatomic , copy) void(^okBlock)(void);

+ (void) alertShowWithController:(UIViewController *)viewController WithAlertType:(LJXAlertType)alertType AlertTitle:(NSString *)alertTitle Message:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
