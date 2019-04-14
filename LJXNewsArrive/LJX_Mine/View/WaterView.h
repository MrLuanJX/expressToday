//
//  WaterView.h
//  JQHMarket
//
//  Created by 栾金鑫 on 2019/4/13.
//  Copyright © 2019年 肖亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterView : UIView

- (instancetype)initWithFrame:(CGRect)frame setProgress:(CGFloat)percentag Duration:(CFTimeInterval)duration title:(NSString *)title;

@end
