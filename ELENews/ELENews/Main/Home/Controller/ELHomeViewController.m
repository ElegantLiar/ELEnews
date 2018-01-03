//
//  ELHomeViewController.m
//  ELENews
//
//  Created by EL on 2017/12/6.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELHomeViewController.h"
#import "ELHomeChannelViewModel.h"
#import "ELNewsPageViewController.h"

@interface ELHomeViewController ()

@property (nonatomic, strong, readonly) ELTabbarViewModel *viewModel;

@end

@implementation ELHomeViewController{
    ELHomeChannelViewModel  *_channleViewModel;
    CGPoint                 _lastOffset;
}

@dynamic viewModel;

#pragma mark – LifeCycle
- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self initData];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [super viewWillAppear:animated];
}

#pragma mark - Intial Methods
- (void)initData{
    _channleViewModel = [ELHomeChannelViewModel shareInstance];
    @weakify(self);
//    [_channleViewModel loadChannelDataFromCache];
//    [[_channleViewModel.cacheCommand execute:nil] subscribeNext:^(id x) {
//        @strongify(self);
//    } error:^(NSError *error) {
//
//    }];
    
    
    [_channleViewModel loadDataFromNetwork];
    [[_channleViewModel.requestCommand execute:nil] subscribeNext:^(id x) {
        @strongify(self);
        [self setUpAllViewController];
    } error:^(NSError *error) {
        
    }];
}
#pragma mark – Target Methods

#pragma mark - Private Methods
// 添加所有子控制器
- (void)setUpAllViewController{
    [[_channleViewModel.channelBean.home.rac_sequence.signal deliverOnMainThread] subscribeNext:^(ELSingleChannelBean *bean) {
        ELFeedViewModel *viewModel = [[ELFeedViewModel alloc] initWithELSingleChannelBean:bean];
        viewModel.tabType = ELTabTypeHome;
        ELNewsPageViewController *newsPageVc = [[ELNewsPageViewController alloc] initWithViewModel:viewModel];
        newsPageVc.delegate = self;
        [self addChildViewController:newsPageVc];
    }  completed:^{
        [self refreshDisplay];
    }];
}

//- (void)refreshAllViewControllers{
//    NSInteger cacheChannelNumber = self.childViewControllers.count;
//    NSInteger lastChannelNumber = _channleViewModel.channelBean.home.count;
//    
//    if (lastChannelNumber >= cacheChannelNumber) {
//        for (NSInteger i = 0; i < lastChannelNumber - cacheChannelNumber; i++) {
//            ELNewsPageViewController *newsPageVc = [[ELNewsPageViewController alloc] init];
//            [self addChildViewController:newsPageVc];
//        }
//    } else {
//        for (NSInteger i = 0; i < cacheChannelNumber - lastChannelNumber; i++) {
//            ELNewsPageViewController *newsPageVc = [self.childViewControllers lastObject];
//            [newsPageVc.view removeFromSuperview];
//            [newsPageVc removeFromParentViewController];
//        }
//    }
//    for (NSInteger i = 0; i < _channleViewModel.channelBean.home.count; i++) {
//        ELSingleChannelBean *bean = [_channleViewModel.channelBean.home safeObjectAtIndex:i];
//        ELNewsPageViewController *newsPageVc = [self.childViewControllers safeObjectAtIndex:i];
//        newsPageVc.title = bean.name;
//        newsPageVc.singleChannelBean = bean;
//        newsPageVc.tabType = ELTabTypeHome;
//        newsPageVc.delegate = self;
//    }
//    [self refreshDisplay];
//}

#pragma mark - Setter Getter Methods

#pragma mark - External Delegate




@end
