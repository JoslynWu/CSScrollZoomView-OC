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

@property (nonatomic, assign) CGFloat zoomScale;

@property (nonatomic, assign) CGSize itemSize;

@property (nonatomic, assign) CGFloat distanceOfItem;

@end
