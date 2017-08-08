//
//  CSScrollZoomView.m
//  03-zoomPhoto
//
//  Created by Joslyn Wu on 2017/8/8.
//  Copyright © 2017年 Joslyn. All rights reserved.
//

#import "CSScrollZoomView.h"
#import "CSScrollZoomViewFlowLayout.h"

static const NSUInteger repeatCount = 500;
static const NSUInteger retention_group = 50;
static NSString * const CSScrollZoomViewReuseId = @"CSScrollZoomViewReuseId";

@interface CSScrollZoomView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) CSScrollZoomViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *mainView;
@property (nonatomic, assign) CGFloat lastContenOffsetX;

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
    self.zoomScale = 0.6;
}

- (void)setupUI {
    CSScrollZoomViewFlowLayout *flowLayout = [[CSScrollZoomViewFlowLayout alloc] init];
    self.flowLayout = flowLayout;
    flowLayout.minimumInteritemSpacing = 0.0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.mainView = collectionView;
    [self addSubview:collectionView];
    collectionView.backgroundColor = [UIColor brownColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.showsHorizontalScrollIndicator = YES;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CSScrollZoomViewReuseId];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self adjustItemSize];
    self.mainView.frame = self.bounds;
    self.flowLayout.zoomScale = self.zoomScale;
    self.flowLayout.itemSize = self.itemSize;
    self.flowLayout.minimumLineSpacing = self.distanceOfItem;
    
    NSUInteger defaultIdex = (repeatCount % 2 == 0 ? repeatCount * 0.5 : (repeatCount - 1) * 0.5) * self.imageNames.count;
    [self adjustPostionWithIndex:defaultIdex];
}

- (void)adjustPostionWithIndex:(NSInteger)idx {
    CGFloat item_w = self.itemSize.width;
    CGFloat total_x = idx * (item_w + self.distanceOfItem);
    CGFloat adjust_x = CGRectGetMidX(self.mainView.frame) - item_w * 0.5;
    CGPoint contentOffset = CGPointMake(total_x - adjust_x, 0);
    self.mainView.contentOffset = contentOffset;
}

- (void)adjustItemSize {
    if (self.itemSize.height * (1 + self.zoomScale) > self.bounds.size.height) {
        self.itemSize = CGSizeMake(self.itemSize.width, self.bounds.size.height / (1 + self.zoomScale));
    }
}



#pragma mark  -  UICollectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageNames.count * repeatCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSScrollZoomViewReuseId forIndexPath:indexPath];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.itemSize.width, self.itemSize.height)];
    [cell.contentView addSubview:imgView];
    imgView.image = [UIImage imageNamed:[self.imageNames objectAtIndex:indexPath.item % self.imageNames.count]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"---->%zd", indexPath.item % self.imageNames.count);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.lastContenOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger itemCount = self.imageNames.count;
    NSUInteger retentionCount = itemCount * retention_group;
    CGFloat item_w = self.itemSize.width;
    NSUInteger index = (NSUInteger)((self.lastContenOffsetX + self.mainView.bounds.size.width * 0.5 - item_w * 0.5) / (item_w + self.distanceOfItem));
    if (index < retentionCount || (repeatCount * itemCount - index) < retentionCount) {
        NSUInteger defaultIdex = (repeatCount % 2 == 0 ? repeatCount * 0.5 : (repeatCount - 1) * 0.5) * itemCount;
        [self adjustPostionWithIndex:defaultIdex + (index % itemCount)];
    }
}


@end
