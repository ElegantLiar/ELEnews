//
//  ELVideoListBean.m
//  ELENews
//
//  Created by EL on 2017/12/14.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELVideoListBean.h"

@implementation ELVideoListBean

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"videoID" : @"id"
             };
}

- (NSAttributedString *)titleAttributedStringWithFontSize:(CGFloat)size{
    return [NSAttributedString attributedStringWithString:self.title
                                                 fontSize:size
                                                    color:[UIColor hexChangeFloat:@"333333"]
                                           firstWordColor:nil];
}

@end
