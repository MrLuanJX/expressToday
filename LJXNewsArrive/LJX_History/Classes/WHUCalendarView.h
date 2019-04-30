//
//  WHUCalendarView.h
//  TEST_Calendar
//
//  Created by SuperNova(QQ:422596694) on 15/11/5.
//  Copyright (c) 2015年 SuperNova(QQ:422596694). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHUCalendarView : UIView
//用户选择的日期.
@property(nonatomic,strong,readonly)  NSDate* selectedDate;
//用户选择日期后的操作.
@property(nonatomic,strong) void(^onDateSelectBlk)(NSDate*);
//当前日历的显示月份,默认显示为当前月份的日历.
@property(nonatomic,strong) NSDate* currentDate;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com