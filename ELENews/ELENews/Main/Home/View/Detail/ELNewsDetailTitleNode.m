//
//  ELNewsDetailTitleNode.m
//  ELENews
//
//  Created by EL on 2017/12/21.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELNewsDetailTitleNode.h"

@implementation ELNewsDetailTitleNode{
    ASTextNode      *_titleNode;
}

- (instancetype)initWithTitle:(NSString *)title{
    if (self = [super init]) {
        _titleNode = [[ASTextNode alloc] init];
        _titleNode.attributedText = [NSAttributedString attributedStringWithString:title
                                                                          fontSize:23
                                                                             color:[UIColor hexChangeFloat:@"333333"]
                                                                    firstWordColor:nil];
        [self addSubnode:_titleNode];
    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    ASInsetLayoutSpec *contentInsetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10)
                                                                                 child:_titleNode];
    return contentInsetSpec;
}
@end
