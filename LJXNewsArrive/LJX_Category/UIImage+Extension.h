//
//  UIImage+Extension.h
//  河科院微博
//
//  Created by 👄 on 15/6/4.
//  Copyright (c) 2015年 sczy. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSInteger, UIImageOrientation) {
//    UIImageOrientationUp,            // default orientation  向上
//    UIImageOrientationDown,          // 180 deg rotation
//    UIImageOrientationLeft,          // 90 deg CCW
//    UIImageOrientationRight,         // 90 deg CW
//    UIImageOrientationUpMirrored,    // as above but image mirrored along other axis. horizontal flip
//    UIImageOrientationDownMirrored,  // horizontal flip
//    UIImageOrientationLeftMirrored,  // vertical flip
//    UIImageOrientationRightMirrored, // vertical flip
//};

@interface UIImage (Extension)

/**
 *  return 旋转后的图片
 *  @param image              原始图片    （必传，不可空）
 *  @param orientation        旋转方向    （必传，不可空）
 */
+ (UIImage *)image:(UIImage *)image
          rotation:(UIImageOrientation)orientation ;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+(UIImage *)resizableImage:(NSString *)name;

- (instancetype)circleImage;
+ (instancetype)circleImageNamed:(NSString *)name;

// 根据颜色生成一张尺寸为1*1的相同颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color;

// 根据比例生成一张尺寸缩小的图片
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

+ (UIImage *)getImageStream:(CVImageBufferRef)imageBuffer;
+ (UIImage *)getSubImage:(CGRect)rect inImage:(UIImage*)image;

+ (UIImage *)resizedImage:(NSString *)name;

@end
