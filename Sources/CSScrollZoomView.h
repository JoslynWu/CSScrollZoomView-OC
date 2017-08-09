//
//  CSScrollZoomView.h
//  03-zoomPhoto
//
//  Created by Joslyn Wu on 2017/8/8.
//  Copyright © 2017年 Joslyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSScrollZoomView : UIView

@property (nonatomic, copy) void(^itemDidClick)(NSUInteger index);

@property (nonatomic, strong) NSArray<NSString *> *imageNames;

@property (nonatomic, strong) NSArray<NSString *> *titles;

/** 放大比例，默认0.6 */
@property (nonatomic, assign) CGFloat enlargeScale;

@property (nonatomic, assign) CGSize itemSize;

@property (nonatomic, assign) CGFloat distanceOfItem;

/** 只有图片时，imgSize = itemSize。 */
@property (nonatomic, assign) CGSize imgSize;
@property (nonatomic, assign) UIOffset imgOffset;

/** 不只有图片时有效，默认为0.0。 */
@property (nonatomic, assign) CGFloat distanceOfImgAndTitle;


/** 自由滚动速率的快慢，默认YES */
@property (nonatomic, assign) BOOL isScrollFast;

@property (nonatomic, strong) NSString *placeholderImageName;

@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, assign) NSTextAlignment textAlignment;

@end
