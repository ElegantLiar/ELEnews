//
//  ELCommunityFeedNode.m
//  ELENews
//
//  Created by EL on 2017/12/14.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELCommunityFeedNode.h"

@implementation ELCommunityFeedNode{
    ELCommunityFeedListBean     *_listBean;
    ASNetworkImageNode          *_userAvatarImageNode;
    ASTextNode                  *_userNameLabel;
    ASTextNode                  *_timeLabel;
    ASTextNode                  *_titleLabel;
    ASTextNode                  *_textLabel;
    NSMutableArray              *_threePhotosArray;
    ASButtonNode                *_orangeBtnNode;
    ASButtonNode                *_transhipmentBtnNode;
    ASButtonNode                *_commentBtnNode;
    ASImageNode                 *_topicImageNode;
    ASTextNode                  *_topicLabel;
    
}

- (instancetype)initWithCommunityFeedListBean:(ELCommunityFeedListBean *)listBean{
    if (self = [super init]) {
        _listBean = listBean;
        
        _userAvatarImageNode = [[ASNetworkImageNode alloc] init];
        _userAvatarImageNode.style.preferredSize = CGSizeMake(35, 35);
        _userAvatarImageNode.URL = [NSURL URLWithString:_listBean.author.avatar];
        [self addSubnode:_userAvatarImageNode];
        _userAvatarImageNode.imageModificationBlock = ^UIImage *(UIImage *image) {
            UIImage *modifiedImage;
            CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
            UIGraphicsBeginImageContextWithOptions(image.size, false, [[UIScreen mainScreen] scale]);
            [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:35] addClip];
            [image drawInRect:rect];
            modifiedImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return modifiedImage;
        };
        
        _userNameLabel      = [[ASTextNode alloc] init];
        _userNameLabel.attributedText = [_listBean usernameAttributedStringWithFontSize:16];
        _userNameLabel.maximumNumberOfLines = 1;
        [self addSubnode:_userNameLabel];
        
        _timeLabel      = [[ASTextNode alloc] init];
        _timeLabel.attributedText = [_listBean timeAttributedStringWithFontSize:11];
        _timeLabel.maximumNumberOfLines = 1;
        [self addSubnode:_timeLabel];
        
        _titleLabel      = [[ASTextNode alloc] init];
        _titleLabel.attributedText = [_listBean titleAttributedStringWithFontSize:20];
        _titleLabel.maximumNumberOfLines = 0;
        [self addSubnode:_titleLabel];
        
        _textLabel      = [[ASTextNode alloc] init];
        _textLabel.attributedText = [_listBean textAttributedStringWithFontSize:13];
        _textLabel.maximumNumberOfLines = 0;
        [self addSubnode:_textLabel];
        
        _threePhotosArray = @[].mutableCopy;
        for (NSInteger i = 0; i < 3; i++) {
            ASNetworkImageNode *photoImageNode = [[ASNetworkImageNode alloc] init];
            CGFloat width = (ELScreenW - 40) / 3;
            photoImageNode.style.preferredSize = CGSizeMake(width, width);
            NSString *url = [_listBean.img safeObjectAtIndex:i];
            photoImageNode.URL = [NSURL URLWithString:url];
            photoImageNode.imageModificationBlock = ^UIImage *(UIImage *image) {
                UIImage *modifiedImage;
                CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
                UIGraphicsBeginImageContextWithOptions(image.size, false, [[UIScreen mainScreen] scale]);
                [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:4] addClip];
                [image drawInRect:rect];
                modifiedImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                return modifiedImage;
            };
            [self addSubnode:photoImageNode];
            [_threePhotosArray safeAddObject:photoImageNode];
        }

        
        _orangeBtnNode = [[ASButtonNode alloc] init];
        [self addSubnode:_orangeBtnNode];
        
        _transhipmentBtnNode = [[ASButtonNode alloc] init];
        [self addSubnode:_transhipmentBtnNode];
        
        _commentBtnNode = [[ASButtonNode alloc] init];
        [self addSubnode:_commentBtnNode];
        
        _topicImageNode = [[ASImageNode alloc] init];
        [self addSubnode:_topicImageNode];
        
        _topicLabel      = [[ASTextNode alloc] init];
//        _userNameLabel.attributedText = [_newsListBean newsAttributedStringWithFontSize:16];
        _topicLabel.maximumNumberOfLines = 1;
        [self addSubnode:_topicLabel];
        
    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    ASStackLayoutSpec *userVerticalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                                   spacing:3
                                                                            justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart
                                                                                  children:@[_userNameLabel, _timeLabel]];
    
    ASStackLayoutSpec *headerHorizontalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                                       spacing:5
                                                                                justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch
                                                                                      children:@[_userAvatarImageNode, userVerticalStack]];
    
    ASStackLayoutSpec *photosHorizontalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                                       spacing:10
                                                                                justifyContent:ASStackLayoutJustifyContentStart
                                                                                    alignItems:ASStackLayoutAlignItemsCenter
                                                                                      children:_threePhotosArray];
    
    ASStackLayoutSpec *contentVerticalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                                      spacing:18
                                                                               justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart
                                                                                     children:@[headerHorizontalStack, _titleLabel, _textLabel, photosHorizontalStack]];
    
    ASInsetLayoutSpec *contentInsetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(6, 10, 6, 10) child:contentVerticalStack];
    
    return contentInsetSpec;
}

@end
