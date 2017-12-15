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
    NSMutableArray              *_commentsArray;
}

- (instancetype)initWithCommunityFeedListBean:(ELCommunityFeedListBean *)listBean{
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

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
        if (_listBean.img.count > 0) {
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
        }
        
        _orangeBtnNode = [[ASButtonNode alloc] init];
        [_orangeBtnNode setImage:[UIImage imageNamed:@"community_smallJuzi_20x20_"] forState:UIControlStateNormal];
        _orangeBtnNode.style.preferredSize = CGSizeMake(20, 20);
        [self addSubnode:_orangeBtnNode];
        
        _transhipmentBtnNode = [[ASButtonNode alloc] init];
        [_transhipmentBtnNode setImage:[UIImage imageNamed:@"community_share_20x20_"] forState:UIControlStateNormal];
        _transhipmentBtnNode.style.preferredSize = CGSizeMake(20, 20);
        [self addSubnode:_transhipmentBtnNode];
        
        _commentBtnNode = [[ASButtonNode alloc] init];
        [_commentBtnNode setImage:[UIImage imageNamed:@"community_comment_20x20_"] forState:UIControlStateNormal];
        _commentBtnNode.style.preferredSize = CGSizeMake(20, 20);
        [self addSubnode:_commentBtnNode];
        
        _topicImageNode = [[ASImageNode alloc] init];
        _topicImageNode.image = [UIImage imageNamed:@"community_topicName_20x20_"];
        _topicImageNode.style.preferredSize = CGSizeMake(20, 20);
        [self addSubnode:_topicImageNode];
        
        _topicLabel      = [[ASTextNode alloc] init];
        _topicLabel.attributedText = [_listBean topicAttributedStringWithFontSize:12];
        _topicLabel.maximumNumberOfLines = 1;
        [self addSubnode:_topicLabel];
        
        if (_listBean.comments.count > 0) {
            _commentsArray = @[].mutableCopy;
        }
        
        for (NSInteger i = 0; i < _listBean.comments.count; i++) {
            ASTextNode *commetLabel = [[ASTextNode alloc] init];
            ELCommunityCommentListBean *commentListBean = [_listBean.comments safeObjectAtIndex:i];
            NSAttributedString *commentMan = [NSAttributedString attributedStringWithString:[NSString stringWithFormat:@"%@:", commentListBean.author.name]
                                                                                    fontSize:13
                                                                                       color:[UIColor hexChangeFloat:@"999999"]
                                                                              firstWordColor:nil];
            NSAttributedString *comment = [NSAttributedString attributedStringWithString:commentListBean.content
                                                                                fontSize:13
                                                                                   color:[UIColor hexChangeFloat:@"333333"]
                                                                          firstWordColor:nil];
            NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] init];
            [attri appendAttributedString:commentMan];
            [attri appendAttributedString:comment];
            commetLabel.attributedText = attri;
            [self addSubnode:commetLabel];
            [_commentsArray safeAddObject:commetLabel];
        }
        
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
    
   
    
    ASStackLayoutSpec *actionHorizontalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                                       spacing:25
                                                                                justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter
                                                                                      children:@[_orangeBtnNode, _transhipmentBtnNode, _commentBtnNode]];
   
    ASLayoutSpec *blankSpec = [[ASLayoutSpec alloc] init];
    blankSpec.style.flexGrow = 1.0;
    blankSpec.style.flexShrink = 1.0;
    
    ASStackLayoutSpec *topicHorizontalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                                       spacing:4
                                                                                justifyContent:ASStackLayoutJustifyContentEnd alignItems:ASStackLayoutAlignItemsCenter
                                                                                      children:@[_topicImageNode, _topicLabel]];
    
    ASStackLayoutSpec *belowPhotoHorizontalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                                           spacing:0
                                                                                    justifyContent:ASStackLayoutJustifyContentSpaceBetween alignItems:ASStackLayoutAlignItemsCenter
                                                                                          children:@[actionHorizontalStack, blankSpec, topicHorizontalStack]];
    
    ASStackLayoutSpec *commentsVerticalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                                       spacing:10
                                                                                justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch
                                                                                      children:_commentsArray];
    
    NSArray *contentStackChildren = _listBean.img.count > 0 ?
    @[headerHorizontalStack, _titleLabel, _textLabel, photosHorizontalStack, belowPhotoHorizontalStack, commentsVerticalStack] :
    @[headerHorizontalStack, _titleLabel, _textLabel, belowPhotoHorizontalStack, commentsVerticalStack];
    ASStackLayoutSpec *contentVerticalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                                      spacing:18
                                                                               justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch
                                                                                     children:contentStackChildren];
    
    ASInsetLayoutSpec *contentInsetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(6, 10, 6, 10) child:contentVerticalStack];
    
    return contentInsetSpec;
}

@end
