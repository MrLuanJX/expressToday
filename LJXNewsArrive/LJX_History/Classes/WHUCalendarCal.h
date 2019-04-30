//
//  WHUCalendarCal.h
//  TEST_Calendar
//
//  Created by SuperNova(QQ:422596694) on 15/11/5.
//  Copyright (c) 2015年 SuperNova(QQ:422596694). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WHUCalendarCal : NSObject
-(NSDictionary*)calendarMapWith:(NSDate*)date;
-(NSDictionary*)getPreCalendarMap:(NSString*)dateStr;
-(NSDictionary*)getNextCalendarMap:(NSString*)dateStr;
-(NSDictionary*)getCalendarMapWith:(NSString*)dateStr;
-(NSDate*)dateFromString:(NSString*)dateString;
-(NSString*)currentDateStr;
-(void)preMonthCalendar:(NSString*)dateStr complete:(void(^)(NSDictionary*))completionBlk;
-(void)nextMonthCalendar:(NSString*)dateStr complete:(void(^)(NSDictionary*))completionBlk;
-(void)getCalendarMapWith:(NSString*)dateStr completion:(void(^)(NSDictionary* dic))completeBlk;
-(NSString*)stringFromDate:(NSDate*)date;
-(NSDictionary*)loadDataWith:(NSString*)dateStr;
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com