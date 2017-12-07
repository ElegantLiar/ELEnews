//
//  ELChannelBean.m
//  ELENews
//
//  Created by EL on 2017/12/7.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELChannelBean.h"

@implementation ELChannelBean

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"home" : ELSingleChannelBean.class,
             @"video" : ELSingleChannelBean.class,
             };
}

@end

@implementation ELSingleChannelBean

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"channelID" : @"id"
             };
}

@end
