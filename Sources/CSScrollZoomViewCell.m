//
//  CSScrollZoomViewCell.m
//  CSScrollZoomView
//
//  Created by Joslyn Wu on 2017/8/9.
//  Copyright © 2017年 joslyn. All rights reserved.
//

#import "CSScrollZoomViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CSScrollZoomViewCell ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CSScrollZoomViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIImageView *imgView = [[UIImageView alloc] init];
    self.imgView = imgView;
    [self.contentView addSubview:imgView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    self.titleLabel = titleLabel;
    [self.contentView addSubview:titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self refreshFrame];
}

#pragma mark  -  action
- (void)refreshFrame {
    self.contentView.backgroundColor = self.configInfo.itemBackgroundColor;
    if (self.cellType == CSScrollZoomViewTypeNone) { return; }
    
    self.titleLabel.hidden = (self.cellType == CSScrollZoomViewTypeImageOnly);
    if (self.cellType == CSScrollZoomViewTypeImageOnly) {
        self.imgView.frame = self.contentView.bounds;
        return;
    }
    
    self.titleLabel.backgroundColor = self.configInfo.titleLabelBGColor;
    self.titleLabel.textAlignment = self.configInfo.textAlignment;
    self.titleLabel.textColor = self.configInfo.titleColor;
    self.titleLabel.font = self.configInfo.titleFont;
    if (self.cellType == CSScrollZoomViewTypeTitleOnly) {
        self.titleLabel.frame = self.contentView.bounds;
        return;
    }
    
    self.imgView.frame = CGRectMake(self.configInfo.imgOffset.horizontal, self.configInfo.imgOffset.vertical, self.configInfo.imgSize.width, self.configInfo.imgSize.height);
    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imgView.frame) + self.configInfo.distanceOfImgAndTitle, CGRectGetWidth(self.contentView.frame), [self calculateTitleMinHeight]);
}

- (CGFloat)calculateTitleMinHeight {
    CGSize size = [@"" boundingRectWithSize:CGSizeMake(MAXFLOAT, self.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.configInfo.titleFont} context:nil].size;
    return ceil(size.height);
}

#pragma mark  -  setter / getter
- (void)setModel:(CSScrollZoomViewDataModel *)model {
    _model = model;
    [self refreshFrame];
    
    if (self.cellType == CSScrollZoomViewTypeNone) { return; }
    
    self.titleLabel.text = model.title;
    if ([model.imageName hasPrefix:@"http"]) {
        self.imgView.contentMode = UIViewContentModeCenter;
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.imageName] placeholderImage:[UIImage imageNamed:model.placeholderImageName] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if(!error){ self.imgView.contentMode = UIViewContentModeScaleToFill; }
        }];
    } else {
        self.imgView.image = [UIImage imageNamed:model.imageName];
    }
}

@end


@implementation CSScrollZoomViewDataModel

@end


@implementation CSScrollZoomViewConfigInfo

@end
