//
//  ELCommunityFeedListBean.m
//  ELENews
//
//  Created by EL on 2017/12/14.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELCommunityFeedListBean.h"
#import "ELFlashListBean.h"

@implementation ELCommunityFeedListBean

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"feedID" : @"id"
             };
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"img" : NSString.class,
             @"img_size" : ELFlashImageBean.class,
             @"comments" : ELCommunityCommentListBean.class
             };
}

- (NSAttributedString *)usernameAttributedStringWithFontSize:(CGFloat)size{
    return [NSAttributedString attributedStringWithString:self.author.name
                                                 fontSize:size
                                                    color:[UIColor hexChangeFloat:@"666666"]
                                           firstWordColor:nil];
}
- (NSAttributedString *)timeAttributedStringWithFontSize:(CGFloat)size{
    return [NSAttributedString attributedStringWithString:self.create_time
                                                 fontSize:size
                                                    color:[UIColor hexChangeFloat:@"999999"]
                                           firstWordColor:nil];
}
- (NSAttributedString *)titleAttributedStringWithFontSize:(CGFloat)size{
    return [NSAttributedString attributedStringWithString:self.title
                                                 fontSize:size
                                                    color:[UIColor hexChangeFloat:@"333333"]
                                           firstWordColor:nil];
}
- (NSAttributedString *)textAttributedStringWithFontSize:(CGFloat)size{
    return [NSAttributedString attributedStringWithString:self.content
                                                 fontSize:size
                                                    color:[UIColor hexChangeFloat:@"999999"]
                                           firstWordColor:nil];
}
@end
