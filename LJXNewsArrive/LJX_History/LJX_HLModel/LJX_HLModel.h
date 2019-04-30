//
//  LJX_HLModel.h
//  LJXNewsArrive
//
//  Created by a on 2019/4/26.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LJX_HLModel : NSObject

@property (nonatomic , copy) NSString * year;
@property (nonatomic , copy) NSString * month;
@property (nonatomic , copy) NSString * day;
@property (nonatomic , copy) NSString * yangli;                 // 阳历
@property (nonatomic , copy) NSString * nongli;                 // 农历
@property (nonatomic , copy) NSString * star;                   // 星座
@property (nonatomic , copy) NSString * wuxing;                 // 五行
@property (nonatomic , copy) NSString * chong;                  // 冲
@property (nonatomic , copy) NSString * sha;                    // 煞
@property (nonatomic , copy) NSString * shengxiao;              // 生肖
@property (nonatomic , copy) NSString * jiri;                   // 吉日
@property (nonatomic , copy) NSString * zhiri;                  // 值日天神
@property (nonatomic , copy) NSString * xiongshen;              // 凶神
@property (nonatomic , copy) NSString * jishenyiqu;             // 吉神宜趋
@property (nonatomic , copy) NSString * caishen;                // 财神
@property (nonatomic , copy) NSString * xishen;                 // 喜神
@property (nonatomic , copy) NSString * fushen;                 // 福神
@property (nonatomic , copy) NSString * taishen;                // 胎神
@property (nonatomic , copy) NSArray * suici;                   // 岁次
@property (nonatomic , copy) NSArray * yi;                      // 宜
@property (nonatomic , copy) NSArray * ji;                      // 忌
@property (nonatomic , copy) NSString * eweek;                  // 英文星期
@property (nonatomic , copy) NSString * emonth;                 // 英文月
@property (nonatomic , copy) NSString * week;                   // 星期

@end

NS_ASSUME_NONNULL_END
