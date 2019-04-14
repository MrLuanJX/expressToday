//
//  LJX_HomeBaseModel.h
//  LJXNewsArrive
//
//  Created by 栾金鑫 on 2019/4/13.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LJX_HomeModel.h"

@interface LJX_HomeBaseModel : NSObject

@property (nonatomic , copy) NSString * stat;

@property (nonatomic , copy) NSArray <LJX_HomeModel *> *data;

@end
