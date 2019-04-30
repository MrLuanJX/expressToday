//
//  WHUCalendarPopView.h
//  TEST_Calendar
//
//  Created by SuperNova(QQ:422596694) on 15/11/7.
//  Copyright (c) 2015年 SuperNova(QQ:422596694). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHUCalendarPopView : UIWindow
@property(nonatomic,strong) void(^onDateSelectBlk)(NSDate*);
-(void)dismiss;
-(void)show;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com