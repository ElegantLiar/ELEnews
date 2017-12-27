//
//  ELFeedViewModel.m
//  ELENews
//
//  Created by EL on 2017/12/7.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELFeedViewModel.h"
#import "ELNewsPageBean.h"
#import "ELFlashListBean.h"
#import "ELFlashPageBean.h"
#import "ELGIFPageBean.h"
#import "ELVideoPageBean.h"

@implementation ELFeedViewModel

- (void)loadDataFromNetwork{
    
    @weakify(self);
    
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[ELNetWorkBaseParams baseParams]];
            [params setObject:@(self.channelID) forKey:@"id"];
            [params setObject:@(self->_page) forKey:@"page"];
            NSString *url = nil;
            if (_tabType == ELTabTypeHome) {
                if (_feedType == ELFeedTypeFlash) {
                    url = @"http://api.app.happyjuzi.com/flash/hotlist";
                } else if (_feedType == ELFeedTypeGif) {
                    url = @"http://api.app.happyjuzi.com/article/list/gif";
                } else {
                    url = self.channelID == 0 ? @"http://api.app.happyjuzi.com/article/list/userfeed" : @"http://api.app.happyjuzi.com/article/list/channel";
                }
            } else if (_tabType == ELTabTypeVideo){
                if (_channelID == 0) {
                    url = @"http://api.app.happyjuzi.com/video/home";
                } else {
                    url = @"http://api.app.happyjuzi.com/video/category";
                }
            }
            
            [[ELHTTPManager manager] GET:url
                              parameters:params
                                progress:nil
                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                     if (self.channelID == 0 && self->_page == 1 && self->_tabType == ELTabTypeHome) {
                                         [[ELNetworkCache shareInstance] setObject:responseObject forKey:kELNetworkCacheMainPage withBlock:nil];
                                     }
                [subscriber sendNext:[self configureResponseObject:responseObject]];
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

- (void)loadDataFromCache{
    @weakify(self);
    
    _cacheCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            
            id responseObject = [[ELNetworkCache shareInstance] objectForKey:kELNetworkCacheMainPage];
            if (responseObject) {
                [subscriber sendNext:[self configureResponseObject:responseObject]];
                [subscriber sendCompleted];
            } else {
                [subscriber sendCompleted];
            }
            
            return nil;
        }];
        
        return signal;
    }];
}

- (void)setFlag:(NSInteger)flag{
    _flag = flag;
    if (_flag == 13) {
        _feedType = ELFeedTypeFlash;
    } else if (_flag == 12) {
        _feedType = ELFeedTypeGif;
    } else {
        _feedType = ELFeedTypeNews;
    }
}

- (NSArray *)configureResponseObject:(id)responseObject{
    NSArray *listArray = nil;
    if (_tabType == ELTabTypeHome) {
        if (_feedType == ELFeedTypeFlash) {
            ELFlashPageBean *flashPageBean = [ELFlashPageBean yy_modelWithJSON:[responseObject objectForKey:@"data"]];
            listArray = flashPageBean.list;
        } else if (_feedType == ELFeedTypeGif) {
            ELGIFPageBean *gifPageBean = [ELGIFPageBean yy_modelWithJSON:[responseObject objectForKey:@"data"]];
            listArray = gifPageBean.list;
        } else {
            ELNewsPageBean *newsPageBean = [ELNewsPageBean yy_modelWithJSON:[responseObject objectForKey:@"data"]];
            listArray = newsPageBean.list;
        }
    }  else if (_tabType == ELTabTypeVideo) {
        ELVideoPageBean *newsPageBean = [ELVideoPageBean yy_modelWithJSON:[responseObject objectForKey:@"data"]];
        listArray = newsPageBean.list;
    }
    return listArray;
}

- (void)loadFirstPageDataFromNetwork{
    _page = 1;
    [self loadDataFromNetwork];
}

- (void)loadNextPageDataFromNetwork{
    _page ++;
    [self loadDataFromNetwork];
}

- (void)loadFirstPageDataFromCache{
    _page = 1;
    [self loadDataFromCache];
}
@end
