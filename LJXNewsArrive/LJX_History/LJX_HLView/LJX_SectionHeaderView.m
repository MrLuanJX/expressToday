//
//  LJX_SectionHeaderView.m
//  LJXNewsArrive
//
//  Created by a on 2019/4/26.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "LJX_SectionHeaderView.h"

@interface LJX_SectionHeaderView ()

@property (nonatomic , strong) UIView * lineView;

@property (nonatomic , strong) UILabel * titleLabel;

@property (nonatomic , strong) UIView * bgView;

@property (nonatomic , strong) UIButton * moreBtn;

@end

@implementation LJX_SectionHeaderView

- (void)setIndex:(NSInteger)index {
    
    _index = index;
    
    self.moreBtn.hidden = index == 0 ? YES : NO;
    
    NSArray * sectionTitleArray = @[@"今日运势",@"今日黄历",@"今日历史"];
    
    self.titleLabel.text = sectionTitleArray[index];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);
        
        [self configUI];
        
        [self createConstrainte];
    }
    return self;
}

- (void) configUI {

    [self addSubview: self.bgView];
    
    [self.bgView addSubview: self.lineView];
    
    [self.bgView addSubview: self.titleLabel];
    
    [self.bgView addSubview: self.moreBtn];
}

- (void) createConstrainte {
    __weak typeof (self) weakSelf = self;
    
    [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (NAFit(5));
        make.bottom.mas_equalTo (-NAFit(5));
        make.left.right.mas_equalTo (0);
    }];
    
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (0);
        make.top.mas_equalTo (NAFit(10));
        make.bottom.mas_equalTo (-NAFit(10));
        make.width.mas_equalTo (NAFit(5));
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (weakSelf.lineView.mas_right).offset(NAFit(10));
        make.right.mas_equalTo (-NAFit(100));
        make.top.bottom.mas_equalTo (weakSelf.lineView);
    }];

    [self.moreBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo (-NAFit(10));
        make.top.bottom.mas_equalTo (weakSelf.bgView);
        make.width.mas_equalTo (NAFit(60));
    }];
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = NAUIColorWithRGB(0x1874CD, 1.0);
    }
    return _lineView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = NAFontBoldSize(18);
        _titleLabel.textColor = NAUIColorWithRGB(0x333333, 1.0);
    }
    return _titleLabel;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UIButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn = [UIButton new];
        [_moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:NAUIColorWithRGB(0x666666, 1.0) forState:UIControlStateNormal];
        _moreBtn.titleLabel.font = NAFontSize(14);
        [_moreBtn addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}

- (void) moreAction: (UIButton *)sender{
    NSLog(@"查看更多");
    if (self.moreBtnActionBlock) {
        self.moreBtnActionBlock(self.index);
    }
}

@end
