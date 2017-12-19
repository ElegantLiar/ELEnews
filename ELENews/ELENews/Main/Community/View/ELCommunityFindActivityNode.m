//
//  ELCommunityFindActivityNode.m
//  ELENews
//
//  Created by EL on 2017/12/19.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELCommunityFindActivityNode.h"

@implementation ELCommunityFindActivityNode{
    ELCommunityActivityBean         *_bean;
    ASNetworkImageNode              *_bannerImageNode;
    ASTextNode                      *_titleNode;
    ASTextNode                      *_subTitleNode;
}

- (instancetype)initWithCommunityActivityBean:(ELCommunityActivityBean *)bean{
    if (self = [super init]) {
        _bean = bean;
        
        _bannerImageNode = [[ASNetworkImageNode alloc] init];
        _bannerImageNode.URL = [NSURL URLWithString:_bean.pic];
        _bannerImageNode.style.preferredSize = CGSizeMake(ELScreenW - 20, (ELScreenW - 20) / 16 * 9);
        [self addSubnode:_bannerImageNode];
        _bannerImageNode.imageModificationBlock = ^UIImage *(UIImage *image) {
            UIImage *modifiedImage;
            CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
            UIGraphicsBeginImageContextWithOptions(image.size, false, [[UIScreen mainScreen] scale]);
            [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:4] addClip];
            [image drawInRect:rect];
            modifiedImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return modifiedImage;
        };
        
        
        _titleNode = [[ASTextNode alloc] init];
        _titleNode.attributedText = [_bean titleAttributedStringWithFontSize:19];
        [self addSubnode:_titleNode];
        
        _subTitleNode = [[ASTextNode alloc] init];
        _subTitleNode.attributedText = [_bean subTitleAttributedStringWithFontSize:17];
        [self addSubnode:_subTitleNode];
    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    ASStackLayoutSpec *contentVerticalSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                                     spacing:10
                                                                              justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart
                                                                                    children:@[_bannerImageNode, _titleNode, _subTitleNode]];
    
    ASInsetLayoutSpec *contentInsetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10)
                                                                                 child:contentVerticalSpec];
    return contentInsetSpec;
}

@end
