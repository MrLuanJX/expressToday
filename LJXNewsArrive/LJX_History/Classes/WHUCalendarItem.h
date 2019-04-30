//
//  WHUCalendarItem.h
//  TEST_Calendar
//
//  Created by SuperNova(QQ:422596694) on 15/11/5.
//  Copyright (c) 2015年 SuperNova(QQ:422596694). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WHUCalendarItem : NSObject
@property(nonatomic,strong) NSString* dateStr; //yyyy-MM-dd格式
@property(nonatomic,assign) NSInteger day;  
@property (nonatomic, strong) NSString *Chinese_calendar;//农历
@property (nonatomic, strong) NSString *holiday;//节日
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com