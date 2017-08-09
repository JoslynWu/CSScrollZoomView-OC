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
    scrollZoomView.imageNames = @[@"000", @"001"];
    scrollZoomView.titles = @[@"第0张", @"第1张"];
    scrollZoomView.frame = CGRectMake(0, showViewY, kScreeSize.width, showViewH);
    scrollZoomView.itemSize = CGSizeMake(100, 100);
    scrollZoomView.imgSize = CGSizeMake(60, 60);
    scrollZoomView.distanceOfImgAndTitle = 0;
    scrollZoomView.imgOffset = UIOffsetMake(20, 10);
    
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
        
        self.scrollZoomView.imageNames = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502282192939&di=a5f9b83c5f8d0ae65c9d7fcd7ae6df78&imgtype=0&src=http%3A%2F%2Fimg1.cache.netease.com%2Fcatchpic%2FB%2FB8%2FB8AB702E4924B63BC034FE008E7625F8.jpg",
                                           @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502282250839&di=f1a001e75891357c1d1a6f18ea956ab9&imgtype=0&src=http%3A%2F%2Fwww.cnhuadong.net%2Fuploadfiles%2Fimages%2F2017-8-9%2F2017080911492219007.jpg"];
        self.scrollZoomView.titles = nil;
    }
    
    [self.scrollZoomView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
