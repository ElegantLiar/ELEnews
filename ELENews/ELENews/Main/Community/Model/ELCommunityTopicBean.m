//
//  ELCommunityTopicBean.m
//  ELENews
//
//  Created by EL on 2017/12/14.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELCommunityTopicBean.h"

@implementation ELCommunityTopicBean

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"topicID" : @"id"
             };
}

- (NSAttributedString *)findTopicNameAttributedStringWithFontSize:(CGFloat)size{
    return [NSAttributedString attributedStringWithString:[NSString stringWithFormat:@"#%@", self.title]
                                                 fontSize:size
                                                    color:[UIColor hexChangeFloat:@"999999"]
                                           firstWordColor:nil];
}

@end
