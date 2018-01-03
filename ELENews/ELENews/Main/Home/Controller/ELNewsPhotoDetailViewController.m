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

@property (nonatomic, strong, readonly) ELNewsPhotoDetailViewModel *viewModel;

@end

@implementation ELNewsPhotoDetailViewController{
    ELNewsPhotoDetailPageBean    *_pageBean;
    ELPhotoBrowser               *_photoBrowser;
}

@dynamic viewModel;

#pragma mark – LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    [self.viewModel loadDataFromNetwork];
    
    @weakify(self);
    [[self.viewModel.requestCommand execute:nil] subscribeNext:^(ELNewsPhotoDetailPageBean *pageBean) {
        @strongify(self);
        self->_pageBean = pageBean;
        self->_photoBrowser = [ELPhotoBrowser showPhotoBrowserWithImages:self->_pageBean.photoUrls
                                                       currentImageIndex:0
                                                                rootView:self.view];
        self->_photoBrowser.placeholderImage = [UIImage imageNamed:@"placehoderImg_145x108_"];
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

@end
