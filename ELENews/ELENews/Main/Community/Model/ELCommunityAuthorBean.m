//
//  ELCommunityAuthorBean.m
//  ELENews
//
//  Created by EL on 2017/12/14.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELCommunityAuthorBean.h"

@implementation ELCommunityAuthorBean

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"authorID" : @"id"
             };
}

@end
