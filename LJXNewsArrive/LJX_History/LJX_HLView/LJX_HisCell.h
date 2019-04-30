//
//  LJX_HisCell.h
//  LJXNewsArrive
//
//  Created by a on 2019/4/28.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJX_HisModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LJX_HisCell : UITableViewCell

+(instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier;

@property (nonatomic , strong) LJX_HisModel * hisModel;

@end

NS_ASSUME_NONNULL_END
