//
//  LJX_XZCell.h
//  LJXNewsArrive
//
//  Created by a on 2019/4/26.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJX_XZModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LJX_XZCollectionCell : UICollectionViewCell

@end

@interface LJX_XZCell : UITableViewCell

+(instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier;

@property (nonatomic , strong) NSMutableArray * xzArray;

@property (nonatomic , strong) LJX_XZModel * xzModel;

@property (nonatomic , strong) NSMutableArray * xzDataArray;

@end

NS_ASSUME_NONNULL_END
