//
//  ELFlashPageBean.m
//  ELENews
//
//  Created by EL on 2017/12/12.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELFlashPageBean.h"
#import "ELFlashListBean.h"

@implementation ELFlashPageBean

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"list" : ELFlashListBean.class,
             };
}

@end
