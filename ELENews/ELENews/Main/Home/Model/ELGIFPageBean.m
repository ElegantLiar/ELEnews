//
//  ELGifPageBean.m
//  ELENews
//
//  Created by EL on 2017/12/13.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELGifPageBean.h"
#import "ELGIFListBean.h"

@implementation ELGIFPageBean

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"info" : ELNewsListBean.class,
             @"list" : ELGIFListBean.class,
             };
}

@end
