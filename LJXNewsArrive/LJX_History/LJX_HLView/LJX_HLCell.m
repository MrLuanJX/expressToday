//
//  LJX_HLCell.m
//  LJXNewsArrive
//
//  Created by a on 2019/4/25.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "LJX_HLCell.h"
#import "UILabel+LJXLabel.h"

@interface LJX_HLCell()

@property (nonatomic , assign) NSInteger cellTag;

@property (nonatomic , strong) UILabel * firstLine;         // 横线
@property (nonatomic , strong) UILabel * secondLine;        // 横线
@property (nonatomic , strong) UILabel * thirdLine;         // 横线
@property (nonatomic , strong) UILabel * forthLine;         // 横线
@property (nonatomic , strong) UILabel * fiveLine;          // 横线
@property (nonatomic , strong) UILabel * sixLine;           // 横线

@property (nonatomic , strong) UILabel * SLeftLine;         // 竖线
@property (nonatomic , strong) UILabel * SRightLine;        // 竖线
@property (nonatomic , strong) UILabel * SecondLeftLine;    // 竖线
@property (nonatomic , strong) UILabel * SecondRightLine;   // 竖线


@property (nonatomic , strong) UILabel * nongliLabel;       // 农历
@property (nonatomic , strong) UILabel * nongli;            // 农历
@property (nonatomic , strong) UILabel * weekLabel;         // 星期
@property (nonatomic , strong) UILabel * dateLabel;         // 年月日
@property (nonatomic , strong) UILabel * shengxiaoSuici;    // 生肖 岁次
@property (nonatomic , strong) UILabel * star;              // 星座
@property (nonatomic , strong) UILabel * caishen;           // 财神
@property (nonatomic , strong) UILabel * xishen;            // 喜神
@property (nonatomic , strong) UILabel * fushen;            // 福神
@property (nonatomic , strong) UILabel * taishen;           // 今日胎神
@property (nonatomic , strong) UILabel * xiongshen;         // 今日凶神
@property (nonatomic , strong) UILabel * jiri;              // 吉日
@property (nonatomic , strong) UILabel * zhiri;             // 值日（值神）
@property (nonatomic , strong) UILabel * jishenyiqu;        // 吉日宜趋
@property (nonatomic , strong) UILabel * wuxing;            // 五行
@property (nonatomic , strong) UILabel * chongsha;          // 冲煞
@property (nonatomic , strong) UILabel * yiLabel;           // 宜
@property (nonatomic , strong) UILabel * yi;

@property (nonatomic , strong) UILabel * jiLabel;           // 忌
@property (nonatomic , strong) UILabel * ji;

@end

@implementation LJX_HLCell

//创建cell
+(instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier cellTag:(NSInteger) tag {
    
    LJX_HLCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[LJX_HLCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier cellTag:tag] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);
    }
    return cell;
}

- (void)setHlModel:(LJX_HLModel *)hlModel {
    _hlModel = hlModel;
    
    // 年月日
    self.dateLabel.text = [NSString stringWithFormat:@"%@年%@月%@日",hlModel.year,hlModel.month,hlModel.day];
    // 农历
    self.nongli.text = [hlModel.nongli substringFromIndex:hlModel.nongli.length - 4];
    // 星期
    self.weekLabel.attributedText = [self setUpmoney:[NSString stringWithFormat:@"星期%@ ",hlModel.week] danwei:[NSString stringWithFormat:@" %@",hlModel.eweek]];
    // 星座
    self.star.text = hlModel.star;
    // 生肖   五行  岁次
    self.shengxiaoSuici.text = [NSString stringWithFormat:@"生肖：%@   五行：%@  %@",hlModel.shengxiao,hlModel.wuxing,[hlModel.suici componentsJoinedByString:@" "]];
    // 宜
    self.yi.text = [hlModel.yi componentsJoinedByString:@" "];
    // 忌
    self.ji.text = [hlModel.ji componentsJoinedByString:@" "];
    
    // 胎神
    self.taishen.attributedText = [self setUpmoney:@"今日胎神\n" danwei:[NSString stringWithFormat:@"\n%@",hlModel.taishen]];
    // 冲煞
    self.chongsha.attributedText = [self setUpmoney:@"冲煞\n" danwei:[NSString stringWithFormat:@"\n%@  %@",hlModel.chong,hlModel.sha]];
    // 财神
    self.caishen.attributedText = [self setUpmoney:@"财神\n" danwei:[NSString stringWithFormat:@"\n%@",hlModel.caishen]];
    // 喜神
    self.xishen.attributedText = [self setUpmoney:@"喜神\n" danwei:[NSString stringWithFormat:@"\n%@",hlModel.xishen]];
    // 福神
    self.fushen.attributedText = [self setUpmoney:@"福神\n" danwei:[NSString stringWithFormat:@"\n%@",hlModel.fushen]];
    // 吉日
    self.jiri.attributedText = [self setUpmoney:@"吉日\n" danwei:[NSString stringWithFormat:@"%@",hlModel.jiri]];
    // 值日
    self.zhiri.attributedText = [self setUpmoney:@"值日\n" danwei:[NSString stringWithFormat:@"%@",hlModel.zhiri]];
    // 凶神
    self.xiongshen.attributedText = [self setUpmoney:@"凶        神：" danwei:hlModel.xiongshen];
    // 吉神宜趋
    self.jishenyiqu.attributedText = [self setUpmoney:@"吉神宜趋：" danwei:hlModel.jishenyiqu];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellTag:(NSInteger) tag{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        NSLog(@"tag = %ld",(long)tag);
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self configUIWithCellTag:tag];
        [self createConstrainteWithCellTag:tag];
    }
    return self;
}

