//
//  LJX_SectionHeaderView.h
//  LJXNewsArrive
//
//  Created by a on 2019/4/26.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LJX_SectionHeaderView : UIView

@property (nonatomic , assign) NSInteger index;

@property (nonatomic , copy) void(^moreBtnActionBlock)(NSInteger index);


@end

NS_ASSUME_NONNULL_END
