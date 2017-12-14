//
//  ELCommunityRecommendPageBean.m
//  ELENews
//
//  Created by EL on 2017/12/14.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELCommunityRecommendPageBean.h"
#import "ELCommunityFeedListBean.h"
#import "ELCommunityStarBean.h"

@implementation ELCommunityRecommendPageBean

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"list" : ELCommunityFeedListBean.class,
             @"stars" : ELCommunityStarBean.class
             };
}

@end
