//
//  ELNewsThreePicFeedNote.m
//  ELENews
//
//  Created by EL on 2017/12/21.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELNewsThreePicFeedNote.h"

#define USER_IMAGE_HEIGHT       13
#define CONTENT_SPACE           6

#define InsetForContent UIEdgeInsetsMake(CONTENT_SPACE, CONTENT_SPACE * 2, CONTENT_SPACE, CONTENT_SPACE * 2)

#define HEADER_HEIGHT           50

@implementation ELNewsThreePicFeedNote{
    ASNetworkImageNode  *_userAvatarImageNode;
    ASTextNode          *_userNameLabel;
    ASTextNode          *_newsLabel;
    ELNewsListBean      *_newsListBean;
    NSMutableArray      *_threePhotosArray;
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
        
        if (_newsListBean.display == 102 && _newsListBean.gallary.count >= 3) {
            _threePhotosArray = @[].mutableCopy;
            for (NSInteger i = 0; i < 3; i++) {
                ASNetworkImageNode *photoImageNode = [[ASNetworkImageNode alloc] init];
                NSDictionary *dic = [_newsListBean.gallary safeObjectAtIndex:i];
                photoImageNode.URL = [NSURL URLWithString:[dic objectForKey:@"pic"]];
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
        }
    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    ASLayoutSpec *layoutSpec = [self layoutOfThreeSmallPicWithConstrainedSize:constrainedSize];
    return layoutSpec;
}

// 102
- (ASLayoutSpec *)layoutOfThreeSmallPicWithConstrainedSize:(ASSizeRange)constrainedSize{
    ASStackLayoutSpec *userStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                           spacing:CONTENT_SPACE
                                                                    justifyContent:ASStackLayoutJustifyContentStart
                                                                        alignItems:ASStackLayoutAlignItemsCenter
                                                                          children:@[_userAvatarImageNode, _userNameLabel]];
    _userAvatarImageNode.style.width = _userAvatarImageNode.style.height = ASDimensionMake(USER_IMAGE_HEIGHT);
    
    _newsLabel.style.flexGrow = YES;
    _newsLabel.maximumNumberOfLines = 5;
    _newsLabel.truncationMode = NSLineBreakByTruncatingMiddle;
    
    for (ASNetworkImageNode *photoImageNode in _threePhotosArray) {
        CGFloat width = (ELScreenW - 5 * CONTENT_SPACE) / 3;
        photoImageNode.style.preferredSize = CGSizeMake(width, width);
    }
    
    ASStackLayoutSpec *horizontalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                                 spacing:CONTENT_SPACE
                                                                          justifyContent:ASStackLayoutJustifyContentStart
                                                                              alignItems:ASStackLayoutAlignItemsCenter
                                                                                children:_threePhotosArray];
    
    ASStackLayoutSpec *verticalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                               spacing:CONTENT_SPACE
                                                                        justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch
                                                                              children:@[_newsLabel, horizontalStack, userStack]];
    
    ASInsetLayoutSpec *contentSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:InsetForContent child:verticalStack];
    
    return contentSpec;
}


@end