- (void) configUIWithCellTag:(NSInteger)tag {
    [self.contentView addSubview: self.dateLabel];
    [self.contentView addSubview: self.nongliLabel];
    [self.contentView addSubview: self.star];
    [self.contentView addSubview: self.nongli];
    [self.contentView addSubview: self.weekLabel];
    [self.contentView addSubview: self.shengxiaoSuici];
    
    [self.contentView addSubview: self.firstLine];
    [self.contentView addSubview: self.yiLabel];
    [self.contentView addSubview: self.yi];
    [self.contentView addSubview: self.jiLabel];
    [self.contentView addSubview: self.ji];
    if (tag == 1) {
        
        [self.contentView addSubview: self.secondLine];
        [self.contentView addSubview: self.caishen];
        [self.contentView addSubview: self.SLeftLine];
        [self.contentView addSubview: self.xishen];
        [self.contentView addSubview: self.SRightLine];
        [self.contentView addSubview: self.fushen];
        
        [self.contentView addSubview: self.taishen];
        [self.contentView addSubview: self.chongsha];
        [self.contentView addSubview: self.SecondLeftLine];
        [self.contentView addSubview: self.thirdLine];
        
        [self.contentView addSubview: self.jiri];
        [self.contentView addSubview: self.SecondRightLine];
        [self.contentView addSubview: self.zhiri];
        [self.contentView addSubview: self.forthLine];
        
        [self.contentView addSubview: self.xiongshen];
        [self.contentView addSubview: self.fiveLine];
        
        [self.contentView addSubview: self.jishenyiqu];
        [self.contentView addSubview: self.sixLine];
    }
}

