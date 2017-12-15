//
//  ELCommunityViewController.m
//  ELENews
//
//  Created by EL on 2017/12/14.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELCommunityViewController.h"
#import "ELCommunityRecommendViewController.h"
#import "ELCommunityLastNewsViewController.h"
#import "ELCommunityFindViewController.h"

@interface ELCommunityViewController ()

@end

@implementation ELCommunityViewController

#pragma mark – LifeCycle
- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.baseTitle = @"社区";
    
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight, CGFloat *titleWidth) {
        *norColor = [UIColor hexChangeFloat:@"9A9A9A"];
        *selColor = [UIColor hexChangeFloat:@"FF3D3D"];
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
    
    [self setUpAllViewController];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [super viewWillAppear:animated];
}

#pragma mark - Intial Methods

#pragma mark – Target Methods

#pragma mark - Private Methods
// 添加所有子控制器
- (void)setUpAllViewController{
    ELCommunityFeedBaseViewController *recommendVc= [[ELCommunityFeedBaseViewController alloc] initWithVcType:ELCommunityFeedBaseViewControllerTypeRecommend];
    recommendVc.title = @"推荐";
    [self addChildViewController:recommendVc];
    
    ELCommunityFeedBaseViewController *lastNewsVc= [[ELCommunityFeedBaseViewController alloc] initWithVcType:ELCommunityFeedBaseViewControllerTypeLastNews];
    lastNewsVc.title = @"最新";
    [self addChildViewController:lastNewsVc];
    
    ELCommunityFindViewController *findVc= [[ELCommunityFindViewController alloc] init];
    findVc.title = @"发现";
    [self addChildViewController:findVc];
}

#pragma mark - Setter Getter Methods

#pragma mark - External Delegate



@end

