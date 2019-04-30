//
//  LJX_XZCell.m
//  LJXNewsArrive
//
//  Created by a on 2019/4/26.
//  Copyright © 2019 栾金鑫. All rights reserved.
//

#import "LJX_XZCell.h"
#import "HYHCircleView.h"

@interface LJX_XZCollectionCell ()

@property (nonatomic , strong) HYHCircleView * circleView;

@property (nonatomic , strong) NSMutableArray * xzDataArray;

@property (nonatomic , copy) NSString * circleProgress;

@property (nonatomic , strong) NSIndexPath * index;

@property (nonatomic , copy) NSString * title;

@end

@implementation LJX_XZCollectionCell

- (void)setTitle:(NSString *)title {
    _title = title;
    
    [self.circleView setProgressTitle:title Font:NAFontBoldSize(15) Color:NAUIColorWithRGB(0x8B0000, 1.0)];
}

- (void)setCircleProgress:(NSString *)circleProgress {
    _circleProgress = circleProgress;
    
    [self.circleView setProgress:[circleProgress floatValue]/100];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
     
        self.backgroundColor = [UIColor whiteColor];//kSetUpCololor(242, 242, 242, 1.0);
        
        [self configUI];
        
        [UIView LJX_AddShadowToView:self SetShadowPathWith:[UIColor blackColor] shadowOpacity:0.2 shadowRadius:2 shadowSide:LJXShadowPathAllSide shadowPathWidth:5];
        
        // 进度条宽度
        [self.circleView setProgressLineWidth:17 NormalLineWidth:10];
        // 进度条渐变色
        [self.circleView setGradientColorArray:[NSArray arrayWithObjects:(id)NAUIColorWithRGB(0x8DEEEE, 1.0).CGColor,(id)NAUIColorWithRGB(0x5CACEE, 1.0).CGColor,(id)NAUIColorWithRGB(0x4682B4, 1.0).CGColor,nil]];
    }
    return self;
}

- (void) configUI {
    __weak typeof (self) weakSelf = self;

    [self addSubview:self.circleView];
    
    [self.circleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo (weakSelf.mas_centerX);
        make.centerY.mas_equalTo (weakSelf.mas_centerY);
        make.width.height.mas_equalTo (217);
    }];
}

- (HYHCircleView *)circleView {
    if (!_circleView) {
        _circleView = [HYHCircleView new];
        _circleView.backgroundColor = [UIColor whiteColor];
    }
    return _circleView;
}

@end

@interface LJX_XZCell () <UICollectionViewDelegate , UICollectionViewDataSource>

@property (nonatomic , strong) UICollectionView * collectionView;

@end

@implementation LJX_XZCell

// 创建cell
+ (instancetype)dequeueReusableCellWithTableView:(UITableView*)tableView Identifier:(NSString*)identifier{
        
    LJX_XZCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[LJX_XZCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];//kSetUpCololor(242, 242, 242, 1.0);
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self configUI];
        
        [self createConstrainte];
    }
    return self;
}

- (void) configUI {

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 行间距
    layout.minimumLineSpacing = NAFit(40);
    layout.minimumInteritemSpacing = NAFit(30);
    //设置每个item的大小
    layout.itemSize = CGSizeMake((NAScreenW - NAFit(20))/1.5, NAFit(240));
    layout.sectionInset = UIEdgeInsetsMake(NAFit(10), NAFit(20), NAFit(10), NAFit(20)); //设置距离上 左 下 右
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:[LJX_XZCollectionCell class] forCellWithReuseIdentifier:@"xzCollectCell"];
    collectionView.backgroundColor = NAUIColorWithRGB(0xffffff, 1.0);
    self.collectionView = collectionView;
    [self.contentView addSubview:collectionView];
}

- (void) createConstrainte {
    __weak typeof (self) weakSelf = self;
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (NAFit(5));
        make.left.right.mas_equalTo (0);
        make.bottom.mas_equalTo (-NAFit(5));
    }];
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (weakSelf.contentView.mas_top).mas_offset (NAFit(10));
        make.left.right.mas_equalTo(weakSelf.contentView);
        make.height.mas_equalTo(NAFit(260));
        make.bottom.mas_equalTo(weakSelf.contentView.mas_bottom).offset (-NAFit(10));
    }];

    [self.collectionView reloadData];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LJX_XZCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"xzCollectCell" forIndexPath:indexPath];
    
    if (self.xzArray.count > 0) {
        cell.circleProgress = self.xzArray[indexPath.row];
        cell.title = self.xzDataArray[indexPath.row];
    }
    
    return cell;
}

/* 点击item */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (void)setXzModel:(LJX_XZModel *)xzModel {
    _xzModel = xzModel;
    
    self.xzArray = [NSMutableArray array];
    
    NSMutableArray * array = [NSMutableArray arrayWithObjects:xzModel.all,xzModel.health,xzModel.love,xzModel.money,xzModel.work, nil];
    
    [self.xzArray addObjectsFromArray:array];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.collectionView reloadData];
        
    });
}

- (NSMutableArray *)xzDataArray {
    if (!_xzDataArray) {
        _xzDataArray = [NSMutableArray arrayWithObjects:@"综合指数",@"健康指数",@"爱情指数",@"工作指数",@"财运指数", nil];
    }
    return _xzDataArray;
}

@end
