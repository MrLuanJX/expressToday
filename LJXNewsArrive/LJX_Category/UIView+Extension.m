//
//  UIView+Extension.m
//  01-黑酷
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setLeft:(CGFloat)left
{
    self.x = left;
}

- (CGFloat)left
{
    return self.x;
}

- (void)setTop:(CGFloat)top
{
    self.y = top;
}

- (CGFloat)top
{
    return self.y;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)right
{
    return CGRectGetMaxX(self.frame);
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return CGRectGetMaxY(self.frame);
}

+ (UIView *)addLineWithFrame:(CGRect)frame WithView:(UIView *)view
{
    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    lineView.backgroundColor = NALineColor;
    [view addSubview:lineView];
    
    return lineView;
}

+ (UIView *)addLineBackGroundWithFrame:(CGRect)frame color:(UIColor*)color WithView:(UIView *)view
{
    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    lineView.backgroundColor = color;
    [view addSubview:lineView];
    
    return lineView;
}

///创建一个view的对象
+(UIView*)CreateViewWithFrame:(CGRect)frame BackgroundColor:(UIColor*)color InteractionEnabled:(BOOL)enabled{
    
    UIView * view=[[UIView alloc]initWithFrame:frame];
    view.backgroundColor=color;
    view.userInteractionEnabled=enabled;
    return view;
}

- (void)showNoDataImageInView:(UIView *)view withImage:(NSString *)imageName title:(NSString *)title{
    
    [self removeImageView:view];
    
    view.backgroundColor = NABackgroundColor;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAFit(115), NAFit(150), NAFit(150))];
    imageView.size = CGSizeMake(NAFit(150), NAFit(150));
    imageView.centerX = view.centerX;
    imageView.image=[UIImage imageNamed:imageName];
    [view addSubview:imageView];
    imageView.tag=1000;
    
    UILabel *lable = [[UILabel alloc] init];
    lable.text = imageName;
    lable.tag = 1000;
    lable.textColor = NASubTitleColor;
    lable.font = NAFontSize(18);
    [lable sizeToFit];
    lable.centerX = view.centerX;
    lable.centerY = imageView.bottom + NAFit(15);
    [view addSubview:lable];
    
    UILabel *subLabel = [[UILabel alloc] init];
    subLabel.text = title;
    subLabel.tag = 1000;
    subLabel.textColor = [UIColor lightGrayColor];
    subLabel.font = NAFontSize(15);
    [subLabel sizeToFit];
    subLabel.centerX = view.centerX;
    subLabel.centerY = lable.bottom + NAFit(20);
    [view addSubview:subLabel];

}

- (void)hideNoDataImageInView:(UIView *)view{
    
    [self removeImageView:view];
    
}

- (void)removeImageView:(UIView *)view{
    
    //按照tag值进行移除
    for (UIImageView *subView in view.subviews) {
        
        if (subView.tag == 1000) {
            
            [subView removeFromSuperview];
        }
    }
}

+ (void) getGradientWithFirstColor:(UIColor *)firstColor SecondColor:(UIColor *)secondColor WithView:(UIView *)view {
    CAGradientLayer * gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = @[(id)firstColor.CGColor,(id)secondColor.CGColor];
    gradient.startPoint = CGPointMake(0, 1);
    gradient.endPoint = CGPointMake(1, 0);
    [view.layer addSublayer:gradient];
}

+ (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width
{
    if (top) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (left) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (bottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, view.frame.size.height - width, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (right) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(view.frame.size.width - width, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
}

+ (void)UILayoutCornerRadiusType:(UILayoutCornerRadiusType)sideType withCornerRadius:(CGFloat)cornerRadius View:(UIView *)view {
    CGSize cornerSize = CGSizeMake(cornerRadius, cornerRadius);
    UIBezierPath *maskPath;
    switch (sideType) {
        case UILayoutCornerRadiusTop: {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                             byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)
                                                   cornerRadii:cornerSize];
        }
            break;
        case UILayoutCornerRadiusLeft: {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                             byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerBottomLeft)
                                                   cornerRadii:cornerSize];
        }
            break;
        case UILayoutCornerRadiusBottom: {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                             byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight)
                                                   cornerRadii:cornerSize];
        }
            break;
        case UILayoutCornerRadiusRight: {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                             byRoundingCorners:(UIRectCornerTopRight|UIRectCornerBottomRight)
                                                   cornerRadii:cornerSize];
        }
            break;
        case UILayoutCornerdeleteTopleft: {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                             byRoundingCorners:(UIRectCornerTopRight|UIRectCornerBottomRight|UIRectCornerBottomLeft)
                                                   cornerRadii:cornerSize];
        }
            break;
        default: {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                             byRoundingCorners:UIRectCornerAllCorners
                                                   cornerRadii:cornerSize];
        }
            break;
    }
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    // Set the newly created shape layer as the mask for the image view's layer
    view.layer.mask = maskLayer;
    [view.layer setMasksToBounds:YES];
}

