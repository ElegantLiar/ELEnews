//
//  ELNewsDetailCommentNode.m
//  ELENews
//
//  Created by EL on 2017/12/26.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELNewsDetailCommentNode.h"

@implementation ELNewsDetailCommentNode{
    ASNetworkImageNode              *_userAvatarImageNode;
    ASNetworkImageNode              *_photoImageNode;
    ASTextNode                      *_userNameLabel;
    ASTextNode                      *_timeLabel;
    ASTextNode                      *_contentLabel;
    ELNewsDetailCommentContentBean  *_contentBean;
}

- (instancetype)initWithCommentContentBean:(ELNewsDetailCommentContentBean *)contentBean{
    if (self = [super init]) {
        _contentBean = contentBean;
        
        _userNameLabel      = [[ASTextNode alloc] init];
        _userNameLabel.attributedText = [_contentBean nameAttributedStringWithFontSize:15];
        _userNameLabel.maximumNumberOfLines = 1;
        [self addSubnode:_userNameLabel];
        
        _timeLabel      = [[ASTextNode alloc] init];
        _timeLabel.attributedText = [_contentBean timeAttributedStringWithFontSize:10];
        _timeLabel.maximumNumberOfLines = 1;
        [self addSubnode:_timeLabel];
        
        _userAvatarImageNode = [[ASNetworkImageNode alloc] init];
        _userAvatarImageNode.URL = [NSURL URLWithString:_contentBean.user.avatar];
        _userAvatarImageNode.style.preferredSize = CGSizeMake(30, 30);
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
        
        _contentLabel      = [[ASTextNode alloc] init];
        _contentLabel.attributedText = [_contentBean contentAttributedStringWithFontSize:18];
        _contentLabel.maximumNumberOfLines = 0;
        [self addSubnode:_contentLabel];
    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    ASStackLayoutSpec *userNameVerticalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                                       spacing:5
                                                                                justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart
                                                                                      children:@[_userNameLabel, _timeLabel]];
    
    ASStackLayoutSpec *userHorizontalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                                       spacing:5
                                                                                justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter
                                                                                      children:@[_userAvatarImageNode, userNameVerticalStack]];
    
    ASInsetLayoutSpec *userInsetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 10, 0, 10) child:userHorizontalStack];
    
    ASInsetLayoutSpec *commentContentInsetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 45, 0, 45) child:_contentLabel];

    ASStackLayoutSpec *cellContentVerticalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                                       spacing:0
                                                                                justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch
                                                                                      children:@[userInsetSpec, commentContentInsetSpec]];
    
    ASInsetLayoutSpec *cellContentInsetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 0, 10, 0) child:cellContentVerticalStack];
    return cellContentInsetSpec;
}

@end

@implementation ELNewsDetailCommentTitleNode{
    ASTextNode      *_titleNode;
}

- (instancetype)initWithTitle:(NSString *)title{
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _titleNode = [[ASTextNode alloc] init];
        _titleNode.attributedText = [NSAttributedString attributedStringWithString:title
                                                                          fontSize:16
                                                                             color:[UIColor hexChangeFloat:@"333333"]
                                                                          lineSpac:1.5
                                                                     textAlignment:NSTextAlignmentCenter];
        [self addSubnode:_titleNode];
    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    ASInsetLayoutSpec *contentInsetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 30, 10, 30)
                                                                                 child:_titleNode];
    return contentInsetSpec;
}



@end
