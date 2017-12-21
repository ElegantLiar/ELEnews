//
//  ELNewsOneSmallPicLeftFeedNote.m
//  ELENews
//
//  Created by EL on 2017/12/21.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELNewsOneSmallPicLeftFeedNote.h"

#define USER_IMAGE_HEIGHT       13
#define CONTENT_SPACE           6

#define InsetForContent UIEdgeInsetsMake(CONTENT_SPACE, CONTENT_SPACE * 2, CONTENT_SPACE, CONTENT_SPACE * 2)

#define HEADER_HEIGHT           50

@implementation ELNewsOneSmallPicLeftFeedNote{
    ASNetworkImageNode  *_userAvatarImageNode;
    ASNetworkImageNode  *_photoImageNode;
    ASTextNode          *_userNameLabel;
    ASTextNode          *_newsLabel;
    ELNewsListBean      *_newsListBean;
}

- (instancetype)initWithNewsListBean:(ELNewsListBean *)newsListBean{
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _newsListBean = newsListBean;
        
        _newsLabel      = [[ASTextNode alloc] init];
        _newsLabel.attributedText = [_newsListBean newsAttributedStringWithFontSize:16];
        _newsLabel.maximumNumberOfLines = 3;
        [self addSubnode:_newsLabel];
        
        _userAvatarImageNode = [[ASNetworkImageNode alloc] init];
        _userAvatarImageNode.URL = [NSURL URLWithString:_newsListBean.cat.pic];
        [self addSubnode:_userAvatarImageNode];
        _userAvatarImageNode.imageModificationBlock = ^UIImage *(UIImage *image) {
            UIImage *modifiedImage;
            CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
            UIGraphicsBeginImageContextWithOptions(image.size, false, [[UIScreen mainScreen] scale]);
            [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:USER_IMAGE_HEIGHT] addClip];
            [image drawInRect:rect];
            modifiedImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return modifiedImage;
        };
        
        _userNameLabel      = [[ASTextNode alloc] init];
        _userNameLabel.attributedText = [_newsListBean usernameAttributedStringWithFontSize:11];
        [self addSubnode:_userNameLabel];
        
        _photoImageNode = [[ASNetworkImageNode alloc] init];
        _photoImageNode.URL = [NSURL URLWithString:_newsListBean.pic];
        _photoImageNode.defaultImage = [UIImage imageNamed:@"placehoderImg_145x108_"];
        _photoImageNode.imageModificationBlock = ^UIImage *(UIImage *image) {
            UIImage *modifiedImage;
            CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
            UIGraphicsBeginImageContextWithOptions(image.size, false, [[UIScreen mainScreen] scale]);
            [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:4] addClip];
            [image drawInRect:rect];
            modifiedImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return modifiedImage;
        };
        
        [self addSubnode:_photoImageNode];
    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    ASLayoutSpec *layoutSpec = [self layoutOfOneSmallPicLeftWithConstrainedSize:constrainedSize];
    return layoutSpec;
}

// 100
- (ASLayoutSpec *)layoutOfOneSmallPicLeftWithConstrainedSize:(ASSizeRange)constrainedSize{
    _newsLabel.style.flexGrow = YES;
    _newsLabel.maximumNumberOfLines = 5;
    _newsLabel.truncationMode = NSLineBreakByTruncatingMiddle;
    
    ASStackLayoutSpec *userStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                           spacing:CONTENT_SPACE
                                                                    justifyContent:ASStackLayoutJustifyContentStart
                                                                        alignItems:ASStackLayoutAlignItemsCenter
                                                                          children:@[_userAvatarImageNode, _userNameLabel]];
    _userAvatarImageNode.style.width = _userAvatarImageNode.style.height = ASDimensionMake(USER_IMAGE_HEIGHT);
    
    
    ASStackLayoutSpec *leftVerticalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                                   spacing:6
                                                                            justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch
                                                                                  children:@[_newsLabel, userStack]];
    
    leftVerticalStack.style.preferredSize = CGSizeMake(ELScreenW / 5 * 3 - 24 - 6, ELScreenW / 5 * 2 / 30 * 23);
    
    _photoImageNode.style.preferredSize = CGSizeMake(ELScreenW / 5 * 2, ELScreenW / 5 * 2 / 30 * 23);
    
    ASInsetLayoutSpec *rightSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsZero child:_photoImageNode];
    
    ASStackLayoutSpec *horizontalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                                 spacing:6
                                                                          justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch
                                                                                children:@[leftVerticalStack, rightSpec]];
    
    ASInsetLayoutSpec *contentSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:InsetForContent child:horizontalStack];
    return contentSpec;
}

@end
