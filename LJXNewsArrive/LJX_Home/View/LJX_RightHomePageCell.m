//
//  LJX_RightHomePageCell.m
//  LJXNewsArrive
//
//  Created by a on 2019/4/29.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "LJX_RightHomePageCell.h"

@interface LJX_RightHomePageCell ()

@property (nonatomic , strong) UILabel * titleLabel;        // 标题

@property (nonatomic , strong) UILabel * dateLabel;         // 时间

@property (nonatomic , strong) UIImageView * leftImg;       // 左图

@end

@implementation LJX_RightHomePageCell

//创建cell
+ (instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier {
    
    LJX_RightHomePageCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        
        cell=[[LJX_RightHomePageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
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
    [self.contentView addSubview: self.dateLabel];
    [self.contentView addSubview: self.leftImg];
}

- (void)createConstrainte {
    __weak typeof (self) weakSelf = self;
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAFit(5));
        make.bottom.mas_equalTo(-NAFit(5));
        make.left.right.mas_equalTo(0);
    }];
    
    [self.leftImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAFit(10));
        make.right.mas_equalTo (-NAFit(10));
        make.width.height.mas_equalTo (weakSelf.contentView.mas_width).multipliedBy (0.3);
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.leftImg.mas_left).offset (-NAFit(10));
        make.top.mas_equalTo (weakSelf.leftImg.mas_top);
        make.left.mas_equalTo(NAFit(10));
        make.height.mas_equalTo(weakSelf.leftImg.mas_height);
    }];
    
    [self.dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(NAFit(10));
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(NAFit(10));
        make.right.mas_equalTo(weakSelf.titleLabel.mas_right);
        make.height.mas_equalTo(NAFit(20));
        make.bottom.mas_equalTo (weakSelf.contentView.mas_bottom).offset (-NAFit(10));
    }];
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
    }
    return _dateLabel;
}

- (UIImageView *)leftImg {
    if (!_leftImg) {
        _leftImg = [UIImageView new];
        //        _leftImg.backgroundColor = [UIColor redColor];
        _leftImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _leftImg;
}
@end
