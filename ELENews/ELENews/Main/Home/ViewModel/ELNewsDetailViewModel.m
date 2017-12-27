//
//  ELNewsDetailViewModel.m
//  ELENews
//
//  Created by EL on 2017/12/21.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELNewsDetailViewModel.h"

@implementation ELNewsDetailViewModel

- (void)loadDataFromNetworkWithNewsID:(NSInteger)newsID{
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[ELNetWorkBaseParams baseParams]];
            [params setObject:@(newsID) forKey:@"id"];
            NSString *url = @"http://api.app.happyjuzi.com/article/detail";
            [[ELHTTPManager manager] GET:url
                              parameters:params
                                progress:nil
                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                     ELNewsDetailPageBean *newsDetailPageBean = [ELNewsDetailPageBean yy_modelWithJSON:[responseObject objectForKey:@"data"]];
                                     [newsDetailPageBean configureContets];
                                     [subscriber sendNext:newsDetailPageBean];
                                     [subscriber sendCompleted];
                                     
                                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                     [subscriber sendError:error];
                                 }];
            
            return nil;
        }];
        
        return signal;
    }];
}

- (void)loadInfoFromNetworkWithNewsID:(NSInteger)newsID{
    _infoRequestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[ELNetWorkBaseParams baseParams]];
            [params setObject:@(newsID) forKey:@"id"];
            NSString *url = @"http://api.app.happyjuzi.com/article/info";
            [[ELHTTPManager manager] GET:url
                              parameters:params
                                progress:nil
                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                     ELNewsDetailInfoPageBean *newsDetailPageBean = [ELNewsDetailInfoPageBean yy_modelWithJSON:[responseObject objectForKey:@"data"]];
                                     [subscriber sendNext:newsDetailPageBean];
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

@implementation ELNewsPhotoDetailViewModel

- (void)loadDataFromNetworkWithNewsID:(NSInteger)newsID{
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[ELNetWorkBaseParams baseParams]];
            [params setObject:@(newsID) forKey:@"id"];
            NSString *url = @"http://api.app.happyjuzi.com/article/photo";
            [[ELHTTPManager manager] GET:url
                              parameters:params
                                progress:nil
                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                     ELNewsPhotoDetailPageBean *newsPhotoDetailPageBean = [ELNewsPhotoDetailPageBean yy_modelWithJSON:[responseObject objectForKey:@"data"]];
                                     [newsPhotoDetailPageBean configureUrls];
                                     [subscriber sendNext:newsPhotoDetailPageBean];
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

