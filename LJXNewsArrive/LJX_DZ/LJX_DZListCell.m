//
//  LJX_DZListCell.m
//  LJXNewsArrive
//
//  Created by a on 2019/4/19.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "LJX_DZListCell.h"


@interface LJX_DZListCell ()
// 头像
@property (nonatomic , strong) UIButton * iconBtn;
// 作者
@property (nonatomic , strong) UILabel * authLabel;
// 标题
@property (nonatomic , strong) UILabel * titleLabel;
// 时间
@property (nonatomic , strong) UILabel * passtime;
// 按钮View
@property (nonatomic , strong) UIView * btnsView;
// 点赞数
@property (nonatomic , strong) UIButton * upBtn;
// 贬低数
@property (nonatomic , strong) UIButton * downBtn;
// 转发数
@property (nonatomic , strong) UIButton * shareBtn;
// 评论数
@property (nonatomic , strong) UIButton * commentBtn;
// 图片
@property (nonatomic , strong) UILabel * careLabel;
@property (nonatomic , strong) FLAnimatedImageView * animaedImage;
// 精选热评
@property (nonatomic , strong) UILabel * topCommentLabel;
// 热门评论view
@property (nonatomic , strong) UIView * topCommentView;
// 热门评论头像
@property (nonatomic , strong) UIButton * topCommentIconBtn;
// 热门评论者
@property (nonatomic , strong) UILabel * topCommentAuthLabel;
// 热门评论内容
@property (nonatomic , strong) UILabel * topCommentContentLabel;

@property (nonatomic , strong) MASConstraint * imgHeight;

@property (nonatomic , strong) MASConstraint * imgWidth;

@property (nonatomic , strong) MASConstraint * topCommentViewHeight;

@property (nonatomic , strong) MASConstraint * topContentHeight;

@end

@implementation LJX_DZListCell

//创建cell
+(instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier{
    
    LJX_DZListCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[LJX_DZListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);
    }
    return cell;
}

- (void)setCurrentType:(NSInteger)currentType {
    _currentType = currentType;
}

- (void)setDzModel:(LJX_DZModel *)dzModel {
    _dzModel = dzModel;
    // 头像
    [self.iconBtn sd_setImageWithURL:[NSURL URLWithString:self.dzModel.header] forState:UIControlStateNormal placeholderImage:[UIImage imageWithColor:[UIColor redColor]]];
    // 作者
    self.authLabel.text = self.dzModel.name;
    // 时间
    self.passtime.text = self.dzModel.passtime;
    // 标题
    self.titleLabel.text = self.dzModel.text;
    // 图片
    NSString * imageURL = self.currentType == 0 ? self.dzModel.images : self.dzModel.thumbnail;
    
    UIImage * animage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
    
    int imageW = (int)animage.size.width;
    int imageH = (int)animage.size.height;
    
    if (self.currentType == 0) {
        CGFloat hei = 0.0;
        CGFloat wid;
        
        NSLog(@"width = %f----%f---%d---%d",animage.size.width,animage.size.height, imageW,imageH);
    
        if (imageH/imageW > 3.0) {
            NSLog(@"大于3");
            
            wid = animage.size.width/3;
            hei = animage.size.width/3;            
            self.careLabel.backgroundColor = NAUIColorWithRGB(0x1874CD, 1.0);
            self.careLabel.text = @"长图";
            self.animaedImage.contentMode = UIViewContentModeTop;
        } else {
            if (imageH >= 1000) {
                wid = animage.size.width / 4;
                hei = animage.size.height / 4;
            } else {
                wid = animage.size.width/3;
                hei = animage.size.height/3;
            }
            self.animaedImage.contentMode = UIViewContentModeScaleAspectFill;
            self.careLabel.backgroundColor = [UIColor clearColor];
            self.careLabel.text = @"";
        }
        
        /*
        if (animage.size.height/animage.size.width > 2.000000f) {
            wid = animage.size.width/3;
            hei = animage.size.width/3*3;
                self.careLabel.backgroundColor = NAUIColorWithRGB(0x1874CD, 1.0);
                self.careLabel.text = @"长图";
        } else {
            if (animage.size.height >= 1000.000000f) {
                wid = animage.size.width /5;
                hei = animage.size.height/5;
            } else {
                wid = animage.size.width/3;
                hei = animage.size.height/3;
            }
            
            self.careLabel.backgroundColor = [UIColor clearColor];
            self.careLabel.text = @"";
        }
         
        
        
        
        if (animage.size.height/animage.size.width > 5.000000f) {
            wid = animage.size.width/3;
            hei = animage.size.width/6;
            self.careLabel.backgroundColor = NAUIColorWithRGB(0x1874CD, 1.0);
            self.careLabel.text = @"长图";
            self.animaedImage.contentMode = UIViewContentModeTop;
        } else {
            wid = animage.size.width/3;
            hei = animage.size.height/3;
        }
        */
        self.animaedImage.image = [self OriginImage:animage scaleToSize:CGSizeMake(wid, hei)];
    } else if (self.currentType == 1){

        self.careLabel.backgroundColor = NAUIColorWithRGB(0xB8860B, 1.0);
        self.careLabel.text = @"gif图";
        self.animaedImage.image = [self OriginImage:animage scaleToSize:CGSizeMake(animage.size.width, animage.size.height)];

    }
   
    [self.upBtn setTitle:self.dzModel.up forState:UIControlStateNormal];
    [self.downBtn setTitle:self.dzModel.down forState:UIControlStateNormal];
    [self.shareBtn setTitle:self.dzModel.forward forState:UIControlStateNormal];
    [self.commentBtn setTitle:self.dzModel.comment forState:UIControlStateNormal];
    
    __weak typeof (self) weakSelf = self;

    if (! NANULLString(self.dzModel.top_comments_name)) {
        weakSelf.topCommentViewHeight.mas_lessThanOrEqualTo (NAFit(140));
        weakSelf.topContentHeight.mas_equalTo (NAFit(30));
        // 头像
        [self.topCommentIconBtn sd_setImageWithURL:[NSURL URLWithString:self.dzModel.top_comments_header] forState:UIControlStateNormal placeholderImage:[UIImage imageWithColor:[UIColor redColor]]];
        // 姓名
        self.topCommentAuthLabel.text = self.dzModel.top_comments_name;
        // 内容
        self.topCommentContentLabel.text = self.dzModel.top_comments_content;
    }else {
        weakSelf.topCommentViewHeight.mas_lessThanOrEqualTo (0);
        weakSelf.topContentHeight.mas_equalTo(0);
        // 头像
        [self.topCommentIconBtn sd_setImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal placeholderImage:[UIImage imageWithColor:[UIColor redColor]]];
        // 姓名
        self.topCommentAuthLabel.text = @"";
        // 内容
        self.topCommentContentLabel.text = @"";
    }
    
//    if (self.currentType == 0) {
//        self.careLabel.backgroundColor = NAUIColorWithRGB(0x1874CD, 1.0);
//        self.careLabel.text = @"长图";
//    } else if (self.currentType == 1) {
//        self.careLabel.backgroundColor = NAUIColorWithRGB(0xB8860B, 1.0);
//        self.careLabel.text = @"gif图";
//    }
}

