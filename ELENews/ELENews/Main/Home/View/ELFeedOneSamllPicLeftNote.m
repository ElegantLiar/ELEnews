//
//  ELFeedOneSamllPicLeftNote.m
//  ELENews
//
//  Created by EL on 2017/12/8.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELFeedOneSamllPicLeftNote.h"

#define HEADER_HEIGHT           50
#define USER_IMAGE_HEIGHT       30
#define HORIZONTAL_BUFFER       10
#define VERTICAL_BUFFER         5
#define FONT_SIZE               14

#define InsetForAvatar UIEdgeInsetsMake(HORIZONTAL_BUFFER, 0, HORIZONTAL_BUFFER, HORIZONTAL_BUFFER)
#define InsetForContent UIEdgeInsetsMake(HORIZONTAL_BUFFER, HORIZONTAL_BUFFER, HORIZONTAL_BUFFER, HORIZONTAL_BUFFER)
#define InsetForHeader UIEdgeInsetsMake(0, HORIZONTAL_BUFFER, 0, HORIZONTAL_BUFFER)
#define InsetForFooter UIEdgeInsetsMake(VERTICAL_BUFFER, HORIZONTAL_BUFFER, VERTICAL_BUFFER, HORIZONTAL_BUFFER)

@implementation ELFeedOneSamllPicLeftNote{
    ASNetworkImageNode  *_userAvatarImageNode;
    ASNetworkImageNode  *_photoImageNode;
    ASTextNode          *_userNameLabel;
    ASTextNode          *_newsLabel;
    ELFeedBean          *_feedBean;
    
    ASTextNode          *_testLabel;

}

- (instancetype)initWithFeedBean:(ELFeedBean *)feedBean{
    if (self = [super init]) {
        _feedBean = feedBean;
        
        _newsLabel      = [[ASTextNode alloc] init];
        _newsLabel.attributedText = [_feedBean newsAttributedStringWithFontSize:15];
        _newsLabel.maximumNumberOfLines = 3;
        [self addSubnode:_newsLabel];
        
        _userAvatarImageNode = [[ASNetworkImageNode alloc] init];
        _userAvatarImageNode.URL = [NSURL URLWithString:_feedBean.cat.pic];
        [self addSubnode:_userAvatarImageNode];

        _userNameLabel      = [[ASTextNode alloc] init];
        _userNameLabel.attributedText = [_feedBean usernameAttributedStringWithFontSize:13];
        [self addSubnode:_userNameLabel];

        _photoImageNode = [[ASNetworkImageNode alloc] init];
        _photoImageNode.URL = [NSURL URLWithString:_feedBean.pic];
        [self addSubnode:_photoImageNode];

    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    _newsLabel.style.flexGrow = YES;
    _newsLabel.maximumNumberOfLines = 5;
    _newsLabel.truncationMode = NSLineBreakByTruncatingMiddle;
    
    ASStackLayoutSpec *userStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                           spacing:6
                                                                    justifyContent:ASStackLayoutJustifyContentStart
                                                                        alignItems:ASStackLayoutAlignItemsEnd
                                                                          children:@[_userAvatarImageNode, _userNameLabel]];
    _userAvatarImageNode.style.width = _userAvatarImageNode.style.height = ASDimensionMake(30);

    
    ASStackLayoutSpec *leftVerticalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                                   spacing:6
                                                                            justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch
                                                                                  children:@[_newsLabel, userStack]];

    leftVerticalStack.style.flexShrink = YES;

    _photoImageNode.style.width = _photoImageNode.style.height = ASDimensionMake(180);
    ASInsetLayoutSpec *rightSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(6, 6, 6, 6) child:_photoImageNode];

    ASStackLayoutSpec *horizontalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                                 spacing:0
                                                                          justifyContent:ASStackLayoutJustifyContentEnd alignItems:ASStackLayoutAlignItemsStretch
                                                                                children:@[leftVerticalStack, rightSpec]];
    
    ASInsetLayoutSpec *contentSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(6, 6, 6, 6) child:horizontalStack];

    
    return contentSpec;
}

@end
