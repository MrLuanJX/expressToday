//
//  LJX_HisCell.m
//  LJXNewsArrive
//
//  Created by a on 2019/4/28.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "LJX_HisCell.h"

@interface LJX_HisCell ()

@property (nonatomic , strong) UILabel * titleLabel;

@property (nonatomic , strong) UILabel * dateLabel;

@property (nonatomic , strong) UITextView * contentTV;

@property (nonatomic , strong) MASConstraint * contentHeight;

@end

@implementation LJX_HisCell

//创建cell
+(instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier{
    
    LJX_HisCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[LJX_HisCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];//kSetUpCololor(242, 242, 242, 1.0);
    }
    return cell;
}

- (void)setHisModel:(LJX_HisModel *)hisModel {
    _hisModel = hisModel;
    
    self.titleLabel.text = hisModel.title;
    
    self.dateLabel.text = [NSString stringWithFormat:@"%@年%@月%@日",hisModel.year,hisModel.month,hisModel.day];
    
    NSString * htmlString = hisModel.content;
    //html转化成字符串
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.contentTV.attributedText = attributedString;
    //自适应高度
    CGRect frame = self.contentTV.frame;
    
    CGFloat height = [self.contentTV.text boundingRectWithSize:CGSizeMake(200 - self.contentTV.textContainer.lineFragmentPadding * 2, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.contentTV.font} context:nil].size.height;//宽度减去左右两边的padding
    
//    CGSize size = [self.contentTV.text sizeWithFont:self.contentTV.font
//                                        constrainedToSize:CGSizeMake(280, 1000)
//                                            lineBreakMode:NSLineBreakByTruncatingTail];
//    frame.size.height = size.height > 1 ? size.height + 20 : 64;
    
    frame.size.height = height;

    self.contentTV.frame = frame;
    self.contentTV.height = self.contentTV.contentSize.height;
    
    NSLog(@"height = %lf",self.contentTV.height);
    
    self.contentHeight.mas_greaterThanOrEqualTo(self.contentTV.height);
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
//    [UIView setBorderWithView:self.contentTV top:NO left:NO bottom:YES right:NO borderColor:[UIColor lightGrayColor] borderWidth:1.0];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        [self configUI];
        
        [self createConstrainte];
    }
    return self;
}

- (void) configUI {
    
    [self.contentView addSubview: self.titleLabel];
    [self.contentView addSubview: self.dateLabel];
    [self.contentView addSubview: self.contentTV];
}

- (void) createConstrainte {
    __weak typeof (self) weakSelf = self;

    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (NAFit(5));
        make.left.right.mas_equalTo (0);
        make.bottom.mas_equalTo (-NAFit(5));
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo (NAFit(10));
        make.right.mas_equalTo (-NAFit(10));
        make.height.mas_equalTo (NAFit(30));
    }];
    
    [self.dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.titleLabel.mas_bottom).offset (NAFit(10));
        make.left.right.height.mas_equalTo (weakSelf.titleLabel);
    }];
    
    [self.contentTV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.dateLabel.mas_bottom).offset (NAFit(10));
        make.left.right.mas_equalTo(weakSelf.titleLabel);
        weakSelf.contentHeight = make.height.mas_greaterThanOrEqualTo(NAFit(185));
        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).offset (-NAFit(10));
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    return _titleLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [UILabel new];
        _dateLabel.font = [UIFont boldSystemFontOfSize:15];
        _dateLabel.textColor = [UIColor blackColor];
    }
    return _dateLabel;
}

- (UITextView *)contentTV {
    if (!_contentTV) {
        _contentTV = [UITextView new];
        _contentTV.textContainerInset = UIEdgeInsetsZero;
    }
    return _contentTV;
}

@end