-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.contentView.backgroundColor = [UIColor whiteColor];

        [self configUI];
        
        [self createConstrainte];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
//    if (!NANULLString(self.dzModel.top_comments_name)) {
//        [UIView setBorderWithView:self.btnsView top:NO left:NO bottom:YES right:NO borderColor:NAUIColorWithRGB(0xC1C1C1, 1.0) borderWidth:1.0];
//    }
    
    [UIView UILayoutCornerRadiusType:UILayoutCornerRadiusAll withCornerRadius:self.iconBtn.width View:self.iconBtn];

    [UIView UILayoutCornerRadiusType:UILayoutCornerRadiusAll withCornerRadius:self.topCommentIconBtn.width View:self.topCommentIconBtn];
}

- (void) configUI {
    [self.contentView addSubview: self.iconBtn];
    [self.contentView addSubview: self.authLabel];
    [self.contentView addSubview: self.passtime];
    [self.contentView addSubview: self.titleLabel];

    [self.contentView addSubview: self.btnsView];
    [self.btnsView addSubview: self.upBtn];
    [self.btnsView addSubview: self.downBtn];
    [self.btnsView addSubview: self.shareBtn];
    [self.btnsView addSubview: self.commentBtn];

    [self.contentView addSubview: self.topCommentView];
    [self.topCommentView addSubview: self.topCommentLabel];
    [self.topCommentView addSubview: self.topCommentIconBtn];
    [self.topCommentView addSubview: self.topCommentAuthLabel];
    [self.topCommentView addSubview: self.topCommentContentLabel];
    
    [self.contentView addSubview: self.animaedImage];
    [self.animaedImage addSubview: self.careLabel];
}

