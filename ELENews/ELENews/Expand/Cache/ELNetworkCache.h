//
//  ELNetworkCache.h
//  ELENews
//
//  Created by EL on 2017/12/26.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <YYCache/YYCache.h>

@interface ELNetworkCache : YYCache

+ (ELNetworkCache *)shareInstance;

@end
