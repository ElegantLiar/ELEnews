//
//  ELVideoPageBean.m
//  ELENews
//
//  Created by EL on 2017/12/14.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELVideoPageBean.h"
#import "ELVideoListBean.h"

@implementation ELVideoPageBean

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"list" : ELVideoListBean.class
             };
}

@end
