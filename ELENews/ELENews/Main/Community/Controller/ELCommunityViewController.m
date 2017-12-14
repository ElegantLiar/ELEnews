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
    NSArray *classNames = @[
                           @"ELCommunityRecommendViewController",
                           @"ELCommunityLastNewsViewController",
                           @"ELCommunityFindViewController"
                           ];
    NSArray *titles = @[
                        @"推荐",
                        @"最新",
                        @"发现"
                        ];
    for (NSInteger i = 0; i < classNames.count; i++) {
        ELDisplayViewController *vc = [[NSClassFromString([classNames safeObjectAtIndex:i]) alloc] init];
        vc.title = [titles safeObjectAtIndex:i];
        [self addChildViewController:vc];
    }
}

#pragma mark - Setter Getter Methods

#pragma mark - External Delegate



@end

