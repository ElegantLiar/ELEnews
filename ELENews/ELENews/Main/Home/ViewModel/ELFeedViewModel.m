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
            [[ELHTTPManager manager] GET:@"http://api.app.happyjuzi.com/article/list/userfeed?accesstoken=75ef25b9f45e25ff36109edd0534aabd&brand=Apple&carrier=3&idfa=5C2FFF1F-EACD-4ABB-BBFC-7D0A124BA33F&model=iPhone7Plus&net=wifi&page=1&pf=ios&res=414x736&size=20&system=10.3.2&uid=4181641837230884&ver=4.1.1" parameters:@{@"id" : @(self.channelID)} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                ELNewsCommonBean *commonBean = [ELNewsCommonBean modelWithJSON:[responseObject objectForKey:@"data"]];
                [subscriber sendNext:commonBean];
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
