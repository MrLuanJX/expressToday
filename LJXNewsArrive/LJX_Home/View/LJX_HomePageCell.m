//
//  LJX_HomePageCell.m
//  LJXNewsArrive
//
//  Created by 栾金鑫 on 2019/4/13.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "LJX_HomePageCell.h"

@interface LJX_HomePageCell()

@property (nonatomic , strong) UILabel * titleLabel;        // 标题

@property (nonatomic , strong) UILabel * dateLabel;         // 时间

@property (nonatomic , strong) UILabel * authLabel;         // 作者

@property (nonatomic , strong) UIImageView * leftImg;       // 左图

@property (nonatomic , strong) UIImageView * midImg;        // 中图

@property (nonatomic , strong) UIImageView * rightImg;      // 右图

@end

@implementation LJX_HomePageCell

//创建cell
+ (instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier {
    
    LJX_HomePageCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        
        cell=[[LJX_HomePageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);
    }
    return cell;
}

- (void)setHomeListModel:(LJX_HomeModel *)homeListModel {
    _homeListModel = homeListModel;
    
    self.titleLabel.text = homeListModel.title;
    self.dateLabel.text = homeListModel.date;
    
    [self.leftImg sd_setImageWithURL:[NSURL URLWithString:homeListModel.thumbnail_pic_s] placeholderImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    
    [self.midImg sd_setImageWithURL:[NSURL URLWithString:homeListModel.thumbnail_pic_s02] placeholderImage:[UIImage imageWithColor:[UIColor whiteColor]]];

    [self.rightImg sd_setImageWithURL:[NSURL URLWithString:homeListModel.thumbnail_pic_s03] placeholderImage:[UIImage imageWithColor:[UIColor whiteColor]]];
}

- (void)setIndex:(NSIndexPath *)index {
    _index = index;
    NSLog(@"row = %ld",index.row);
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self createSubView];
        [self createConstrainte];
    }
    return self;
}

- (void)createSubView {
    [self.contentView addSubview: self.titleLabel];
    [self.contentView addSubview: self.authLabel];
    [self.contentView addSubview: self.dateLabel];
    [self.contentView addSubview: self.leftImg];
    [self.contentView addSubview: self.midImg];
    [self.contentView addSubview: self.rightImg];
}

- (void)createConstrainte {
    __weak typeof (self) weakSelf = self;
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAFit(5));
        make.bottom.mas_equalTo(-NAFit(5));
        make.left.right.mas_equalTo(0);
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(NAFit(10));
        make.right.mas_equalTo(-NAFit(10));
        make.height.mas_greaterThanOrEqualTo(NAFit(60));
    }];
    
    [self.dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.titleLabel.mas_left);
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(NAFit(10));
        make.right.mas_equalTo(weakSelf.titleLabel.mas_right);
        make.height.mas_greaterThanOrEqualTo(NAFit(20));
    }];
    
    NSInteger padding = 10;
    [@[self.leftImg, self.midImg, self.rightImg] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:padding leadSpacing:padding tailSpacing:padding];
    
    [@[self.leftImg, self.midImg, self.rightImg] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.dateLabel.mas_bottom).offset(NAFit(15));
        make.height.mas_equalTo(NAFit(88));
        make.bottom.mas_equalTo(weakSelf.contentView).offset(-NAFit(10));
    }];
    
//    [self.authLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(weakSelf.titleLabel.mas_left);
//        make.top.mas_equalTo(weakSelf.leftImg.mas_bottom).offset(NAFit(15));
//        make.width.mas_equalTo(weakSelf.contentView.mas_width).multipliedBy(0.5);
//        make.height.mas_equalTo(NAFit(30));
//        make.bottom.mas_equalTo(weakSelf.contentView).offset(-NAFit(10));
//    }];
    
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = NAFontBoldSize(18);
        _titleLabel.textColor = NAUIColorWithRGB(0x333333, 1.0);
    }
    return _titleLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.font = NAFontSize(12);
        _dateLabel.textColor = NAUIColorWithRGB(0x666666, 1.0);
//        _dateLabel.textAlignment = NSTextAlignmentRight;
    }
    return _dateLabel;
}

- (UILabel *)authLabel {
    if (!_authLabel) {
        _authLabel = [UILabel new];
        _authLabel.font = self.dateLabel.font;
        _authLabel.textColor = self.dateLabel.textColor;
    }
    return _authLabel;
}

- (UIImageView *)leftImg {
    if (!_leftImg) {
        _leftImg = [UIImageView new];
        _leftImg.backgroundColor = [UIColor redColor];
        _leftImg.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _leftImg;
}

- (UIImageView *)midImg {
    if (!_midImg) {
        _midImg = [UIImageView new];
        _midImg.backgroundColor = self.leftImg.backgroundColor;
        _midImg.contentMode = self.leftImg.contentMode;
    }
    return _midImg;
}

- (UIImageView *)rightImg {
    if (!_rightImg) {
        _rightImg = [UIImageView new];
        _rightImg.backgroundColor = self.leftImg.backgroundColor;
        _rightImg.contentMode = self.leftImg.contentMode;
    }
    return _rightImg;
}

@end
