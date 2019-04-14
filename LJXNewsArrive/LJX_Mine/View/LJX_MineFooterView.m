//
//  LJX_MineFooterView.m
//  LJXNewsArrive
//
//  Created by 栾金鑫 on 2019/4/13.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "LJX_MineFooterView.h"

@interface LJX_MineFooterView ()

@property (nonatomic , strong) UIButton * loginOutBtn;

@end

@implementation LJX_MineFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.loginOutBtn];
    
        [self createConstrainte];
    }
    return self;
}

- (void)createConstrainte{
    __weak typeof (self) weakSelf = self;
    
    [self.loginOutBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (NAFit(20));
        make.right.mas_equalTo(-NAFit(20));
        make.top.mas_equalTo(NAFit(50));
        make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(-NAFit(10));
        make.height.mas_equalTo(NAFit(50));
    }];
}

-(UIButton *)loginOutBtn{
    if (!_loginOutBtn) {
        _loginOutBtn = [UIButton new];
        _loginOutBtn.layer.cornerRadius = 3.0f;
        _loginOutBtn.layer.masksToBounds = YES;
        _loginOutBtn.backgroundColor = kSetUpCololor(61, 121, 253, 1.0);
        [_loginOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [_loginOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginOutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [_loginOutBtn addTarget:self action:@selector(loginOutAction:) forControlEvents:UIControlEventTouchUpInside];
        _loginOutBtn.titleLabel.font = NAFontSize(15);
    }
    return _loginOutBtn;
}

- (void)loginOutAction:(UIButton *)sender{
    if (self.logOutBlock) {
        self.logOutBlock();
    }
}

@end
