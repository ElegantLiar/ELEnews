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
            [[ELHTTPManager manager] GET:@"http://api.app.happyjuzi.com/common/menu?accesstoken=ab70a6b0de0ca33563c3b1dc39b79d51&brand=Apple&carrier=3&idfa=A5FBDFCB-A55A-4C10-8760-663591A38884&model=iPhone6&net=wifi&pf=ios&res=375x667&system=11.0.3&uid=4163863113584163&ver=4.1" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
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

@end
