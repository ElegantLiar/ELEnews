//
//  ELVideoDetailViewController.m
//  ELENews
//
//  Created by EL on 2017/12/25.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELVideoDetailViewController.h"
#import "ELNewsDetailViewModel.h"
#import "ELNewsDetailView.h"
#import "WMPlayer.h"

@interface ELVideoDetailViewController ()<WMPlayerDelegate>

@end

@implementation ELVideoDetailViewController{
    ELNewsDetailViewModel       *_viewModel;
    ELNewsDetailPageBean        *_pageBean;
    ELNewsDetailInfoPageBean    *_infoPageBean;
    ELNewsDetailView            *_detailView;
    WMPlayer                    *_videoPlayer;
    
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
    
    [[_viewModel.infoRequestCommand execute:nil] subscribeNext:^(ELNewsDetailInfoPageBean *pageBean) {
        @strongify(self);
        self->_infoPageBean = pageBean;
        ELNewsDetailVideoBean *videoBean = [pageBean.video safeObjectAtIndex:0];
        [self->_videoPlayer.coverImageView yy_setImageWithURL:[NSURL URLWithString:videoBean.img] placeholder:nil];
        self->_videoPlayer.URLString = videoBean.url;
       
    } error:^(NSError *error) {
        
    }];
}
#pragma mark - Intial Methods
- (void)initUI{
    [self.baseNavigationView setBackgroundColor:ELClearColor];
    
    [self.baseContentView setHidden:YES];
    
    _videoPlayer = [[WMPlayer alloc] init];
    _videoPlayer.delegate = self;
    [self.view addSubview:_videoPlayer];
    [_videoPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view).with.offset(0);
        make.width.mas_equalTo(@(ELScreenW));
        make.height.mas_equalTo(@(ELScreenW / 5 * 3));
    }];
    
    _detailView = [[ELNewsDetailView alloc] init];
    _detailView.type = ELNewsDetailViewTypeVideo;
    [self.view addSubview:_detailView];
    [_detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_videoPlayer.mas_bottom).with.offset(0);
        make.left.right.mas_equalTo(self.view).with.offset(0);
        make.bottom.mas_equalTo(self.view).with.offset(0);
    }];
}
#pragma mark – Target Methods

#pragma mark - Private Methods

#pragma mark - Setter Getter Methods

#pragma mark - External Delegate
-(void)wmplayer:(WMPlayer *)wmplayer clickedCloseButton:(UIButton *)closeBtn{
    [wmplayer pause];
    [self.navigationController popViewControllerAnimated:YES];
}

@end

