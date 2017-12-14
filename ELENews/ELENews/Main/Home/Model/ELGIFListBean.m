//
//  ELGIFListBean.m
//  ELENews
//
//  Created by EL on 2017/12/13.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELGIFListBean.h"

@implementation ELGIFListBean

- (NSAttributedString *)titleAttributedStringWithFontSize:(CGFloat)size{
    return [NSAttributedString attributedStringWithString:self.title
                                                 fontSize:size
                                                    color:[UIColor hexChangeFloat:@"333333"]
                                           firstWordColor:nil];
}

- (NSAttributedString *)usernameAttributedStringWithFontSize:(CGFloat)size{
    return [NSAttributedString attributedStringWithString:self.author.name
                                                 fontSize:size
                                                    color:[UIColor darkBlueColor]
                                           firstWordColor:nil];
}

@end

@implementation ELGIFBean

@end
