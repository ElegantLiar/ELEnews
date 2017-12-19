//
//  ELCommunityFindViewModel.m
//  ELENews
//
//  Created by EL on 2017/12/18.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELCommunityFindViewModel.h"
#import "ELCommunityFindPageBean.h"

@implementation ELCommunityFindViewModel

- (void)loadDataFromNetwork{
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[ELNetWorkBaseParams baseParams]];
            [params setObject:@(0) forKey:@"islogin"];
            [params setObject:@(1) forKey:@"page"];
            NSString *url = @"http://api.app.happyjuzi.com/shequ/index/discovery";
            [[ELHTTPManager manager] GET:url
                              parameters:params
                                progress:nil
                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                     ELCommunityFindPageBean *findPageBean = [ELCommunityFindPageBean yy_modelWithJSON:[responseObject objectForKey:@"data"]];
                                     [subscriber sendNext:findPageBean];
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

