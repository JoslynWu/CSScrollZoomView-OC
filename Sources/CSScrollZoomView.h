//
//  CSScrollZoomView.h
//  03-zoomPhoto
//
//  Created by Joslyn Wu on 2017/8/8.
//  Copyright © 2017年 Joslyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSScrollZoomView : UIView

@property (nonatomic, strong) NSArray<NSString *> *imageNames;

/** 放大比例，默认0.6 */
@property (nonatomic, assign) CGFloat enlargeScale;

@property (nonatomic, assign) CGSize itemSize;

@property (nonatomic, assign) CGFloat distanceOfItem;

/** 自由滚动速率的快慢，默认YES */
@property (nonatomic, assign) BOOL isScrollFast;

@property (nonatomic, strong) NSString *placeholderImageName;

@end
