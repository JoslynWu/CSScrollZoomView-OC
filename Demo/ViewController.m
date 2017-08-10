//
//  ViewController.m
//  CSScrollZoomView
//
//  Created by Joslyn Wu on 2017/8/8.
//  Copyright © 2017年 joslyn. All rights reserved.
//

#import "ViewController.h"
#import "CSScrollZoomView.h"
#import <CSToast_OC/CSToast.h>
#define kScreeSize ([UIScreen mainScreen].bounds.size)
static const CGFloat showViewY = 200;
static const CGFloat showViewH = 190;
@interface ViewController ()

@property (nonatomic, strong) CSScrollZoomView *scrollZoomView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self scrollZoomViewLikeThis];
}

////////////////////////<- show time ->////////////////////////

- (void)scrollZoomViewLikeThis {
    CSScrollZoomView *scrollZoomView = [[CSScrollZoomView alloc] init];
    self.scrollZoomView = scrollZoomView;
    [self.view addSubview:scrollZoomView];
    scrollZoomView.backgroundColor = [UIColor brownColor];
    scrollZoomView.imageNames = @[@"000", @"001"];
    scrollZoomView.titles = @[@"第0张", @"第1张"];
    scrollZoomView.frame = CGRectMake(0, showViewY, kScreeSize.width, showViewH);
    scrollZoomView.itemSize = CGSizeMake(100, 100);
    scrollZoomView.imgSize = CGSizeMake(60, 60);
    scrollZoomView.distanceOfImgAndTitle = 5;
    scrollZoomView.imgOffset = UIOffsetMake(20, 10);
    scrollZoomView.placeholderImageName = @"cs_placeholder";
    scrollZoomView.titleLabelBGColor = [UIColor lightGrayColor];
    
    scrollZoomView.itemDidClick = ^(NSUInteger index) {
        CSToast.text([NSString stringWithFormat:@"index=%zd", index]).top(120).show();
    };
}

////////////////////////<- show time ->////////////////////////








- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self.view];
    if (point.y < showViewY) {
        self.scrollZoomView.imageNames = @[@"000", @"001"];
        self.scrollZoomView.titles = @[@"第0张", @"第1张"];
    } else if (point.y > showViewY + showViewH) {
        NSString *img_url_00 = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502355918347&di=6a4c3b036d950c8dd2722ed98017f0ad&imgtype=0&src=http%3A%2F%2Fimg1.cache.netease.com%2Fcatchpic%2F1%2F1C%2F1CADD403DF59B9486EBC1314D7868D4D.jpg";
        NSString *img_url_01 = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502282250839&di=f1a001e75891357c1d1a6f18ea956ab9&imgtype=0&src=http%3A%2F%2Fwww.cnhuadong.net%2Fuploadfiles%2Fimages%2F2017-8-9%2F2017080911492219007.jpg";
        NSString *img_url_02 = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502355755610&di=5926d96d0f78c551dec87d8b69c69cad&imgtype=0&src=http%3A%2F%2Ftv.81.cn%2Fjbmdm%2Fattachement%2Fjpg%2Fsite294%2F20150409%2F1803732bcf091690afed02.jpg";
        self.scrollZoomView.imageNames = @[img_url_00, img_url_01, img_url_02];
        self.scrollZoomView.titles = nil;
    }
    
    [self.scrollZoomView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
