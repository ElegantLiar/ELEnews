//
//  ELFeedViewModel.m
//  ELENews
//
//  Created by EL on 2017/12/7.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELFeedViewModel.h"
#import "ELNewsCommonBean.h"
@implementation ELFeedViewModel

- (void)loadDataFromNetwork{
    @weakify(self);
    
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [[ELHTTPManager manager] GET:@"http://api.app.happyjuzi.com/article/list/userfeed?accesstoken=ab70a6b0de0ca33563c3b1dc39b79d51&brand=Apple&carrier=3&idfa=A5FBDFCB-A55A-4C10-8760-663591A38884&model=iPhone6&net=wifi&page=1&pf=ios&res=375x667&size=20&startup=1&system=11.0.3&uid=4163863113584163&ver=4.1" parameters:@{@"id" : @(self.channelID), @"page" : @(self->_page)} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                ELNewsCommonBean *commonBean = [ELNewsCommonBean yy_modelWithJSON:[responseObject objectForKey:@"data"]];
                [subscriber sendNext:commonBean];
                [subscriber sendCompleted];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (self->_page != 1) {
                    self->_page --;
                }
                [subscriber sendError:error];
            }];
            
            return nil;
        }];
        
        return signal;
    }];
}

- (void)loadFirstPageDataFromNetwork{
    _page = 1;
    [self loadDataFromNetwork];
}

- (void)loadNextPageDataFromNetwork{
    _page ++;
    [self loadDataFromNetwork];
}


@end
