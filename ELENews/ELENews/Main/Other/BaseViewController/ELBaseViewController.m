//
//  ELBaseViewController.m
//  ELENews
//
//  Created by EL on 2017/12/5.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELBaseViewController.h"


@interface ELBaseViewController ()

@property (nonatomic, strong) NSString *baseTitle;

@end

@implementation ELBaseViewController{
    UILabel         *_titleLabel;
    UIImageView     *_iconImageView;
    NSString        *_iconImageUrl;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    ELBaseViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController)
    [[viewController
      rac_signalForSelector:@selector(viewDidLoad)]
     subscribeNext:^(id x) {
         @strongify(viewController)
         [viewController bindViewModel];
     }];
    
    return viewController;
}

- (instancetype)initWithViewModel:(ELBaseViewModel *)viewModel{
    if (self = [super init]) {
        _viewModel = viewModel;
    }
    return self;
}

#pragma mark – LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ELWhiteColor;


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
    
    UIView *bgView = [[UIView alloc] init];
    [_baseNavigationView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(_baseNavigationView).with.offset(0);
    }];
    
    _iconImageView = [[UIImageView alloc] init];
    _iconImageView.layer.cornerRadius = 9;
    _iconImageView.layer.masksToBounds = YES;
    [bgView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(18, 18));
        make.left.mas_equalTo(bgView).with.offset(0);
        make.top.mas_equalTo(bgView).with.offset(0);
        make.bottom.mas_equalTo(bgView).with.offset(0);
    }];
    
    _titleLabel = [ELViewFactory labelWithBackgroundColor:ELClearColor
                                                textColor:[UIColor hexChangeFloat:@"333333"]
                                            textAlignment:NSTextAlignmentCenter
                                            numberOfLines:1
                                                     text:self.baseTitle
                                                 fontSize:15];
    _titleLabel.shadowOffset = CGSizeMake(0, 1);
    [bgView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bgView).with.offset(0);
        make.left.mas_equalTo(_iconImageView.mas_right).with.offset(5);
        make.centerY.mas_equalTo(bgView).with.offset(0);
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)bindViewModel{
    _baseTitle = self.viewModel.title;
    _iconImageUrl = self.viewModel.iconImageUrl;
    
    [_iconImageView yy_setImageWithURL:[NSURL URLWithString:_iconImageUrl] placeholder:nil options:YYWebImageOptionSetImageWithFadeAnimation completion:nil];
    [_titleLabel setText:_baseTitle];
}

@end