- (void) createConstrainteWithCellTag:(NSInteger)tag{
    
    __weak typeof (self) weakSelf = self;
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (0);//(NAFit(5));
        make.left.right.mas_equalTo (0);
        make.bottom.mas_equalTo (0);//(-NAFit(5));
    }];
    
    [self.dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo (NAFit(10));
        make.width.mas_equalTo (weakSelf.contentView.mas_width).multipliedBy(0.5);
        make.height.mas_equalTo (NAFit(20));
    }];
    
    [self.weekLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (weakSelf.dateLabel.mas_right).offset(NAFit(10));
        make.top.mas_equalTo (weakSelf.dateLabel.mas_top);
        make.right.mas_equalTo (-NAFit(10));
        make.height.mas_equalTo (weakSelf.dateLabel.mas_height);
    }];
    
    [self.nongliLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.dateLabel.mas_bottom).offset(NAFit(10));
        make.left.mas_equalTo (NAFit(10));
        make.width.mas_equalTo(NAFit(20));
        make.height.mas_equalTo(NAFit(40));
    }];
    
    [self.nongli mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo (weakSelf.nongliLabel.mas_centerY);
        make.left.mas_equalTo(weakSelf.nongliLabel.mas_right).offset(NAFit(10));
        make.height.mas_equalTo (weakSelf.nongliLabel.mas_height);
        make.width.mas_equalTo (weakSelf.contentView.mas_width).multipliedBy (0.5);
    }];
    
    [self.star mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo (weakSelf.nongliLabel.mas_centerY);
        make.left.mas_equalTo (weakSelf.nongli.mas_right);
        make.right.mas_equalTo (-NAFit(10));
        make.height.mas_equalTo (weakSelf.nongliLabel.mas_height);
    }];
    
    [self.shengxiaoSuici mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.nongliLabel.mas_bottom).offset(NAFit(10));
        make.left.mas_equalTo (weakSelf.nongliLabel.mas_left);
        make.right.mas_equalTo (weakSelf.star.mas_right);
        make.height.mas_equalTo (NAFit(20));
    }];
    
    [self.firstLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.shengxiaoSuici.mas_bottom).offset(NAFit(10));
        make.width.mas_equalTo (weakSelf.contentView.mas_width);
        make.height.mas_equalTo (1);
    }];
    
    // 宜（第一行）
    self.yi.preferredMaxLayoutWidth = self.contentView.width - NAFit(50);// 如果是多行的话给一个maxWidth
    [self.yi setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.yi mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.firstLine.mas_bottom).offset (NAFit(10));
        make.left.mas_equalTo (NAFit(40));
        make.right.mas_equalTo (-NAFit(10));
    }];
    
    [self.yiLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (NAFit(10));
        make.width.height.mas_equalTo (NAFit(20));
        make.centerY.mas_equalTo (weakSelf.yi.mas_centerY);
    }];
    
    self.ji.preferredMaxLayoutWidth = self.contentView.width - NAFit(50);// 如果是多行的话给一个maxWidth
    [self.ji setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.ji mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.yi.mas_bottom).offset (NAFit(10));
        make.left.mas_equalTo (weakSelf.yi.mas_left);
        make.right.mas_equalTo (-NAFit(10));
        if (tag != 1) {
            make.bottom.mas_equalTo (weakSelf.contentView.mas_bottom).offset (-NAFit(10));
        }
    }];
    
    [self.jiLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo (weakSelf.yiLabel.mas_left);
        make.width.height.mas_equalTo (weakSelf.yiLabel);
        make.centerY.mas_equalTo (weakSelf.ji.mas_centerY);
    }];
    
    if (tag == 1) {
        
        
        [self.secondLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo (weakSelf.ji.mas_bottom).offset(NAFit(10));
            make.height.mas_equalTo (1);
            make.left.right.mas_equalTo (0);
        }];
        
        // 胎神 （第二行）
        [self.taishen mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo (weakSelf.secondLine.mas_bottom).offset(NAFit(10));
            make.width.mas_equalTo (weakSelf.contentView.mas_width).multipliedBy(0.5);
            make.height.mas_equalTo (NAFit(60));
        }];
        
        [self.SecondLeftLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo (weakSelf.taishen.mas_top).offset(NAFit(5));
            make.left.mas_equalTo (weakSelf.taishen.mas_right);
            make.bottom.mas_equalTo (weakSelf.taishen.mas_bottom).offset(-NAFit(5));
            make.width.mas_equalTo (1);
        }];
        
        [self.chongsha mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo (weakSelf.SecondLeftLine.mas_right);
            make.width.height.top.mas_equalTo (weakSelf.taishen);
        }];
        
        [self.thirdLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo (weakSelf.taishen.mas_bottom).offset (NAFit(10));
            make.height.mas_equalTo (1);
            make.left.right.mas_equalTo (0);
        }];
        
        // 财神 (第三行)
        [self.caishen mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo (weakSelf.thirdLine.mas_bottom).offset(NAFit(10));
            make.left.mas_equalTo (NAFit(10));
            make.height.mas_equalTo (NAFit(60));
            make.width.mas_equalTo (weakSelf.contentView.mas_width).multipliedBy(0.3);
        }];
        
        [self.SLeftLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo (weakSelf.caishen.mas_top).offset(NAFit(5));
            make.left.mas_equalTo (weakSelf.caishen.mas_right);
            make.bottom.mas_equalTo (weakSelf.caishen.mas_bottom).offset(-NAFit(5));
            make.width.mas_equalTo (1);
        }];
        
        [self.xishen mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.height.top.mas_equalTo (weakSelf.caishen);
            make.left.mas_equalTo (weakSelf.SLeftLine.mas_right);
        }];
        
        [self.SRightLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo (weakSelf.xishen.mas_right);
            make.width.top.height.mas_equalTo (weakSelf.SLeftLine);
        }];
        
        [self.fushen mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.height.top.mas_equalTo (weakSelf.caishen);
            make.left.mas_equalTo (weakSelf.SRightLine.mas_right);
        }];
        
        [self.forthLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo (weakSelf.caishen.mas_bottom).offset (NAFit(10));
            make.height.mas_equalTo (1);
            make.left.right.mas_equalTo (0);
        }];
        
        // 吉日 （第四行）
        [self.jiri mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo (weakSelf.forthLine.mas_bottom).offset(NAFit(10));
            make.width.mas_equalTo (weakSelf.contentView.mas_width).multipliedBy(0.5);
            make.height.mas_equalTo (NAFit(60));
        }];
        
        [self.SecondRightLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo (weakSelf.SecondLeftLine);
            make.left.mas_equalTo (weakSelf.jiri.mas_right);
            make.top.mas_equalTo (weakSelf.jiri.mas_top).offset (NAFit(5));
            make.bottom.mas_equalTo (weakSelf.jiri.mas_bottom).offset (-NAFit(5));
        }];
        
        [self.zhiri mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.width.height.bottom.mas_equalTo (weakSelf.jiri);
            make.left.mas_equalTo (weakSelf.SecondRightLine.mas_right);
        }];
        
        [self.fiveLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo (weakSelf.jiri.mas_bottom).offset (NAFit(10));
            make.left.right.mas_equalTo (0);
            make.height.mas_equalTo (1);
        }];
        
        // 五行（第五行）
        [self.xiongshen mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo (NAFit(10));
            make.top.mas_equalTo (weakSelf.fiveLine.mas_bottom).offset(NAFit(10));
            make.right.mas_equalTo (-NAFit(10));
            make.height.mas_greaterThanOrEqualTo (NAFit(40));
        }];
        
        [self.sixLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo (weakSelf.xiongshen.mas_bottom).offset (NAFit(10));
            make.left.right.mas_equalTo (0);
            make.height.mas_equalTo (1);
        }];
        // 吉神宜趋 （第六行）
        [self.jishenyiqu mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo (weakSelf.sixLine.mas_bottom).offset(NAFit(10));
            make.left.mas_equalTo (NAFit(10));
            make.right.mas_equalTo (-NAFit(10));
            make.height.mas_greaterThanOrEqualTo (NAFit(40));
            make.bottom.mas_equalTo (weakSelf.contentView.mas_bottom).offset (-NAFit(10));
        }];
        
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [UIView UILayoutCornerRadiusType:UILayoutCornerRadiusAll withCornerRadius:5 View:self.nongliLabel];
    
    [UIView UILayoutCornerRadiusType:UILayoutCornerRadiusAll withCornerRadius:self.yiLabel.width/2 View:self.yiLabel];
    
    [UIView UILayoutCornerRadiusType:UILayoutCornerRadiusAll withCornerRadius:self.jiLabel.width/2 View:self.jiLabel];
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.text = @"2019年04月26日";//[self setUpmoney:@"2019年04月26日" danwei:@"星期五 TUESDAY"];
        _dateLabel.textColor = NAUIColorWithRGB(0x333333, 1.0);
        _dateLabel.font = NAFontBoldSize(20);
        _dateLabel.numberOfLines = 0;
    }
    return _dateLabel;
}

