//
//  ELNewsListBean.m
//  ELENews
//
//  Created by EL on 2017/12/13.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELNewsListBean.h"

@implementation ELNewsListBean

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"newsID" : @"id"
             };
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"gallary" : NSDictionary.class,
             };
}

- (NSAttributedString *)usernameAttributedStringWithFontSize:(CGFloat)size{
    return [NSAttributedString attributedStringWithString:self.cat.name
                                                 fontSize:size
                                                    color:[UIColor darkBlueColor]
                                           firstWordColor:nil];
}

- (NSAttributedString *)newsAttributedStringWithFontSize:(CGFloat)size{
    return [NSAttributedString attributedStringWithString:self.title
                                                 fontSize:size
                                                    color:[UIColor hexChangeFloat:@"333333"]
                                           firstWordColor:nil];
}

@end

@implementation ELNewsAuthorBean

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"authorID" : @"id"
             };
}

@end
