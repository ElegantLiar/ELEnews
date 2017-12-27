//
//  ELNewsDetailInfoPageBean.m
//  ELENews
//
//  Created by EL on 2017/12/25.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELNewsDetailInfoPageBean.h"

@implementation ELNewsDetailInfoPageBean

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"tags" : ELNewsDetailTagBean.class,
             @"video" : ELNewsDetailVideoBean.class,
             };
}

@end

@implementation ELNewsDetailArticalBean

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"articalID" : @"id"
             };
}

@end

@implementation ELNewsDetailTagBean

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"tagID" : @"id"
             };
}

@end

@implementation ELNewsDetailCommentBean

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"list" : ELNewsDetailCommentContentBean.class,
             };
}
@end

@implementation ELNewsDetailCommentUserBean
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"userID" : @"id"
             };
}

@end

@implementation ELNewsDetailCommentContentBean
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"commentID" : @"id"
             };
}

- (NSAttributedString *)timeAttributedStringWithFontSize:(CGFloat)size{
    return [NSAttributedString attributedStringWithString:self.publish_time
                                                 fontSize:size
                                                    color:[UIColor hexChangeFloat:@"999999"]
                                           firstWordColor:nil];
}
- (NSAttributedString *)nameAttributedStringWithFontSize:(CGFloat)size{
    return [NSAttributedString attributedStringWithString:self.user.name
                                                 fontSize:size
                                                    color:[UIColor hexChangeFloat:@"666666"]
                                           firstWordColor:nil];
}
- (NSAttributedString *)contentAttributedStringWithFontSize:(CGFloat)size{
    return [NSAttributedString attributedStringWithString:self.content
                                                 fontSize:size
                                                    color:[UIColor hexChangeFloat:@"333333"]
                                           firstWordColor:nil];
}
@end

@implementation ELNewsDetailAttitudeBean

@end

@implementation ELNewsDetailVideoBean

@end
