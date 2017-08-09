//
//  CSScrollZoomView.m
//  03-zoomPhoto
//
//  Created by Joslyn Wu on 2017/8/8.
//  Copyright © 2017年 Joslyn. All rights reserved.
//

#import "CSScrollZoomView.h"
#import "CSScrollZoomViewFlowLayout.h"
#import "CSScrollZoomViewCell.h"

static const NSUInteger repeatCount = 500;
static const NSUInteger retention_group = 50;
static NSString * const CSScrollZoomViewReuseId = @"CSScrollZoomViewReuseId";

@interface CSScrollZoomView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) CSScrollZoomViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *mainView;
@property (nonatomic, assign) CGFloat lastContenOffsetX;
@property (nonatomic, strong) NSArray<CSScrollZoomViewDataModel *> *models;
@property (nonatomic, strong) CSScrollZoomViewConfigInfo *configInfo;
@property (nonatomic, assign) CSScrollZoomViewType dataType;

@end

@implementation CSScrollZoomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
        [self setupUI];
    }
    return self;
}

- (void)initialization {
    self.itemSize = CGSizeMake(100.0, 100.0);
    self.distanceOfItem = 50.0;
    self.enlargeScale = 0.6;
    self.isScrollFast = YES;
    self.imgSize = self.itemSize;
    self.distanceOfImgAndTitle = 0.0;
    self.imgOffset = UIOffsetZero;
    self.titleFont = [UIFont boldSystemFontOfSize:15];
    self.titleColor = [UIColor darkTextColor];
    self.textAlignment = NSTextAlignmentCenter;
}

- (void)setupUI {
    CSScrollZoomViewFlowLayout *flowLayout = [[CSScrollZoomViewFlowLayout alloc] init];
    self.flowLayout = flowLayout;
    flowLayout.minimumInteritemSpacing = 0.0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.mainView = mainView;
    [self addSubview:mainView];
    mainView.backgroundColor = [UIColor brownColor];
    mainView.dataSource = self;
    mainView.delegate = self;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.showsVerticalScrollIndicator = NO;
    [mainView registerClass:[CSScrollZoomViewCell class] forCellWithReuseIdentifier:CSScrollZoomViewReuseId];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.dataType = [self dataTypeWithImageNames:self.imageNames titles:self.titles];
    
    [self adjustItemSize];
    [self collatingConfigInfo];
    [self collatingDataModel];
    
    self.flowLayout.zoomScale = self.enlargeScale;
    self.flowLayout.itemSize = self.itemSize;
    self.flowLayout.minimumLineSpacing = self.distanceOfItem;
    self.mainView.frame = self.bounds;
    self.mainView.decelerationRate = (self.isScrollFast ? UIScrollViewDecelerationRateNormal : UIScrollViewDecelerationRateFast);
    
    NSUInteger defaultIdex = (repeatCount % 2 == 0 ? repeatCount * 0.5 : (repeatCount - 1) * 0.5) * self.models.count;
    [self adjustPostionWithIndex:defaultIdex];
}

#pragma mark  -  action
- (void)collatingDataModel {
    if (self.dataType == CSScrollZoomViewTypeNone) {
        return;
    }
    
    NSUInteger count = MAX(self.imageNames.count, self.titles.count);
    NSMutableArray<CSScrollZoomViewDataModel *> *mArr = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger i = 0; i < count; i++) {
        CSScrollZoomViewDataModel *model = [CSScrollZoomViewDataModel new];
        model.placeholderImageName = self.placeholderImageName;
        [mArr addObject:model];
    }
    
    [mArr enumerateObjectsUsingBlock:^(CSScrollZoomViewDataModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.dataType == CSScrollZoomViewTypeImageOnly) {
            model.imageName = (idx < self.imageNames.count ? [self.imageNames objectAtIndex:idx] : @"");
        } else if (self.dataType == CSScrollZoomViewTypeTitleOnly) {
            model.title = (idx < self.titles.count ? [self.titles objectAtIndex:idx] : @"");
        } else {
            model.imageName = (idx < self.imageNames.count ? [self.imageNames objectAtIndex:idx] : @"");
            model.title = (idx < self.titles.count ? [self.titles objectAtIndex:idx] : @"");
        }
    }];
    
    self.models = mArr.copy;
}

- (CSScrollZoomViewType)dataTypeWithImageNames:(NSArray<NSString *> *)names titles:(NSArray<NSString *> *)titles {
    if (names.count > 0) {
        if (titles.count > 0) {
            return CSScrollZoomViewTypeAll;
        } else {
            return CSScrollZoomViewTypeImageOnly;
        }
    } else {
        if (titles.count > 0) {
            return CSScrollZoomViewTypeTitleOnly;
        } else {
            return CSScrollZoomViewTypeNone;
        }
    }
}

- (void)collatingConfigInfo {
    self.configInfo.titleFont = self.titleFont;
    self.configInfo.titleColor = self.titleColor;
    self.configInfo.imgSize = self.imgSize;
    self.configInfo.distanceOfImgAndTitle = self.distanceOfImgAndTitle;
    self.configInfo.imgOffset = self.imgOffset;
    self.configInfo.textAlignment = self.textAlignment;
}

- (void)adjustPostionWithIndex:(NSInteger)idx {
    CGFloat item_w = self.itemSize.width;
    CGFloat total_x = idx * (item_w + self.distanceOfItem);
    CGFloat adjust_x = CGRectGetMidX(self.mainView.frame) - item_w * 0.5;
    CGPoint contentOffset = CGPointMake(total_x - adjust_x, 0);
    self.mainView.contentOffset = contentOffset;
}

- (void)adjustItemSize {
    if (self.itemSize.height * (1 + self.enlargeScale) > self.bounds.size.height) {
        self.itemSize = CGSizeMake(self.itemSize.width, self.bounds.size.height / (1 + self.enlargeScale));
    }
}

#pragma mark  -  UICollectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.models.count * repeatCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CSScrollZoomViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSScrollZoomViewReuseId forIndexPath:indexPath];
    cell.cellType = self.dataType;
    cell.configInfo = self.configInfo;
    cell.model = [self.models objectAtIndex:indexPath.item % self.models.count];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.itemDidClick) {
        self.itemDidClick(indexPath.item % self.models.count);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.lastContenOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger itemCount = self.models.count;
    NSUInteger retentionCount = itemCount * retention_group;
    CGFloat item_w = self.itemSize.width;
    NSUInteger index = (NSUInteger)((self.lastContenOffsetX + self.mainView.bounds.size.width * 0.5 - item_w * 0.5) / (item_w + self.distanceOfItem));
    if (index < retentionCount || (repeatCount * itemCount - index) < retentionCount) {
        NSUInteger defaultIdex = (repeatCount % 2 == 0 ? repeatCount * 0.5 : (repeatCount - 1) * 0.5) * itemCount;
        [self adjustPostionWithIndex:defaultIdex + (index % itemCount)];
    }
}

#pragma mark  -  setter / getter
- (CSScrollZoomViewConfigInfo *)configInfo {
    if (!_configInfo) {
        _configInfo = [[CSScrollZoomViewConfigInfo alloc] init];
    }
    return _configInfo;
}


@end
