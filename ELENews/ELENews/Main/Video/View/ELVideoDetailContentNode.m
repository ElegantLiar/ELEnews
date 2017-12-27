//
//  ELVideoDetailContentNode.m
//  ELENews
//
//  Created by EL on 2017/12/25.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELVideoDetailContentNode.h"

@implementation ELVideoDetailContentNode{
    ASTextNode      *_titleNode;
}

- (instancetype)initWithTitle:(NSString *)title{
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        _titleNode = [[ASTextNode alloc] init];
        _titleNode.attributedText = [NSAttributedString attributedStringWithString:title
                                                                          fontSize:19
                                                                             color:[UIColor hexChangeFloat:@"333333"]
                                                                    firstWordColor:nil];
        [self addSubnode:_titleNode];
    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    ASInsetLayoutSpec *contentInsetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 20, 10, 20)
                                                                                 child:_titleNode];
    return contentInsetSpec;
}
@end
