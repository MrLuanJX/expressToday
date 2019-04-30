//
//  HYHCircleView.h
//  LifeBox
//
//  Created by huangyongheng on 2019/4/26.
//  Copyright © 2019 huangyongheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYHCircleView : UIView

- (void) setProgress : (CGFloat)progress;

- (void) setProgressTitle : (NSString *) progressTitle Font:(UIFont *)font Color:(UIColor *)color;

- (void)setProgressLineWidth:(CGFloat)width NormalLineWidth:(CGFloat)normallineWidth;

- (void) setGradientColorArray:(NSArray *)colorArray;

@end
NS_ASSUME_NONNULL_END
