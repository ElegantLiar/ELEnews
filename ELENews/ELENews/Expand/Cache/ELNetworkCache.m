//
//  ELNetworkCache.m
//  ELENews
//
//  Created by EL on 2017/12/26.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELNetworkCache.h"

@implementation ELNetworkCache

+ (instancetype)shareInstance{
    static ELNetworkCache *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [ELNetworkCache cacheWithName:kELNetworkCache];
    });
    return _instance;
}


@end
