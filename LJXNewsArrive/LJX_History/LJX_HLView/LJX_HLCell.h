//
//  LJX_HLCell.h
//  LJXNewsArrive
//
//  Created by a on 2019/4/25.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJX_HLModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LJX_HLCell : UITableViewCell

+(instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier cellTag:(NSInteger) tag;

@property (nonatomic , strong) NSIndexPath * index;

@property (nonatomic , strong) LJX_HLModel * hlModel;

@property (nonatomic , assign) BOOL isFromDetail;

@end

NS_ASSUME_NONNULL_END
