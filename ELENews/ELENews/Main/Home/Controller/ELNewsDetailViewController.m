//
//  ELNewsDetailViewController.m
//  ELENews
//
//  Created by EL on 2017/12/21.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELNewsDetailViewController.h"
#import "ELNewsDetailViewModel.h"
#import "ELNewsDetailView.h"

@interface ELNewsDetailViewController ()

@end

@implementation ELNewsDetailViewController{
    ELNewsDetailViewModel       *_viewModel;
    ELNewsDetailPageBean        *_pageBean;
    ELNewsDetailView            *_detailView;

}
#pragma mark – LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    _viewModel = [[ELNewsDetailViewModel alloc] init];
    
    [_viewModel loadDataFromNetworkWithNewsID:_newsID];
    [_viewModel loadInfoFromNetworkWithNewsID:_newsID];

    @weakify(self);
    [[_viewModel.requestCommand execute:nil] subscribeNext:^(ELNewsDetailPageBean *pageBean) {
        @strongify(self);
        self->_pageBean = pageBean;
        [self->_detailView setPageBean:self->_pageBean];
    } error:^(NSError *error) {
        
    }];
    
    [[_viewModel.infoRequestCommand execute:nil] subscribeNext:^(ELNewsDetailInfoPageBean *infoPageBean) {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
