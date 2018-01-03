//
//  ELDisplayViewController.m
//  ELENews
//
//  Created by EL on 2017/12/6.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELDisplayViewController.h"
#import "ELTabbarViewModel.h"

@interface ELDisplayViewController ()

@end

@implementation ELDisplayViewController

#pragma mark – LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    if (_viewModel.iconImageName && ![_viewModel.iconImageName isEqualToString:@""]) {
        self.titleLabel.hidden = YES;
    }
}

#pragma mark - Intial Methods

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    ELDisplayViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController)
    [[viewController
      rac_signalForSelector:@selector(viewDidLoad)]
     subscribeNext:^(id x) {
         @strongify(viewController)
         [viewController bindViewModel];
     }];
    
    [[viewController rac_signalForSelector:@selector(viewWillAppear:)]
     subscribeNext:^(id x) {
         @strongify(viewController)
         [viewController.navigationController setNavigationBarHidden:YES animated:NO];
     }];
    
    return viewController;
}

- (instancetype)initWithViewModel:(ELTabbarViewModel *)viewModel{
    _viewModel = viewModel;
    
    self.baseTitle = _viewModel.title;
    self.tabBarItem.title = _viewModel.title;
    self.tabBarItem.image = [[UIImage imageNamed:_viewModel.tabbarDefaultImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.selectedImage = [[UIImage imageNamed:_viewModel.tabbarSelectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.tabBarItem setTitleTextAttributes:_viewModel.textAttrs forState:UIControlStateNormal];
    [self.tabBarItem setTitleTextAttributes:_viewModel.selectTextAttrs forState:UIControlStateSelected];
    
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark – Target Methods

#pragma mark - Private Methods

#pragma mark - Setter Getter Methods

- (void)bindViewModel{
    if (_viewModel.iconImageName && ![_viewModel.iconImageName isEqualToString:@""]) {
        CGSize size = self.viewModel.iconSize;
        if (!self.iconImageView) {
            self.iconImageView = [[UIImageView alloc] init];
            [self.baseNavigationView addSubview:self.iconImageView];
            [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(size);
                make.center.mas_equalTo(self.baseNavigationView).with.offset(0);
            }];
        } else {
            [self.iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(size);
            }];
        }
        self.iconImageView.image = [UIImage imageNamed:self.viewModel.iconImageName];
    }
}


@end

