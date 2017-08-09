//
//  CSScrollZoomViewCell.h
//  CSScrollZoomView
//
//  Created by Joslyn Wu on 2017/8/9.
//  Copyright © 2017年 joslyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSScrollZoomViewCell : UICollectionViewCell

@property (nonatomic, strong) NSString *imageName;

@property (nonatomic, strong) NSString *placeholderImageName;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleColor;

@end
