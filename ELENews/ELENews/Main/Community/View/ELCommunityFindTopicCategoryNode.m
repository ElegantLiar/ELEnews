//
//  ELCommunityFindTopicCategoryNode.m
//  ELENews
//
//  Created by EL on 2017/12/19.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELCommunityFindTopicCategoryNode.h"

@implementation ELCommunityFindTopicCategoryNode{
    ELCommunityTopicCategoryBean    *_bean;
    ASNetworkImageNode              *_iconImageNode;
    ASTextNode                      *_categoryTitleLabel;
    ASDisplayNode                   *_btmLine;
}

- (instancetype)initWithCommunityTopicCategoryBean:(ELCommunityTopicCategoryBean *)bean{
    if (self = [super init]) {
        _bean = bean;
        
        _iconImageNode = [[ASNetworkImageNode alloc] init];
        _iconImageNode.URL = [NSURL URLWithString:_bean.pic];
        _iconImageNode.backgroundColor = [UIColor blueColor];
        [self addSubnode:_iconImageNode];
        _iconImageNode.imageModificationBlock = ^UIImage *(UIImage *image) {
            UIImage *modifiedImage;
            CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
            UIGraphicsBeginImageContextWithOptions(image.size, false, [[UIScreen mainScreen] scale]);
            [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:4] addClip];
            [image drawInRect:rect];
            modifiedImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return modifiedImage;
        };
        
        _iconImageNode.style.preferredSize = CGSizeMake(50, 50);
        
        _categoryTitleLabel = [[ASTextNode alloc] init];
        _categoryTitleLabel.attributedText = [_bean topicCategoryTitleAttributedStringWithFontSize:19];
        [self addSubnode:_categoryTitleLabel];
        
        _btmLine = [[ASDisplayNode alloc] init];
        _btmLine.style.preferredSize = CGSizeMake(ELScreenW - 20, 0.2);
        _btmLine.backgroundColor = ELLineColor;
        [self addSubnode:_btmLine];
    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    ASStackLayoutSpec *iconTitleHorizontalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                                          spacing:20
                                                                                   justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter
                                                                                         children:@[_iconImageNode, _categoryTitleLabel]];
    
    ASInsetLayoutSpec *iconTitleSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10)
                                                                              child:iconTitleHorizontalStack];
    
    ASInsetLayoutSpec *btmLineSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 10, 0, 10)
                                                                            child:_btmLine];
    
    ASStackLayoutSpec *contentVerticalSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                                     spacing:0
                                                                              justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart
                                                                                    children:@[iconTitleSpec, btmLineSpec]];
    return contentVerticalSpec;
}
@end
