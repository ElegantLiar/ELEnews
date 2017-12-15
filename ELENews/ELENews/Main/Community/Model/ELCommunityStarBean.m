//
//  ELCommunityStarBean.m
//  ELENews
//
//  Created by EL on 2017/12/14.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELCommunityStarBean.h"

@implementation ELCommunityStarBean

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"starID" : @"id"
             };
}

- (NSAttributedString *)starNameAttributedStringWithFontSize:(CGFloat)size{
    return [NSAttributedString attributedStringWithString:self.name
                                                 fontSize:size
                                                    color:[UIColor hexChangeFloat:@"333333"]
                                           firstWordColor:nil];
}

@end
