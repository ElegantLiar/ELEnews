//
//  ELFlashBean.m
//  ELENews
//
//  Created by EL on 2017/12/12.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELFlashBean.h"

@implementation ELFlashBean

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"imgs" : ELFlashImageBean.class
             };
}

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"flashID" : @"id"
             };
}

- (NSAttributedString *)timeAttributedStringWithFontSize:(CGFloat)size{
    return [NSAttributedString attributedStringWithString:self.time
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
    return [NSAttributedString attributedStringWithString:self.text
                                                 fontSize:size
                                                    color:[UIColor hexChangeFloat:@"666666"]
                                           firstWordColor:nil];
}

@end

@implementation ELFlashImageBean

@end
