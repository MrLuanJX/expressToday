//
//  MineCell.m
//  LJXNewsArrive
//
//  Created by 栾金鑫 on 2019/4/13.
//  Copyright © 2019年 栾金鑫. All rights reserved.
//

#import "LJX_MineCell.h"

@interface LJX_MineCell()

@property (nonatomic , strong) UILabel * title;

@property (nonatomic , strong) UILabel *decLabel;

@property (nonatomic , strong) UIImageView * icon;

@property (nonatomic , strong) UIImageView * arrows;

@end

@implementation LJX_MineCell

//创建cell
+(instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier{
    
    LJX_MineCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[LJX_MineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = kSetUpCololor(242, 242, 242, 1.0);
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self createSubView];
        [self createConstrainte];
    }
    return self;
}

-(void)setIndex:(NSIndexPath *)index{
    _index = index;
    if (index.row == 4) {
        self.arrows.hidden = YES;
        self.decLabel.text = APP_VERSION ;
    }
}

- (void)setFolderSize:(NSString *)folderSize {
    _folderSize = folderSize;
        
    if (self.index.row == 3) {
        self.decLabel.text = [NSString stringWithFormat:@"%@M",self.folderSize];
    }
}

-(void)setMineModel:(LJX_MineListModel *)mineModel{
    _mineModel = mineModel;
    
    self.icon.image = [UIImage imageNamed:self.mineModel.icon];
    self.title.text = self.mineModel.name;
}

-(void)createSubView {
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.decLabel];
    [self.contentView addSubview:self.arrows];
}

#pragma mark - privete

-(void)createConstrainte {
    __weak typeof (self) weakSelf = self;
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
    }];
    
    [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(NAFit(10));
        make.height.width.mas_equalTo(NAFit(23));
        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).offset(-NAFit(10));
    }];
    
    [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.icon.mas_right).offset(NAFit(10));
        make.top.mas_equalTo(weakSelf.icon);
        make.width.mas_equalTo(NAFit(120));
        make.height.mas_lessThanOrEqualTo(weakSelf.icon.mas_height);
        make.centerY.mas_equalTo(weakSelf.icon.mas_centerY);
    }];
    
    [self.arrows mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.icon.mas_centerY);
        make.right.mas_equalTo(-NAFit(10));
    }];
    
    [self.decLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.arrows.mas_left);
        make.height.mas_equalTo(weakSelf.title.mas_height);
        make.centerY.mas_equalTo(weakSelf.icon.mas_centerY);
    }];
}

#pragma mark - property
-(UIImageView *)icon {
    if (_icon == nil) {
        _icon = [[UIImageView alloc]init];
        _icon.image = [UIImage imageNamed:@"icon_about"];
    }
    return _icon;
}

-(UILabel *)title {
    if (_title == nil) {
        _title = [UILabel new];
        _title.font = NAFontSize(16);
        _title.textColor = [UIColor blackColor];//kSetUpCololor(64,75,105,1);
        _title.text = @"当前版本号";
    }
    return _title;
}

-(UIImageView *)arrows {
    if (_arrows == nil) {
        _arrows = [UIImageView new];
        _arrows.image = [UIImage imageNamed:@"icon_arrow_gray"];
    }
    return _arrows;
}

-(UILabel *)decLabel {
    if (_decLabel == nil) {
        _decLabel = [UILabel new];
        _decLabel.textAlignment = NSTextAlignmentRight;
        _decLabel.font = [UIFont fontWithName:Font_Medium size:Kfont(16)];
        _decLabel.textColor = kSetUpCololor(195,195,195,1);
    }
    return _decLabel;
}

@end
