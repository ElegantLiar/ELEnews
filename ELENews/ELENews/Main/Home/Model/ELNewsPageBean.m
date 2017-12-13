//
//  ELNewsPageBean.m
//  ELENews
//
//  Created by EL on 2017/12/12.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELNewsPageBean.h"
#import "ELFeedBean.h"

@implementation ELNewsPageBean

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"info" : ELFeedBean.class,
             @"list" : ELFeedBean.class,
             };
}

@end
