//
//  ELFlashPageBean.m
//  ELENews
//
//  Created by EL on 2017/12/12.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELFlashPageBean.h"
#import "ELFlashBean.h"

@implementation ELFlashPageBean

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"list" : ELFlashBean.class,
             };
}

@end
