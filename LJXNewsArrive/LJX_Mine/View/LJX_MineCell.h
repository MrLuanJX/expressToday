//
//  MineCell.h
//  LJXNewsArrive
//
//  Created by 栾金鑫 on 2019/4/13.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJX_MineListModel.h"

@interface LJX_MineCell : UITableViewCell

+(instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier;

@property (nonatomic , strong) NSIndexPath * index;

@property (nonatomic , strong) LJX_MineListModel * mineModel;

@property (nonatomic , copy) NSString * folderSize;

@end
