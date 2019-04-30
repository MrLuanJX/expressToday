//
//  LJX_DZListCell.h
//  LJXNewsArrive
//
//  Created by a on 2019/4/19.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJX_DZModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LJX_DZListCell : UITableViewCell

+(instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier;

@property (nonatomic , strong) LJX_DZModel * dzModel;

@property (nonatomic , assign) NSInteger currentType;

@end

NS_ASSUME_NONNULL_END
