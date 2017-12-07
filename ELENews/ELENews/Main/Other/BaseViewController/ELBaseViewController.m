//
//  ELBaseViewController.m
//  ELENews
//
//  Created by EL on 2017/12/5.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELBaseViewController.h"


@interface ELBaseViewController ()

@end

@implementation ELBaseViewController{
    UILabel         *_titleLabel;
    
}

#pragma mark – LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];

    _baseNavigationView = [[UIView alloc] init];
    [self.view addSubview:_baseNavigationView];
    [_baseNavigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view).with.offset(0);
        make.top.mas_equalTo(self.view).with.offset(kAppStatusBarHeight);
        make.height.mas_equalTo(@(kAppNavigationBarHeight));
    }];
    
    _baseContentView = [[UIView alloc] init];
    [self.view addSubview:_baseContentView];
    [_baseContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_baseNavigationView.mas_bottom).with.offset(0);
        make.left.right.mas_equalTo(self.view).with.offset(0);
        make.bottom.mas_equalTo(self.view).with.offset(0);
    }];
    
    _titleLabel = [ELViewFactory labelWithBackgroundColor:ELClearColor
                                                textColor:[UIColor hexChangeFloat:@"333333"]
                                            textAlignment:NSTextAlignmentCenter
                                            numberOfLines:1
                                                     text:self.baseTitle
                                                 fontSize:20];
    _titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    _titleLabel.shadowOffset = CGSizeMake(0, 1);
    [_baseNavigationView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(_baseNavigationView).with.offset(0);
    }];
    
}

#pragma mark - Intial Methods

#pragma mark – Target Methods

#pragma mark - Private Methods
- (void)showNavImageWithImageName:(NSString *)imageName
                             size:(CGSize)size{
    
}
#pragma mark - Setter Getter Methods

#pragma mark - External Delegate


@end
