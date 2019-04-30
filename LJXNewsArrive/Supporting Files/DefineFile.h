//
//  DefineFile.h
//  LJXNewsArrive
//
//  Created by 栾金鑫 on 2019/4/13.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#ifndef DefineFile_h
#define DefineFile_h
/* 极速 */
#define JSAPPKEY @"4f41d6d85dbe73e5"

/* 聚合新闻 */
#define JHAPPKEY @"578a713cf072919f400c001e0c7bcd9b"
/* 聚合星座 */
#define JHXZAPPKEY @"031cab289da743cb85799f005f2636dd"

#define SAFE_AREA_INSETS_TOP safeAreaInsets().top
#define SAFE_AREA_INSETS_BOTTOM safeAreaInsets().bottom

/** 程序版本号 */
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define iPhoneX ([UIScreen mainScreen].bounds.size.height >= 812)

//字体类型
#define Font_Medium @"PingFangSC-Medium"
#define Font_Regular @"PingFangSC-Regular"

//我的距离边框的大小
#define MineMarginH NAFit(17)
#define MineMarginW NAFit(16)

//16进制颜色设置
#define NAUIColorWithRGB(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:alphaValue]

//RGB颜色设置
#define kSetUpCololor(RED,GREEN,BLUE,ALPHA) [UIColor colorWithRed:RED/255.0 green:GREEN/255.0 blue:BLUE/255.0 alpha:ALPHA]
//主题色
#define NAThemeColor  NAUIColorWithRGB(0xf8c112,1.0)
//线的颜色
#define NALineColor  NAUIColorWithRGB(0xeff3f6,1.0)
//透明色
#define NAClearColor [UIColor clearColor]
#define NASubTitleColor   NAUIColorWithRGB(0x676767,1.0) //子标题的颜色
#define NABackgroundColor NAUIColorWithRGB(0xeff3f6,1.0)//底灰

/********************屏幕宽和高*******************/
#define NAScreenW [UIScreen mainScreen].bounds.size.width
#define NAScreenH [UIScreen mainScreen].bounds.size.height
#define NAkWindowFrame [[UIScreen mainScreen] bounds]
//根据屏幕宽度计算对应View的高
#define NAFit(value) ((value * NAScreenW) / 375.0f)

/**字体*/
#define NAFontSize(x) [UIFont systemFontOfSize:(NAScreenW > 374 ? (NAScreenW > 375 ? x * 1.1 : x ) : x / 1.1)]
#define Kfont(R) NAFit(R)  //这里是6sp屏幕字体
/**加粗字体*/
#define NAFontBoldSize(x) [UIFont boldSystemFontOfSize:(NAScreenW > 374 ? (CGFloat)x  : (CGFloat)x / 1.1)]
/********************数据的判断处理*******************/
/**判断字符串是否为空*/
#define NANULLString(string) ((string == nil) ||[string isEqualToString:@""] ||([string length] == 0)  || [string isKindOfClass:[NSNull class]] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0 ||[string isEqual:[NSNull null]])


#define HexColorInt32_t(rgbValue) \
[UIColor colorWithRed:((float)((0x##rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((0x##rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(0x##rgbValue & 0x0000FF))/255.0  alpha:1]

//判断是否iPhone X
#define IS_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

// status bar height.
#define STATUS_BAR_HEIGHT (IS_iPhoneX ? 44.f : 20.f)

// Navigation bar height.
#define NAVIGATION_BAR_HEIGHT 44.f

// Status bar & navigation bar height.
#define STATUS_AND_NAVIGATION_HEIGHT (IS_iPhoneX ? 88.f : 64.f)

// Tabbar height.
#define TAB_BAR_HEIGHT (IS_iPhoneX ? (49.f + 34.f) : 49.f)

// Tabbar safe bottom margin.
#define TAB_BAR_SAFE_BOTTOM_MARGIN (IS_iPhoneX ? 34.f : 0.f)

//导航栏标题大小
#define NavTitleFont [UIFont boldSystemFontOfSize:Kfont(17)]
//导航栏按钮字体大小
#define NavItemFont [UIFont systemFontOfSize:Kfont(15)]

// 调试打印
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"[类:%s %d行]%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif


//适配iOS11的代码
#define  adjustsScrollViewInsets(scrollView)\
do {\
_Pragma("clang diagnostic push")\
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")\
if ([scrollView respondsToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
NSMethodSignature *signature = [UIScrollView instanceMethodSignatureForSelector:@selector(setContentInsetAdjustmentBehavior:)];\
NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];\
NSInteger argument = 2;\
invocation.target = scrollView;\
invocation.selector = @selector(setContentInsetAdjustmentBehavior:);\
[invocation setArgument:&argument atIndex:2];\
[invocation retainArguments];\
[invocation invoke];\
}\
_Pragma("clang diagnostic pop")\
} while (0)

//版本信息
#define IOS8AndLater [[[UIDevice currentDevice] systemVersion] floatValue]>=8
#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#endif /* DefineFile_h */
