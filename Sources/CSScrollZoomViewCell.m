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
    
    self.imgView.frame = self.contentView.bounds;
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    if ([imageName hasPrefix:@"http"]) {
        self.imgView.contentMode = UIViewContentModeCenter;
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:self.placeholderImageName] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if(!error){ self.imgView.contentMode = UIViewContentModeScaleToFill; }
        }];
        return;
    }
    self.imgView.image = [UIImage imageNamed:imageName];
}

@end
