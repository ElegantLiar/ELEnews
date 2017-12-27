//
//  ELHomeChannelViewModel.m
//  ELENews
//
//  Created by EL on 2017/12/7.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELHomeChannelViewModel.h"

@implementation ELHomeChannelViewModel

+ (ELHomeChannelViewModel *)shareInstance{
    static ELHomeChannelViewModel *viewModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        viewModel = [[ELHomeChannelViewModel alloc] init];
    });
    return viewModel;
}

- (void)loadDataFromNetwork{
    @weakify(self);

    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            
            [[ELHTTPManager manager] GET:@"http://api.app.happyjuzi.com/common/menu"
                              parameters:[ELNetWorkBaseParams baseParams]
                                progress:nil
                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                     [[ELNetworkCache shareInstance] setObject:responseObject forKey:kELNetworkCacheChannel withBlock:nil];
                self.channelBean = [ELChannelBean yy_modelWithJSON:[responseObject objectForKey:@"data"]];
                [subscriber sendNext:self.channelBean];
                [subscriber sendCompleted];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [subscriber sendError:error];
            }];
            
            return nil;
        }];
        
        return signal;
    }];
}

- (void)loadChannelDataFromCache{
    @weakify(self);
    
    _cacheCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            
            id responseObject = [[ELNetworkCache shareInstance] objectForKey:kELNetworkCacheChannel];
            if (responseObject) {
                self.channelBean = [ELChannelBean yy_modelWithJSON:[responseObject objectForKey:@"data"]];
                [subscriber sendNext:self.channelBean];
                [subscriber sendCompleted];
            } else {
                [subscriber sendCompleted];
            }
            
            return nil;
        }];
        
        return signal;
    }];
}


@end
