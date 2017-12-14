//
//  ELGIFFeedNode.m
//  ELENews
//
//  Created by EL on 2017/12/13.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELGIFFeedNode.h"

#define USER_IMAGE_HEIGHT       13
#define CONTENT_SPACE           6
#define InsetForContent UIEdgeInsetsMake(CONTENT_SPACE, CONTENT_SPACE * 2, CONTENT_SPACE, CONTENT_SPACE * 2)
@interface ELGIFFeedNode()<ASNetworkImageNodeDelegate>

@end

@implementation ELGIFFeedNode{
    ELGIFListBean       *_gifListBean;
    ASTextNode          *_titleLabel;
    ASNetworkImageNode  *_photoImageNode;
    ASNetworkImageNode  *_userAvatarImageNode;
    ASTextNode          *_userNameLabel;
    UIImage             *_placeHolderImage;
}

- (instancetype)initWithGIFListBean:(ELGIFListBean *)gifListBean{
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _gifListBean = gifListBean;
        
        _titleLabel = [[ASTextNode alloc] init];
        _titleLabel.maximumNumberOfLines = 0;
        _titleLabel.attributedText = [_gifListBean titleAttributedStringWithFontSize:16];
        [self addSubnode:_titleLabel];
        
        _userAvatarImageNode = [[ASNetworkImageNode alloc] init];
        _userAvatarImageNode.URL = [NSURL URLWithString:_gifListBean.author.pic];
        _userAvatarImageNode.delegate = self;
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
        _userNameLabel.attributedText = [_gifListBean usernameAttributedStringWithFontSize:11];
        [self addSubnode:_userNameLabel];
        
        _photoImageNode = [[ASNetworkImageNode alloc] init];
        _photoImageNode.URL = [NSURL URLWithString:_gifListBean.gif.thumb];
        _photoImageNode.layerBacked = YES;
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
    ASStackLayoutSpec *userStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                           spacing:CONTENT_SPACE
                                                                    justifyContent:ASStackLayoutJustifyContentStart
                                                                        alignItems:ASStackLayoutAlignItemsCenter
                                                                          children:@[_userAvatarImageNode, _userNameLabel]];
    _userAvatarImageNode.style.width = _userAvatarImageNode.style.height = ASDimensionMake(USER_IMAGE_HEIGHT);
    
    _titleLabel.style.flexGrow = YES;
    _titleLabel.style.width = ASDimensionMake(ELScreenW - 20);
    
    _photoImageNode.style.preferredSize = CGSizeMake(ELScreenW - 20, (ELScreenW - 20) / _gifListBean.gif.width * _gifListBean.gif.height);
    ASStackLayoutSpec *verticalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                                   spacing:6
                                                                            justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch
                                                                                  children:@[_titleLabel, _photoImageNode, userStack]];
    ASInsetLayoutSpec *contentInsetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10) child:verticalStack];
    return contentInsetSpec;
}

- (void)imageNode:(ASNetworkImageNode *)imageNode didLoadImage:(UIImage *)image{
    _placeHolderImage = image;
}

@end
