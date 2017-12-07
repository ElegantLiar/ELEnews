//
//  ELNewsCommonViewController.m
//  ELENews
//
//  Created by EL on 2017/12/7.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELNewsCommonViewController.h"
#import "ELChannelBean.h"
#import "ELFeedViewModel.h"
#import "ELNewsCommonBean.h"

@interface ELNewsCommonViewController (){
    ELFeedViewModel     *_feedViewModel;
    ELNewsCommonBean    *_commonBean;
}

@end

@implementation ELNewsCommonViewController

#pragma mark – LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.    
    _feedViewModel = [[ELFeedViewModel alloc] init];
    _feedViewModel.channelID = _singleChannelBean.channelID;
    [_feedViewModel loadDataFromNetwork];
    @weakify(self);
    [[_feedViewModel.requestCommand execute:nil] subscribeNext:^(ELNewsCommonBean *commonBean) {
        @strongify(self);
        self->_commonBean = commonBean;
    }];
}

#pragma mark - Intial Methods

#pragma mark – Target Methods

#pragma mark - Private Methods

#pragma mark - Setter Getter Methods

#pragma mark - External Delegate


@end
