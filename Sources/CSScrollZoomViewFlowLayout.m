//
//  CSScrollZoomViewFlowLayout.m
//  03-zoomPhoto
//
//  Created by Joslyn Wu on 2017/8/8.
//  Copyright © 2017年 Joslyn. All rights reserved.
//

#import "CSScrollZoomViewFlowLayout.h"

@implementation CSScrollZoomViewFlowLayout

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    CGFloat center_x = self.collectionView.bounds.size.width * 0.5 + self.collectionView.contentOffset.x;
    NSArray *attributesArr = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *nmArr = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *att in attributesArr) {
        UICollectionViewLayoutAttributes *currentAtt = att;
        CGFloat distance = ABS(currentAtt.center.x - center_x) / (self.collectionView.bounds.size.width * 0.5);
        CGFloat scale = 1 + (1 - distance) * self.zoomScale;
        currentAtt.transform = CGAffineTransformMakeScale(scale, scale);
        [nmArr addObject:currentAtt];
    }
    
    return nmArr.copy;
}

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    CGFloat currentCenter_x = proposedContentOffset.x + self.collectionView.bounds.size.width * 0.5;
    CGRect currentRect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray *array = [self layoutAttributesForElementsInRect:currentRect];
    CGFloat min_distance = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *att in array) {
        CGFloat margin = att.center.x - currentCenter_x;
        if (ABS(margin) < ABS(min_distance)) {
            min_distance = margin;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + min_distance, 0);
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    
    return YES;
}

@end
