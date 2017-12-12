//
//  ELNewsCommonBean.m
//  ELENews
//
//  Created by EL on 2017/12/7.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELNewsCommonBean.h"
#import "ELFeedBean.h"

@implementation ELNewsCommonBean

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"info" : ELFeedBean.class,
             @"list" : ELFeedBean.class,
             };
}

@end
