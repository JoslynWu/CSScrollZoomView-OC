//
//  ViewController.m
//  CSScrollZoomView
//
//  Created by Joslyn Wu on 2017/8/8.
//  Copyright © 2017年 joslyn. All rights reserved.
//

#import "ViewController.h"
#import "CSScrollZoomView.h"
#define kScreeSize ([UIScreen mainScreen].bounds.size)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CSScrollZoomView *scrollZoomView = [[CSScrollZoomView alloc] init];
    [self.view addSubview:scrollZoomView];
    scrollZoomView.imageNames = @[@"000", @"001"];
    scrollZoomView.frame = CGRectMake(0, 200, kScreeSize.width, 190);
    scrollZoomView.itemSize = CGSizeMake(100, 100);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
