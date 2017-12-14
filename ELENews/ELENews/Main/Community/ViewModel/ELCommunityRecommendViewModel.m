//
//  ELCommunityRecommendViewModel.m
//  ELENews
//
//  Created by EL on 2017/12/14.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELCommunityRecommendViewModel.h"
#import "ELCommunityRecommendPageBean.h"

@implementation ELCommunityRecommendViewModel

- (void)loadDataFromNetwork{    
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[ELNetWorkBaseParams baseParams]];
            [params setObject:@(0) forKey:@"islogin"];
            [[ELHTTPManager manager] GET:@"http://api.app.happyjuzi.com/shequ/index/index"
                              parameters:params
                                progress:nil
                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                ELCommunityRecommendPageBean *communityPageBean = [ELCommunityRecommendPageBean yy_modelWithJSON:[responseObject objectForKey:@"data"]];
                [subscriber sendNext:communityPageBean];
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
