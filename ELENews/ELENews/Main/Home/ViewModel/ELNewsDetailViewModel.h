//
//  ELNewsDetailViewModel.h
//  ELENews
//
//  Created by EL on 2017/12/21.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELNewsDetailPageBean.h"
#import "ELNewsDetailInfoPageBean.h"
#import "ELBaseViewModel.h"
#import "ELNewsListBean.h"

@interface ELNewsDetailViewModel : ELBaseViewModel

- (instancetype)initWithListBean:(ELNewsListBean *)listBean;

@property (nonatomic, strong, readonly) RACCommand *requestCommand;

@property (nonatomic, strong, readonly) RACCommand *infoRequestCommand;

@property (nonatomic, assign) NSInteger newsID;

- (void)loadDataFromNetwork;

- (void)loadInfoFromNetwork;


@end

@interface ELNewsPhotoDetailViewModel : ELBaseViewModel

@property (nonatomic, strong, readonly) RACCommand *requestCommand;

- (void)loadDataFromNetworkWithNewsID:(NSInteger)newsID;

@end
