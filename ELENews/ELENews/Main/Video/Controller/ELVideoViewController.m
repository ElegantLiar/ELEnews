//
//  ELVideoViewController.m
//  ELENews
//
//  Created by EL on 2017/12/14.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELVideoViewController.h"
#import "ELHomeChannelViewModel.h"
#import "ELNewsPageViewController.h"

#import "ELVideoNode.h"
@interface ELVideoViewController ()

@end

@implementation ELVideoViewController{
    ELHomeChannelViewModel     *_channelViewModel;
}

#pragma mark – LifeCycle
- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.baseTitle = @"视频";
    
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight, CGFloat *titleWidth) {
        *norColor = [UIColor hexChangeFloat:@"9A9A9A"];
        *selColor = [UIColor hexChangeFloat:@"FF3D3D"];
        //        *titleWidth = [UIScreen mainScreen].bounds.size.width / 6;
        *titleHeight = 32;
        *titleFont = [UIFont systemFontOfSize:15];
    }];
    
    // 标题渐变
    // *推荐方式(设置标题渐变)
    [self setUpTitleGradient:^(YZTitleColorGradientStyle *titleColorGradientStyle, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor) {
        
    }];
    
    [self setUpUnderLineEffect:^(BOOL *isUnderLineDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor,BOOL *isUnderLineEqualTitleWidth) {
        *isUnderLineEqualTitleWidth = YES;
        *underLineColor = [UIColor hexChangeFloat:@"FF3D3D"];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [super viewWillAppear:animated];
    
    [self initData];
}

#pragma mark - Intial Methods
- (void)initData{
    _channelViewModel = [ELHomeChannelViewModel shareInstance];
    
    if (_channelViewModel.channelBean.video.count == 0) {
        [_channelViewModel loadDataFromNetwork];

    } else {
        [self setUpAllViewController];
    }
    
    @weakify(self);
    [[_channelViewModel.requestCommand execute:nil] subscribeNext:^(id x) {
        @strongify(self);
        [self setUpAllViewController];
    } error:^(NSError *error) {
        
    }];
    
}

#pragma mark – Target Methods

#pragma mark - Private Methods
// 添加所有子控制器
- (void)setUpAllViewController{
    for (NSInteger i = 0; i < _channelViewModel.channelBean.video.count; i++) {
        ELSingleChannelBean *bean = [_channelViewModel.channelBean.video safeObjectAtIndex:i];
        ELNewsPageViewController *newsPageVc = [[ELNewsPageViewController alloc] init];
        newsPageVc.delegate = self;
        newsPageVc.title = bean.name;
        newsPageVc.singleChannelBean = bean;
        newsPageVc.tabType = ELTabTypeVideo;
        [self addChildViewController:newsPageVc];
    }
    
    [self refreshDisplay];
    
}

#pragma mark - Setter Getter Methods

#pragma mark - External Delegate



@end