- (void) createConstrainte {
    __weak typeof (self) weakSelf = self;
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (NAFit(5));
        make.left.right.mas_equalTo (0);
        make.bottom.mas_equalTo (-NAFit(5));
    }];
    
    [self.iconBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo (NAFit(10));
        make.width.height.mas_equalTo (NAFit(50));
    }];
    
    [self.authLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (weakSelf.iconBtn.mas_right).offset(NAFit(10));
        make.top.mas_equalTo (weakSelf.iconBtn.mas_top);
        make.right.mas_equalTo(-NAFit(10));
        make.height.mas_equalTo (NAFit(20));
    }];
    
    [self.passtime mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.authLabel.mas_bottom).offset (NAFit(10));
        make.left.right.mas_equalTo (weakSelf.authLabel);
        make.bottom.mas_equalTo (weakSelf.iconBtn.mas_bottom);
    }];
   
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.iconBtn.mas_bottom).offset (NAFit(10));
        make.left.mas_equalTo (NAFit(10));
        make.right.mas_equalTo (-NAFit(10));
        make.height.mas_greaterThanOrEqualTo (NAFit(40));
    }];
    
    [self.animaedImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo (weakSelf.contentView.mas_centerX);
        make.top.mas_equalTo (weakSelf.titleLabel.mas_bottom).offset (NAFit(10));
//        weakSelf.imgHeight = make.height.mas_equalTo (NAFit(200));
//        weakSelf.imgWidth = make.width.mas_equalTo (NAFit(300));
    }];
    
    [self.careLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(weakSelf.animaedImage);
        make.width.mas_equalTo (NAFit(40));
        make.height.mas_equalTo (NAFit(20));
    }];
    
    [self.btnsView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.animaedImage.mas_bottom).offset (NAFit(10));
        make.left.right.mas_equalTo (weakSelf.contentView);
        make.height.mas_equalTo (NAFit(40));
    }];
    
    // 实现masonry水平方向固定控件高度方法
    [@[self.upBtn, self.downBtn, self.shareBtn, self.commentBtn] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:NAFit(30) leadSpacing:NAFit(10) tailSpacing:NAFit(10)];
    
    [@[self.upBtn, self.downBtn, self.shareBtn, self.commentBtn] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo (0);
    }];
    
    [self.topCommentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.btnsView.mas_bottom);
        make.left.right.mas_equalTo (weakSelf.contentView);
        weakSelf.topCommentViewHeight = make.height.mas_lessThanOrEqualTo (NAFit(140));
        make.bottom.mas_equalTo (weakSelf.contentView.mas_bottom);
    }];
    
    [self.topCommentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo (NAFit(10));
        make.right.mas_equalTo (weakSelf.contentView.mas_right).offset (-NAFit(10));
        weakSelf.topContentHeight = make.height.mas_equalTo (NAFit(30));
    }];
    
    [self.topCommentIconBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.topCommentLabel.mas_bottom).offset(NAFit(10));
        make.left.mas_equalTo (NAFit(10));
        make.width.mas_equalTo (NAFit(30));
        make.height.mas_equalTo (NAFit(30));
    }];
    
    [self.topCommentAuthLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo (weakSelf.topCommentIconBtn.mas_centerY);
        make.left.mas_equalTo (weakSelf.topCommentIconBtn.mas_right).offset (NAFit(10));
        make.right.mas_equalTo (-NAFit(10));
        make.height.mas_equalTo (NAFit(30));
    }];
    
    [self.topCommentContentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.topCommentIconBtn.mas_bottom).offset (NAFit(10));
        make.left.mas_equalTo (weakSelf.topCommentIconBtn.mas_left);
        make.right.mas_equalTo (weakSelf.topCommentAuthLabel.mas_right);
        make.height.mas_equalTo (NAFit(40));
        make.bottom.mas_equalTo (weakSelf.topCommentView.mas_bottom).offset (-NAFit(10));
    }];
}

- (UIButton *)iconBtn {
    if (!_iconBtn) {
        _iconBtn = [UIButton new];
//        _iconBtn.backgroundColor = [UIColor redColor];
    }
    return _iconBtn;
}

- (UILabel *)authLabel {
    if (!_authLabel) {
        _authLabel = [UILabel new];
        _authLabel.font = NAFontSize(16);
        _authLabel.text = @"作者";
    }
    return _authLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
//        _titleLabel.backgroundColor = [UIColor greenColor];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = NAFontBoldSize(16);
        _titleLabel.text = @"textContent";
    }
    return _titleLabel;
}

- (UILabel *)passtime {
    if (!_passtime) {
        _passtime = [UILabel new];
        _passtime.textColor = NAUIColorWithRGB(0x666666, 1.0);
        _passtime.font = NAFontSize(13);
        _passtime.text = @"2019-04-19 11:41:50";
    }
    return _passtime;
}

- (UIView *)btnsView {
    if (!_btnsView) {
        _btnsView = [UIView new];
//        _btnsView.backgroundColor = [UIColor yellowColor];
    }
    return _btnsView;
}

