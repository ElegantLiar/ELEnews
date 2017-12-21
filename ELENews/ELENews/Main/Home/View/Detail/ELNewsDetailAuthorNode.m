//
//  ELNewsDetailAuthorNode.m
//  ELENews
//
//  Created by EL on 2017/12/21.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELNewsDetailAuthorNode.h"

@implementation ELNewsDetailAuthorNode{
    ASTextNode                  *_authorNameLabel;
    ASTextNode                  *_publishTimeLabel;
    ELNewsDetailInfoBean        *_detailInfoBean;
    ASNetworkImageNode          *_userAvatarImageNode;
}

- (instancetype)initWithNewsDetailInfoBean:(ELNewsDetailInfoBean *)detailInfoBean{
    if (self = [super init]) {
        _detailInfoBean = detailInfoBean;
        
        _userAvatarImageNode = [[ASNetworkImageNode alloc] init];
        _userAvatarImageNode.URL = [NSURL URLWithString:_detailInfoBean.author.pic];
        [self addSubnode:_userAvatarImageNode];
        _userAvatarImageNode.imageModificationBlock = ^UIImage *(UIImage *image) {
            UIImage *modifiedImage;
            CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
            UIGraphicsBeginImageContextWithOptions(image.size, false, [[UIScreen mainScreen] scale]);
            [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:30] addClip];
            [image drawInRect:rect];
            modifiedImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return modifiedImage;
        };
        _userAvatarImageNode.style.preferredSize = CGSizeMake(30, 30);
        
        _authorNameLabel = [[ASTextNode alloc] init];
        _authorNameLabel.attributedText = [NSAttributedString attributedStringWithString:_detailInfoBean.author.name
                                                                          fontSize:13
                                                                             color:[UIColor hexChangeFloat:@"333333"]
                                                                    firstWordColor:nil];
        [self addSubnode:_authorNameLabel];
        
        _publishTimeLabel = [[ASTextNode alloc] init];
        _publishTimeLabel.attributedText = [NSAttributedString attributedStringWithString:_detailInfoBean.publish_time
                                                                                fontSize:10
                                                                                   color:[UIColor hexChangeFloat:@"999999"]
                                                                          firstWordColor:nil];
        [self addSubnode:_publishTimeLabel];
    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    ASStackLayoutSpec *authorVerticalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                                     spacing:6
                                                                              justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart
                                                                                    children:@[_authorNameLabel, _publishTimeLabel]];
    
    ASStackLayoutSpec *contentHorizontalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                                        spacing:10
                                                                                 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[_userAvatarImageNode, authorVerticalStack]];
    
    ASInsetLayoutSpec *contentInsetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10)
                                                                                 child:contentHorizontalStack];
    return contentInsetSpec;
}

@end
