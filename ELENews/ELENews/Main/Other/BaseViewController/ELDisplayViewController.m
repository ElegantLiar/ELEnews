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
    UILabel         *_titleLabel;
    UIImageView     *_iconImageView;
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
    _titleLabel.hidden = YES;
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        [_baseNavigationView addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(size);
            make.center.mas_equalTo(_baseNavigationView).with.offset(0);
        }];
    } else {
        [_iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(size);
        }];
    }
    _iconImageView.image = [UIImage imageNamed:imageName];
}
#pragma mark - Setter Getter Methods

#pragma mark - External Delegate


@end