// 获取当前的时间
+ (NSString *) getCurrentTimes {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
}

+ (NSDictionary *) currentXZWithCurrentDate : (NSString *)currentDate {
    
    NSString * year = [currentDate substringWithRange:NSMakeRange(0, 4)];
    NSString * month = [currentDate substringWithRange:NSMakeRange(5, 2)];
    NSString * day = [currentDate substringWithRange:NSMakeRange(currentDate.length - 3, 2)];
    currentDate = [NSString stringWithFormat:@"%@%@",month,day];
    
    NSString * xzStr = @"";
    if (120 < [currentDate intValue]  && [currentDate intValue] < 218) {
        xzStr = @"水瓶座";
    } else if (219 <= [currentDate intValue]  && [currentDate intValue] <= 320) {
        xzStr = @"双鱼座";
    } else if (321 <= [currentDate intValue] && [currentDate intValue] <= 419) {
        xzStr = @"白羊座";
    } else if (420 <= [currentDate intValue]  && [currentDate intValue] <= 520) {
        xzStr = @"金牛座";
    } else if (521 <= [currentDate intValue]  && [currentDate intValue] <= 621) {
        xzStr = @"双子座";
    } else if (622 <= [currentDate intValue]  && [currentDate intValue] <= 722) {
        xzStr = @"巨蟹座";
    } else if (723 <= [currentDate intValue]  && [currentDate intValue] <= 822) {
        xzStr = @"狮子座";
    } else if (823 <= [currentDate intValue]  && [currentDate intValue] <= 922) {
        xzStr = @"处女座";
    } else if (923 <= [currentDate intValue]  && [currentDate intValue] <= 1023) {
        xzStr = @"天秤座";
    } else if (1024 <= [currentDate intValue]  && [currentDate intValue] <= 1122) {
        xzStr = @"天蝎座";
    } else if (1123 <= [currentDate intValue]  && [currentDate intValue] <= 1221) {
        xzStr = @"射手座";
    } else {
        xzStr = @"摩羯座";
    }
    NSDictionary * dict = @{
                            @"year" : year,
                            @"month" : month,
                            @"day" : day,
                            @"xz" : xzStr
                            };
    NSLog(@"dict = %@",dict);
    return dict;
}

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
+ (void)LJX_AddShadowToView:(UIView *)theView SetShadowPathWith:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowSide:(LJXShadowPathSide)shadowPathSide shadowPathWidth:(CGFloat)shadowPathWidth{
    
    theView.layer.masksToBounds = NO;
    theView.layer.shadowColor = shadowColor.CGColor;
    theView.layer.shadowOpacity = shadowOpacity;
    theView.layer.shadowRadius =  shadowRadius;
    theView.layer.shadowOffset = CGSizeZero;
    CGRect shadowRect;
    CGFloat originX = 0;
    CGFloat originY = 0;
    CGFloat originW = theView.bounds.size.width;
    CGFloat originH = theView.bounds.size.height;
    
    switch (shadowPathSide) {
        case LJXShadowPathTop:
            shadowRect  = CGRectMake(originX, originY - shadowPathWidth/2, originW,  shadowPathWidth);
            break;
        case LJXShadowPathBottom:
            shadowRect  = CGRectMake(originX, originH -shadowPathWidth/2, originW, shadowPathWidth);
            break;
            
        case LJXShadowPathLeft:
            shadowRect  = CGRectMake(originX - shadowPathWidth/2, originY, shadowPathWidth, originH);
            break;
            
        case LJXShadowPathRight:
            shadowRect  = CGRectMake(originW - shadowPathWidth/2, originY, shadowPathWidth, originH);
            break;
        case LJXShadowPathNoTop:
            shadowRect  = CGRectMake(originX -shadowPathWidth/2, originY +1, originW +shadowPathWidth,originH + shadowPathWidth/2 );
            break;
        case LJXShadowPathAllSide:
            shadowRect  = CGRectMake(originX - shadowPathWidth/2, originY - shadowPathWidth/2, originW +  shadowPathWidth, originH + shadowPathWidth);
            break;
    }
    UIBezierPath *path =[UIBezierPath bezierPathWithRect:shadowRect];
    theView.layer.shadowPath = path.CGPath;
}

@end
