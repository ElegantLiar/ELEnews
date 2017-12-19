//
//  ELCommunityTopicCategoryBean.m
//  ELENews
//
//  Created by EL on 2017/12/18.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELCommunityTopicCategoryBean.h"

@implementation ELCommunityTopicCategoryBean

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"cateID" : @"id"
             };
}

- (NSAttributedString *)topicCategoryTitleAttributedStringWithFontSize:(CGFloat)size{
    return [NSAttributedString attributedStringWithString:self.title
                                                 fontSize:size
                                                    color:[UIColor hexChangeFloat:@"666666"]
                                           firstWordColor:nil];
}
@end