- (UIButton *)upBtn {
    if (!_upBtn) {
        _upBtn = [UIButton new];
        [_upBtn setTitle:@"121111111" forState:UIControlStateNormal];
        _upBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [_upBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_upBtn setImage:[UIImage imageNamed:@"wd_comment_like_icon"] forState:UIControlStateNormal];
        _upBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -NAFit(10));
    }
    return _upBtn;
}

- (UIButton *)downBtn {
    if (!_downBtn) {
        _downBtn = [UIButton new];
        UIImage * upImg = [UIImage imageNamed:@"wd_comment_like_icon"];
        [_downBtn setImage:[UIImage image:upImg rotation:UIImageOrientationDown] forState:UIControlStateNormal];
        [_downBtn setTitle:@"11111111" forState:UIControlStateNormal];
        _downBtn.titleLabel.font = NAFontSize(11);
        [_downBtn setTitleColor:NAUIColorWithRGB(0x999999, 1.0) forState:UIControlStateNormal];
        _downBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -NAFit(10));
    }
    return _downBtn;
}

- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [UIButton new];
        [_shareBtn setImage:[UIImage imageNamed:@"feed_share"] forState:UIControlStateNormal];
        [_shareBtn setTitle:@"1" forState:UIControlStateNormal];
        _shareBtn.titleLabel.font = NAFontSize(11);
        [_shareBtn setTitleColor:NAUIColorWithRGB(0x999999, 1.0) forState:UIControlStateNormal];
        _shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -NAFit(10));
    }
    return _shareBtn;
}

- (UIButton *)commentBtn {
    if (!_commentBtn) {
        _commentBtn = [UIButton new];
        [_commentBtn setImage:[UIImage imageNamed:@"comment_feed"] forState:UIControlStateNormal];
        [_commentBtn setTitle:@"728" forState:UIControlStateNormal];
        _commentBtn.titleLabel.font = NAFontSize(11);
        [_commentBtn setTitleColor:NAUIColorWithRGB(0x999999, 1.0) forState:UIControlStateNormal];
        _commentBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -NAFit(10));
    }
    return _commentBtn;
}

- (UILabel *)topCommentLabel {
    if (!_topCommentLabel) {
        _topCommentLabel = [UILabel new];
        _topCommentLabel.text = @"精选热评:";
        _topCommentLabel.textColor = NAUIColorWithRGB(0xA52A2A, 1.0);
        _topCommentLabel.font = NAFontBoldSize(20);
    }
    return _topCommentLabel;
}

- (UIView *)topCommentView {
    if (!_topCommentView) {
        _topCommentView = [UIView new];
//        _topCommentView.backgroundColor = [UIColor redColor];
    }
    return _topCommentView;
}

- (UIButton *)topCommentIconBtn {
    if (!_topCommentIconBtn) {
        _topCommentIconBtn = [UIButton new];
//        _topCommentIconBtn.backgroundColor = [UIColor cyanColor];
    }
    return _topCommentIconBtn;
}

- (UILabel *)topCommentAuthLabel {
    if (!_topCommentAuthLabel) {
        _topCommentAuthLabel = [UILabel new];
        _topCommentAuthLabel.font = NAFontSize(16);
    }
    return _topCommentAuthLabel;
}

- (UILabel *)topCommentContentLabel {
    if (!_topCommentContentLabel) {
        _topCommentContentLabel = [UILabel new];
        _topCommentContentLabel.numberOfLines = 0;
        _topCommentContentLabel.font = NAFontSize(16);
    }
    return _topCommentContentLabel;
}

- (UILabel *)careLabel {
    if (!_careLabel) {
        _careLabel = [UILabel new];
        _careLabel.textColor = [UIColor whiteColor];
        _careLabel.font = NAFontSize(11);
        _careLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _careLabel;
}

- (FLAnimatedImageView *)animaedImage {
    if (!_animaedImage) {
        _animaedImage = [FLAnimatedImageView new];
        _animaedImage.contentMode = UIViewContentModeScaleToFill;
//        FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://wimg.spriteapp.cn/ugc/2019/04/18/5cb7f84899747_a_1.jpg"]]];
//        [_animaedImage sd_setImageWithURL:[NSURL URLWithString:@"http://wimg.spriteapp.cn/ugc/2019/04/18/5cb7f84899747_a_1.jpg"]];
////        _animaedImage.animatedImage = image;
//        _animaedImage.backgroundColor = [UIColor lightGrayColor];
    }
    return _animaedImage;
}

//  http://wimg.spriteapp.cn/ugc/2019/04/18/5cb7f84899747_a_1.jpg   http://wimg.spriteapp.cn/ugc/2019/04/18/5cb7f84899747.gif
@end