- (UILabel *)weekLabel {
    if (!_weekLabel) {
        _weekLabel = [UILabel new];
        _weekLabel.attributedText = [self setUpmoney:@"星期二 " danwei:@" TUESDAY"];
        _weekLabel.numberOfLines = 0;
        _weekLabel.textAlignment = NSTextAlignmentRight;
    }
    return _weekLabel;
}

- (UILabel *)star {
    if (!_star) {
        _star = [UILabel new];
        _star.text = @"金牛座";
        _star.numberOfLines = 0;
        _star.textAlignment = NSTextAlignmentCenter;
        _star.textColor = [UIColor brownColor];//NAUIColorWithRGB(0x8B0000, 1.0);
        _star.font = NAFontSize(18);
    }
    return _star;
}

- (UILabel *)nongliLabel {
    if (!_nongliLabel) {
        _nongliLabel = [UILabel new];
        _nongliLabel.backgroundColor = [UIColor brownColor];
        _nongliLabel.text = @"农历";
        _nongliLabel.textColor = [UIColor whiteColor];
        _nongliLabel.font = NAFontSize(15);
        _nongliLabel.numberOfLines = 0;
        _nongliLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nongliLabel;
}

- (UILabel *)nongli {
    if (!_nongli) {
        _nongli = [UILabel new];
        _nongli.text = @"九月十五";
        _nongli.textColor = self.nongliLabel.backgroundColor;
        _nongli.font = NAFontBoldSize(17);
        _nongli.numberOfLines = 0;
    }
    return _nongli;
}

- (UILabel *)shengxiaoSuici {
    if (!_shengxiaoSuici) {
        _shengxiaoSuici = [UILabel new];
        _shengxiaoSuici.text = [NSString stringWithFormat:@"生肖：%@   %@  %@",@"牛",@"五行：涧下水",@"乙未年 丙戌月 丙子日"];
        _shengxiaoSuici.textColor = NAUIColorWithRGB(0x333333, 1.0);
        _shengxiaoSuici.font = NAFontSize(15);
        _shengxiaoSuici.numberOfLines = 0;
    }
    return _shengxiaoSuici;
}

- (UILabel *)firstLine {
    if (!_firstLine) {
        _firstLine = [UILabel new];
        _firstLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _firstLine;
}

- (UILabel *)caishen {
    if (!_caishen) {
        _caishen = [UILabel new];
        _caishen.numberOfLines = 0;
        _caishen.textAlignment = NSTextAlignmentCenter;
        _caishen.attributedText = [self setUpmoney:@"财神\n" danwei:@"\n西南"];
    }
    return _caishen;
}

- (UILabel *)SLeftLine {
    if (!_SLeftLine) {
        _SLeftLine = [UILabel new];
        _SLeftLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _SLeftLine;
}

- (UILabel *)xishen {
    if (!_xishen) {
        _xishen = [UILabel new];
        _xishen.numberOfLines = 0;
        _xishen.textAlignment = NSTextAlignmentCenter;
        _xishen.attributedText = [self setUpmoney:@"喜神\n" danwei:@"\n西南"];
    }
    return _xishen;
}

- (UILabel *)SRightLine {
    if (!_SRightLine) {
        _SRightLine = [UILabel new];
        _SRightLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _SRightLine;
}

- (UILabel *)fushen {
    if (!_fushen) {
        _fushen = [UILabel new];
        _fushen.numberOfLines = 0;
        _fushen.textAlignment = NSTextAlignmentCenter;
        _fushen.attributedText = [self setUpmoney:@"福神\n" danwei:@"\n正东"];
    }
    return _fushen;
}

- (UILabel *)secondLine {
    if (!_secondLine) {
        _secondLine = [UILabel new];
        _secondLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _secondLine;
}

- (UILabel *)taishen {
    if (!_taishen) {
        _taishen = [UILabel new];
        _taishen.attributedText = [self setUpmoney:@"今日胎神\n" danwei:@"\n厨灶碓外西南"];
        _taishen.numberOfLines = 0;
        _taishen.textAlignment = NSTextAlignmentCenter;
    }
    return _taishen;
}

- (UILabel *)SecondLeftLine {
    if (!_SecondLeftLine) {
        _SecondLeftLine = [UILabel new];
        _SecondLeftLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _SecondLeftLine;
}

- (UILabel *)SecondRightLine {
    if (!_SecondRightLine) {
        _SecondRightLine = [UILabel new];
        _SecondRightLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _SecondRightLine;
}

- (UILabel *)thirdLine {
    if (!_thirdLine) {
        _thirdLine = [UILabel new];
        _thirdLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _thirdLine;
}

- (UILabel *)chongsha {
    if (!_chongsha) {
        _chongsha = [UILabel new];
        _chongsha.attributedText = [self setUpmoney:@"冲煞\n" danwei:@"\n冲（庚午）马  煞南"];
        _chongsha.numberOfLines = 0;
        _chongsha.textAlignment = NSTextAlignmentCenter;
        [_chongsha sizeToFit];
    }
    return _chongsha;
}

- (UILabel *)jiri {
    if (!_jiri) {
        _jiri = [UILabel new];
        _jiri.attributedText = [self setUpmoney:@"吉日\n" danwei:@"\n天牢（黑道）满日"];
        _jiri.numberOfLines = 0;
        _jiri.textAlignment = NSTextAlignmentCenter;
        [_jiri sizeToFit];
    }
    return _jiri;
}

- (UILabel *)zhiri {
    if (!_zhiri) {
        _zhiri = [UILabel new];
        _zhiri.attributedText = [self setUpmoney:@"值日\n" danwei:@"\n天牢（黑道凶日）"];
        _zhiri.numberOfLines = 0;
        _zhiri.textAlignment = NSTextAlignmentCenter;
        [_zhiri sizeToFit];
    }
    return _zhiri;
}

- (UILabel *)forthLine {
    if (!_forthLine) {
        _forthLine = [UILabel new];
        _forthLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _forthLine;
}

- (UILabel *)xiongshen {
    if (!_xiongshen) {
        _xiongshen = [UILabel new];
        _xiongshen.attributedText = [self setUpmoney:@"凶        神：" danwei:@"灾煞 天火 大煞 归忌 天牢 触水龙"];
        _xiongshen.textAlignment = NSTextAlignmentLeft;
        _xiongshen.numberOfLines = 0;
    }
    return _xiongshen;
}

- (UILabel *)fiveLine {
    if (!_fiveLine) {
        _fiveLine = [UILabel new];
        _fiveLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _fiveLine;
}

- (UILabel *)jishenyiqu {
    if (!_jishenyiqu) {
        _jishenyiqu = [UILabel new];
        _jishenyiqu.attributedText = [self setUpmoney:@"吉神宜趋：" danwei:@"天德 月德 时德 福德 民日 天巫 普护 鸣犬对"];
        _jishenyiqu.textAlignment = NSTextAlignmentLeft;
        _jishenyiqu.numberOfLines = 0;
    }
    return _jishenyiqu;
}

- (UILabel *)sixLine {
    if (!_sixLine) {
        _sixLine = [UILabel new];
        _sixLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _sixLine;
}

- (UILabel *)yiLabel {
    if (!_yiLabel) {
        _yiLabel = [UILabel new];
        _yiLabel.text = @"宜";
        _yiLabel.backgroundColor = NAUIColorWithRGB(0x104E8B, 1.0);
        _yiLabel.textColor = [UIColor whiteColor];
        _yiLabel.font = NAFontSize(15);
        _yiLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _yiLabel;
}

- (UILabel *)yi {
    if (!_yi) {
        _yi = [UILabel new];
        _yi.text = @"纳采 成服 天德 月德 时德 福德 民日 天巫 普护 鸣犬对 天德 月德 时德 福德 民日 天巫 普护 鸣犬对 天德 月德 时德 福德 民日 天巫 普护 鸣犬对";
        _yi.font = NAFontSize(15);//NAFontSize(16);
        _yi.textColor = NAUIColorWithRGB(0x333333, 1.0);
        _yi.textAlignment = NSTextAlignmentLeft;
        _yi.numberOfLines = 0;
    }
    return _yi;
}

- (UILabel *)jiLabel {
    if (!_jiLabel) {
        _jiLabel = [UILabel new];
        _jiLabel.text = @"忌";
        _jiLabel.backgroundColor = NAUIColorWithRGB(0x8B0000, 1.0);
        _jiLabel.textColor = _yiLabel.textColor;
        _jiLabel.font = _yiLabel.font;
        _jiLabel.textAlignment = _yiLabel.textAlignment;
    }
    return _jiLabel;
}

- (UILabel *)ji {
    if (!_ji) {
        _ji = [UILabel new];
        _ji.text = @"入宅 上梁 谢土 天德 月德 时德 福德 民日 天巫 普护 鸣犬对 天德 月德 时德 福德 民日 天巫 普护 鸣犬对 天德 月德 时德 福德 民日 天巫 普护 鸣犬对";
        _ji.font = NAFontSize(15);
        _ji.textColor = NAUIColorWithRGB(0x333333, 1.0);
        _ji.numberOfLines = 0;
        _ji.textAlignment = NSTextAlignmentLeft;
    }
    return _ji;
}

- (NSMutableAttributedString*)setUpmoney:(NSString *)money danwei:(NSString *)danwei{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",money,danwei]];
    
    [str addAttribute:NSForegroundColorAttributeName
                value:NAUIColorWithRGB(0x8B0000, 1.0)
                range:NSMakeRange(0,[money length])];
    [str addAttribute:NSForegroundColorAttributeName
                value:NAUIColorWithRGB(0x666666, 1.0)
                range:NSMakeRange([money length],[danwei length])];
    
    [str addAttribute:NSFontAttributeName
                value:NAFontBoldSize(17)
                range:NSMakeRange(0, [money length])];
    [str addAttribute:NSFontAttributeName
                value:NAFontSize(15)
                range:NSMakeRange([money length], [danwei length])];
    
    return str;
}

@end
