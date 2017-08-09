//
//  CSScrollZoomViewCell.h
//  CSScrollZoomView
//
//  Created by Joslyn Wu on 2017/8/9.
//  Copyright © 2017年 joslyn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CSScrollZoomViewDataModel;
@class CSScrollZoomViewConfigInfo;

typedef NS_ENUM(NSInteger, CSScrollZoomViewType) {
    CSScrollZoomViewTypeNone,
    CSScrollZoomViewTypeImageOnly,
    CSScrollZoomViewTypeTitleOnly,
    CSScrollZoomViewTypeAll,
};

@interface CSScrollZoomViewCell : UICollectionViewCell

@property (nonatomic, strong) CSScrollZoomViewDataModel *model;
@property (nonatomic, strong) CSScrollZoomViewConfigInfo *configInfo;
@property (nonatomic, assign) CSScrollZoomViewType cellType;

@end


@interface CSScrollZoomViewDataModel : NSObject

@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *placeholderImageName;
@property (nonatomic, strong) NSString *title;

@end


@interface CSScrollZoomViewConfigInfo : NSObject

@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, assign) CGSize imgSize;
@property (nonatomic, assign) CGFloat distanceOfImgAndTitle;
@property (nonatomic, assign) UIOffset imgOffset;


@end
