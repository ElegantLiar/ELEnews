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
            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[ELNetWorkBaseParams baseParams]];
            [params setObject:@(self.channelID) forKey:@"id"];
            [params setObject:@(self->_page) forKey:@"page"];
            NSString *url = self.channelID == 0 ? @"http://api.app.happyjuzi.com/article/list/userfeed" : @"http://api.app.happyjuzi.com/article/list/channel";
            [[ELHTTPManager manager] GET:url
                              parameters:params
                                progress:nil
                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
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
