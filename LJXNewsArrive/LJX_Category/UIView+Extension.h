//
//  UIView+Extension.h
//  01-黑酷
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,UILayoutCornerRadiusType) {
    UILayoutCornerRadiusTop    = 0,
    UILayoutCornerRadiusLeft   = 1,
    UILayoutCornerRadiusBottom = 2,
    UILayoutCornerRadiusRight  = 3,
    UILayoutCornerRadiusAll    = 4,
    UILayoutCornerdeleteTopleft = 5,
};

typedef enum :NSInteger{
    LJXShadowPathLeft,
    LJXShadowPathRight,
    LJXShadowPathTop,
    LJXShadowPathBottom,
    LJXShadowPathNoTop,
    LJXShadowPathAllSide
} LJXShadowPathSide;


@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

/** 控件最左边那根线的位置(minX的位置) */
@property (nonatomic, assign) CGFloat left;

/** 控件最右边那根线的位置(maxX的位置) */
@property (nonatomic, assign) CGFloat right;

/** 控件最顶部那根线的位置(minY的位置) */
@property (nonatomic, assign) CGFloat top;

/** 控件最底部那根线的位置(maxY的位置) */
@property (nonatomic, assign) CGFloat bottom;

//添加一根线
+ (UIView *)addLineWithFrame:(CGRect)frame WithView:(UIView *)view;

/**
 添加一个背景色可变的宽线
 */
+ (UIView *)addLineBackGroundWithFrame:(CGRect)frame color:(UIColor*)color WithView:(UIView *)view;

/**  没有数据时的显示的图片 */
- (void)showNoDataImageInView:(UIView *)view withImage:(NSString *)imageName title:(NSString *)title;
- (void)hideNoDataImageInView:(UIView *)view;

///创建一个view的对象
+(UIView*)CreateViewWithFrame:(CGRect)frame BackgroundColor:(UIColor*)color InteractionEnabled:(BOOL)enabled;

// 渐变色
+ (void) getGradientWithFirstColor:(UIColor *)firstColor SecondColor:(UIColor *)secondColor WithView:(UIView *)view;
// 边框
+ (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width;
// 圆角
+ (void)UILayoutCornerRadiusType:(UILayoutCornerRadiusType)sideType withCornerRadius:(CGFloat)cornerRadius View:(UIView *)view;
/*
 * shadowColor 阴影颜色
 *
 * shadowOpacity 阴影透明度，默认0
 *
 * shadowRadius  阴影半径，默认3
 *
 * shadowPathSide 设置哪一侧的阴影，
 
 * shadowPathWidth 阴影的宽度，
 
 */
+ (void)LJX_AddShadowToView:(UIView *)theView SetShadowPathWith:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowSide:(LJXShadowPathSide)shadowPathSide shadowPathWidth:(CGFloat)shadowPathWidth;


// 获取当前的时间
+ (NSString *) getCurrentTimes;

/**
 * dict(year,month,day,xz)
 */

+ (NSDictionary *) currentXZWithCurrentDate : (NSString *)currentDate ;
@end
