//
//  ELNewsDetailViewController.m
//  ELENews
//
//  Created by EL on 2017/12/21.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELNewsDetailViewController.h"
#import "ELNewsDetailView.h"
#import "ELNewsDetailViewModel.h"

@interface ELNewsDetailViewController ()

@property (nonatomic, strong, readonly) ELNewsDetailViewModel *viewModel;

@end


@implementation ELNewsDetailViewController{
    ELNewsDetailPageBean        *_pageBean;
    ELNewsDetailView            *_detailView;
}

@dynamic viewModel;

#pragma mark – LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    [self.viewModel loadDataFromNetwork];
    [self.viewModel loadInfoFromNetwork];

    @weakify(self);
    [[self.viewModel.requestCommand execute:nil] subscribeNext:^(ELNewsDetailPageBean *pageBean) {
        @strongify(self);
        self->_pageBean = pageBean;
        [self->_detailView setPageBean:self->_pageBean];
    } error:^(NSError *error) {
        
    }];
    
    [[self.viewModel.infoRequestCommand execute:nil] subscribeNext:^(ELNewsDetailInfoPageBean *infoPageBean) {
        @strongify(self);
        [self->_detailView setInfoPageBean:infoPageBean];
    } error:^(NSError *error) {
        
    }];
}
#pragma mark - Intial Methods
- (void)initUI{
    _detailView = [[ELNewsDetailView alloc] init];
    _detailView.type = ELNewsDetailViewTypeNews;
    [self.baseContentView addSubview:_detailView];
    [_detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.baseContentView).with.insets(UIEdgeInsetsZero);
    }];
    
}
#pragma mark – Target Methods

#pragma mark - Private Methods

#pragma mark - Setter Getter Methods

#pragma mark - External Delegate


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
