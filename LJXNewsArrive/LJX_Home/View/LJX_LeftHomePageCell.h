//
//  LJX_LeftHomePageCell.h
//  LJXNewsArrive
//
//  Created by a on 2019/4/29.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJX_HomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LJX_LeftHomePageCell : UITableViewCell

+ (instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier;

@property (nonatomic , strong) NSIndexPath * index;

@property (nonatomic , strong) LJX_HomeModel * homeListModel;

@end

NS_ASSUME_NONNULL_END
