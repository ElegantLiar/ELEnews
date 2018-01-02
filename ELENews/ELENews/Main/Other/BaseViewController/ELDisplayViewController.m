//
//  ELDisplayViewController.m
//  ELENews
//
//  Created by EL on 2017/12/6.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELDisplayViewController.h"

@interface ELDisplayViewController ()

@end

@implementation ELDisplayViewController{
    UILabel                 *_titleLabel;
    UIImageView             *_iconImageView;
    ELTabbarViewModel       *_viewModel;
}

#pragma mark – LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark - Intial Methods

- (instancetype)initWithViewModel:(ELTabbarViewModel *)viewModel{
    if (self = [super init]) {
        _viewModel = viewModel;
        
        self.baseTitle = _viewModel.title;
        self.tabBarItem.title = _viewModel.title;
        self.tabBarItem.image = [[UIImage imageNamed:_viewModel.tabbarDefaultImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.selectedImage = [[UIImage imageNamed:_viewModel.tabbarSelectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];        
        [self.tabBarItem setTitleTextAttributes:_viewModel.textAttrs forState:UIControlStateNormal];
        [self.tabBarItem setTitleTextAttributes:_viewModel.selectTextAttrs forState:UIControlStateSelected];
    }
    return self;
}
#pragma mark – Target Methods

#pragma mark - Private Methods

#pragma mark - Setter Getter Methods

- (void)bindViewModel{
    
}

@end

