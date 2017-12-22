//
//  ELNewsPhotoDetailViewController.m
//  ELENews
//
//  Created by EL on 2017/12/22.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELNewsPhotoDetailViewController.h"
#import "ELNewsDetailViewModel.h"
#import "ELPhotoBrowser.h"

@interface ELNewsPhotoDetailViewController () <XLPhotoBrowserDelegate>

@end

@implementation ELNewsPhotoDetailViewController{
    ELNewsPhotoDetailViewModel   *_viewModel;
    ELNewsPhotoDetailPageBean    *_pageBean;
    ELPhotoBrowser               *_photoBrowser;
}

#pragma mark – LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    _viewModel = [[ELNewsPhotoDetailViewModel alloc] init];
    
    [_viewModel loadDataFromNetworkWithNewsID:_newID];
    
    @weakify(self);
    [[_viewModel.requestCommand execute:nil] subscribeNext:^(ELNewsPhotoDetailPageBean *pageBean) {
        @strongify(self);
        self->_pageBean = pageBean;
        self->_photoBrowser = [ELPhotoBrowser showPhotoBrowserWithImages:self->_pageBean.photoUrls
                                                       currentImageIndex:0
                                                                rootView:self.view];
        self->_photoBrowser.pageControlStyle = XLPhotoBrowserPageControlStyleNone;
        self->_photoBrowser.delegate = self;
        self->_photoBrowser.photoDetailPageBean = pageBean;
    } error:^(NSError *error) {
        
    }];
}
#pragma mark - Intial Methods
- (void)initUI{
    
}
#pragma mark – Target Methods

#pragma mark - Private Methods

#pragma mark - Setter Getter Methods

#pragma mark - XLPhotoBrowserDelegate
- (void)photoBrowserClickSinglePhoto:(XLPhotoBrowser *)browser{
}

- (void)photoBrowserClickBackBtn:(XLPhotoBrowser *)browser{
    [self.navigationController popViewControllerAnimated:YES];
    [_photoBrowser dismiss];
    
}

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
