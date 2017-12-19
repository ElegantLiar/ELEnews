//
//  ELCommunityActivityBean.m
//  ELENews
//
//  Created by EL on 2017/12/18.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELCommunityActivityBean.h"

@implementation ELCommunityActivityBean

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"activityID" : @"id"
             };
}

- (NSAttributedString *)titleAttributedStringWithFontSize:(CGFloat)size{
    return [NSAttributedString attributedStringWithString:self.title
                                                 fontSize:size
                                                    color:[UIColor hexChangeFloat:@"666666"]
                                           firstWordColor:nil];
}

- (NSAttributedString *)subTitleAttributedStringWithFontSize:(CGFloat)size{
    return [NSAttributedString attributedStringWithString:self.sub
                                                 fontSize:size
                                                    color:[UIColor hexChangeFloat:@"999999"]
                                           firstWordColor:nil];
}
@end
