//
//  ELCommunityFindPageBean.m
//  ELENews
//
//  Created by EL on 2017/12/18.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELCommunityFindPageBean.h"
#import "ELCommunityOptBean.h"
#import "ELCommunityTopicBean.h"
#import "ELCommunityBannerBean.h"
#import "ELCommunityStarBean.h"
#import "ELCommunityTopicCategoryBean.h"

@implementation ELCommunityFindPageBean

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"opts" : ELCommunityOptBean.class,
             @"topics" : ELCommunityTopicBean.class,
             @"cats" : ELCommunityTopicCategoryBean.class,
             @"banners" : ELCommunityStarBean.class,
             @"stars" : ELCommunityTopicCategoryBean.class
             };
}


@end
