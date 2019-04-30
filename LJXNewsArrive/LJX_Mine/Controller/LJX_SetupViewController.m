//
//  LJX_SetupViewController.m
//  LJXNewsArrive
//
//  Created by a on 2019/4/22.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "LJX_SetupViewController.h"
//#import <GPUImage.h>
#import "GPUImage.h"

@interface LJX_SetupViewController () <UIActionSheetDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate>

@property (nonatomic , strong) UILabel * iconLabel;

@property (nonatomic , strong) UIButton * iconImage;

@property (nonatomic , strong) UIButton * logOutBtn;

@property (nonatomic , strong) UIImageView * bgImg;

@end

@implementation LJX_SetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [UIView getGradientWithFirstColor:NAUIColorWithRGB(0xA2B5CD, 1.0) SecondColor:NAUIColorWithRGB(0x66CDAA, 1.0) WithView:self.view];

    self.title = @"设置";
        
    [self configUI];
}

- (void) configUI {
    __weak typeof (self) weakSelf = self;
    
    [self.view addSubview: self.bgImg];
    [self.bgImg addSubview: self.iconLabel];
    [self.bgImg addSubview: self.iconImage];
    [self.bgImg addSubview: self.logOutBtn];
    
    [self.bgImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
    
    [self.iconLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (NAFit(150));
        make.left.right.mas_equalTo (weakSelf.view);
        make.height.mas_equalTo (NAFit(40));
    }];
    
    [self.iconImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.iconLabel.mas_bottom).offset (NAFit(30));
        make.centerX.mas_equalTo (weakSelf.view.mas_centerX);
        make.width.height.mas_equalTo (NAFit(80));
    }];
    
    [self.logOutBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.iconImage.mas_bottom).offset (NAFit(70));
        make.left.mas_equalTo (NAFit(10));
        make.right.mas_equalTo (-NAFit(10));
        make.height.mas_equalTo (NAFit(40));
    }];
    
    self.iconLabel.text = [NSString stringWithFormat:@"%@:您好,轻触下面头像可修改",[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"]];
    
    [self.iconImage setBackgroundImage:[UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"headerImage"]] forState:UIControlStateNormal];
}

- (UILabel *)iconLabel {
    if (!_iconLabel) {
        _iconLabel = [UILabel new];
        _iconLabel.text = @"轻触头像修改";
        _iconLabel.textColor = [UIColor blackColor];
        _iconLabel.font = NAFontSize(15);
        _iconLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _iconLabel;
}

- (UIButton *)iconImage {
    if (!_iconImage) {
        _iconImage = [UIButton new];
        [_iconImage addTarget:self action:@selector(iconImageAction) forControlEvents:UIControlEventTouchUpInside];
        [_iconImage setBackgroundImage:[UIImage imageNamed:@"icon_tabbar_mine"] forState:UIControlStateNormal];
        _iconImage.contentMode = UIViewContentModeScaleAspectFill;
        _iconImage.layer.borderWidth = 2.0f;
        _iconImage.layer.borderColor = [UIColor yellowColor].CGColor;
    }
    return _iconImage;
}

- (UIButton *)logOutBtn {
    if (!_logOutBtn) {
        _logOutBtn = [UIButton new];
        [_logOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_logOutBtn addTarget:self action:@selector(logOutAction) forControlEvents:UIControlEventTouchUpInside];
        _logOutBtn.backgroundColor = kSetUpCololor(61, 121, 253, 1.0);
    }
    return _logOutBtn;
}

- (UIImageView *)bgImg {
    if (!_bgImg) {
        _bgImg = [UIImageView new];
        _bgImg.userInteractionEnabled = YES;
    }
    return _bgImg;
}

#pragma mark - 退出登录
- (void) logOutAction{
    NSLog(@"退出登录");
    
    self.tabBarController.selectedIndex = 0;
    
    NSUserDefaults *tokenUDF = [NSUserDefaults standardUserDefaults];
    [tokenUDF setValue:@"NO" forKey:@"member_id"];
    [tokenUDF setValue:@"" forKey:@"userName"];
    [tokenUDF synchronize];
    
    [[NSUserDefaults standardUserDefaults] objectForKey:@"member_id"];
}

#pragma mark - 修改头像
- (void) iconImageAction {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:                               @"设置头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"选择本地图片",@"拍照", nil];
    
    [actionSheet showInView:self.view];
}

//2.实现相应代理事件,代理UIActionSheetDelegate,方法如下

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:
(NSInteger)buttonIndex {
    
    // 相册 0 拍照 1
    
    switch (buttonIndex) {
        case 0:
            //从相册中读取
            [self readImageFromAlbum];
            
            break;
        case 1:
            //拍照
            [self readImageFromCamera];
            
            break;
        default:
            break;
    }
}

//从相册中读取

- (void)readImageFromAlbum {
    //创建对象
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    //（选择类型）表示仅仅从相册中选取照片
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //指定代理，因此我们要实现UIImagePickerControllerDelegate,                                                 UINavigationControllerDelegate协议
    imagePicker.delegate = self;
    //设置在相册选完照片后，是否跳到编辑模式进行图片剪裁。(允许用户编辑)
    imagePicker.allowsEditing = YES;
    //显示相册
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)readImageFromCamera {
    if ([UIImagePickerController isSourceTypeAvailable:                                           UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];         imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;         imagePicker.delegate = self;
        
        imagePicker.allowsEditing = YES;
        
        //允许用户编辑
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else {
        //弹出窗口响应点击事件
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告"                         message:@"未检测到摄像头" delegate:nil cancelButtonTitle:nil                                                 otherButtonTitles:@"确定", nil];
        
        [alert show];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
    //保存到本地
    NSData *data = UIImagePNGRepresentation(image);
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"headerImage"];
    
    //将图片添加到对应的视图上
    [self.iconImage setImage:image forState:UIControlStateNormal];

    // 结束操作
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  生成一张毛玻璃图片 CoreImage
 */
- (UIImage*) blur:(UIImage*)theImage {
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:theImage.CGImage];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:15.0f] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return returnImage;
}
/**
 * UIVisualEffectView
 */
- (void) blurImg: (UIImageView *) imgView {
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
//    blurEffectView.frame = imgView.bounds;
    blurEffectView.frame = CGRectMake(imgView.frame.size.width/2,0,
                                  imgView.frame.size.width/2, imgView.frame.size.height);
    [imgView addSubview:blurEffectView];
    
    // 加上以下代码可以使毛玻璃特效更明亮点
    UIVibrancyEffect *vibrancyView = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyView];
    visualEffectView.translatesAutoresizingMaskIntoConstraints = NO;
    [blurEffectView.contentView addSubview:visualEffectView];
}

/**
 *使用GPUImage实现高斯模糊
 */
- (UIImage *)blurryGPUImage:(UIImage *)image withBlurLevel:(CGFloat)blur{
    
    GPUImageGaussianBlurFilter * blurFilter = [[GPUImageGaussianBlurFilter alloc]init];
    blurFilter.blurRadiusInPixels = blur;
    UIImage * blurImage = [blurFilter imageByFilteringImage:image];
    
    return blurImage;
}
@end
