//
//  ELFeedViewModel.h
//  ELENews
//
//  Created by EL on 2017/12/7.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELBaseViewModel.h"
#import "ELChannelBean.h"

typedef NS_ENUM(NSInteger, ELFeedType) {
    ELFeedTypeNews = 0,
    ELFeedTypeFlash,
    ELFeedTypeGif
};

typedef NS_ENUM(NSInteger, ELTabType) {
    ELTabTypeHome = 0,
    ELTabTypeVideo
};

@interface ELFeedViewModel : ELBaseViewModel

- (instancetype)initWithELSingleChannelBean:(ELSingleChannelBean *)bean;

@property (nonatomic, strong, readonly) RACCommand *requestCommand;

@property (nonatomic, strong, readonly) RACCommand *cacheCommand;

@property (nonatomic, assign) NSInteger channelID;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) NSInteger flag;

@property (nonatomic, assign) ELFeedType feedType;

@property (nonatomic, assign) ELTabType tabType;


- (void)loadFirstPageDataFromNetwork;

- (void)loadNextPageDataFromNetwork;

- (void)loadFirstPageDataFromCache;


@end
