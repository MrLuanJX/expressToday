//
//  LJX_AboutViewController.m
//  LJXNewsArrive
//
//  Created by 栾金鑫 on 2019/4/13.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "LJX_AboutViewController.h"
#import "WaterView.h"
#import <CoreImage/CoreImage.h>

@interface LJX_AboutViewController ()

@property (nonatomic , strong) UIImageView * img;

@property (nonatomic , strong) UILabel * titleLabel;

@end

@implementation LJX_AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"关于我们";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configUI];

   self.img.image = [self getOutPutImage];
    
//    [self photoBrowser];
}

- (void) photoBrowser {
    HZPhotoBrowser *browser = [[HZPhotoBrowser alloc] init];
    browser.isFullWidthForLandScape = YES;
    browser.isNeedLandscape = YES;
    browser.currentImageIndex = 3;
    browser.imageArray = @[
                           @"http://ww2.sinaimg.cn/bmiddle/9ecab84ejw1emgd5nd6eaj20c80c8q4a.jpg",
                           @"http://ww2.sinaimg.cn/bmiddle/642beb18gw1ep3629gfm0g206o050b2a.gif",
                           @"http://ww4.sinaimg.cn/bmiddle/9e9cb0c9jw1ep7nlyu8waj20c80kptae.jpg",
                           @"http://ww3.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr1xydcj20gy0o9q6s.jpg",
                           @"http://ww2.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr2n1jjj20gy0o9tcc.jpg",
                           @"http://ww4.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr4nndfj20gy0o9q6i.jpg",
                           @"http://ww3.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr57tn9j20gy0obn0f.jpg",
                           @"http://ww2.sinaimg.cn/bmiddle/677febf5gw1erma104rhyj20k03dz16y.jpg",
                           @"http://ww4.sinaimg.cn/bmiddle/677febf5gw1erma1g5xd0j20k0esa7wj.jpg"
                           ];
    
    [browser show];
}

- (void) configUI {
    
    [self.view addSubview: self.img];
    [self.view addSubview: self.titleLabel];
    
    
    [self.img mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view);
        make.width.height.mas_equalTo(NAFit(120));
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-NAFit(50));
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(NAFit(50));
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    WaterView *progressView = [[WaterView alloc] initWithFrame:CGRectMake(0, 0, 200, 200) setProgress:0.75 Duration:3.5 title:@"幸福指数"];
//    progressView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
//    [self.view addSubview:progressView];
}

- (UIImageView *)img {
    if (!_img) {
        _img = [UIImageView new];
    }
    return _img;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = NAFontBoldSize(25);
        _titleLabel.text = @"今日快讯";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIImage *) getOutPutImage {
    //创建名为"CIQRCodeGenerator"的CIFilter
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //将filter所有属性设置为默认值
    [filter setDefaults];
    
    //将所需尽心转为UTF8的数据，并设置给filter
    NSData *data = [@"https://www.baidu.com" dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    
    //设置二维码的纠错水平，越高纠错水平越高，可以污损的范围越大
    /*
     * L: 7%
     * M: 15%
     * Q: 25%
     * H: 30%
     */
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    //拿到二维码图片，此时的图片不是很清晰，需要二次加工
    CIImage *outPutImage = [filter outputImage];
    
    return [self getHDImgWithCIImage:outPutImage size:CGSizeMake(NAFit(200), NAFit(200)) waterImg:[UIImage imageNamed:@"icon-20-ipad"]];
}


/**
 调整二维码清晰度，添加水印图片
 
 @param img 模糊的二维码图片
 @param size 二维码的宽高
 @param waterImg 水印图片
 @return 添加水印图片后，清晰的二维码图片
 */
- (UIImage *)getHDImgWithCIImage:(CIImage *)img size:(CGSize)size waterImg:(UIImage *)waterImg {
    
    CGRect extent = CGRectIntegral(img.extent);
    CGFloat scale = MIN(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));
    
    //1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    //创建一个DeviceGray颜色空间
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    //CGBitmapContextCreate(void * _Nullable data, size_t width, size_t height, size_t bitsPerComponent, size_t bytesPerRow, CGColorSpaceRef  _Nullable space, uint32_t bitmapInfo)
    //width：图片宽度像素
    //height：图片高度像素
    //bitsPerComponent：每个颜色的比特值，例如在rgba-32模式下为8
    //bitmapInfo：指定的位图应该包含一个alpha通道。
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    //创建CoreGraphics image
    CGImageRef bitmapImage = [context createCGImage:img fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    //2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef); CGImageRelease(bitmapImage);
    
    //清晰的二维码图片
    UIImage *outputImage = [UIImage imageWithCGImage:scaledImage];
    //给二维码加 logo 图
    UIGraphicsBeginImageContextWithOptions(outputImage.size, NO, [[UIScreen mainScreen] scale]);
    [outputImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    //水印图片
    //把水印图片画到生成的二维码图片上，注意尺寸不要太大（根据上面生成二维码设置的纠错程度设置），否则有可能造成扫不出来
    [waterImg drawInRect:CGRectMake((size.width-waterImg.size.width)/2.0, (size.height-waterImg.size.height)/2.0, waterImg.size.width, waterImg.size.height)];
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newPic;
}

@end
