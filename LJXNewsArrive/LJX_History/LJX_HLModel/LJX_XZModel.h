//
//  LJX_XZModel.h
//  LJXNewsArrive
//
//  Created by a on 2019/4/28.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LJX_XZModel : NSObject

@property (nonatomic , copy) NSString * all;                // 综合指数
@property (nonatomic , copy) NSString * health;             // 健康指数
@property (nonatomic , copy) NSString * money;              // 财运指数
@property (nonatomic , copy) NSString * love;               // 爱情指数
@property (nonatomic , copy) NSString * work;               // 工作指数


@property (nonatomic , copy) NSString * name;
@property (nonatomic , copy) NSString * datetime;
@property (nonatomic , copy) NSString * date;
@property (nonatomic , copy) NSString * color;
@property (nonatomic , copy) NSString * number;
@property (nonatomic , copy) NSString * QFriend;
@property (nonatomic , copy) NSString * summary;

@end

NS_ASSUME_NONNULL_END
