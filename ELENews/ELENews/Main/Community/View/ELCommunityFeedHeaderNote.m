//
//  ELCommunityFeedHeaderNote.m
//  ELENews
//
//  Created by EL on 2017/12/15.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELCommunityFeedHeaderNote.h"

@implementation ELCommunityFeedHeaderNote{
    ASImageNode         *_headerImageNode;
    ASTextNode          *_titleNode;
    ASTextNode          *_hasMoreTextNode;
    ASImageNode         *_arrowImageNode;
}

- (instancetype)initWithImageName:(NSString *)imageName Title:(NSString *)title hasMore:(BOOL)hasMore{
    if (self = [super init]) {
        _headerImageNode = [[ASImageNode alloc] init];
        _headerImageNode.image = [UIImage imageNamed:imageName];
        _headerImageNode.style.preferredSize = CGSizeMake(14, 14);
        [self addSubnode:_headerImageNode];
        
        _titleNode = [[ASTextNode alloc] init];
        _titleNode.attributedText = [NSAttributedString attributedStringWithString:title
                                                                          fontSize:13
                                                                             color:[UIColor hexChangeFloat:@"999999"]
                                                                    firstWordColor:nil];
        [self addSubnode:_titleNode];
        
        _hasMoreTextNode = [[ASTextNode alloc] init];
        _hasMoreTextNode.attributedText = [NSAttributedString attributedStringWithString:@"MORE"
                                                                          fontSize:13
                                                                             color:[UIColor hexChangeFloat:@"999999"]
                                                                    firstWordColor:nil];
        [self addSubnode:_hasMoreTextNode];
        
        _arrowImageNode = [[ASImageNode alloc] init];
        _arrowImageNode.image = [UIImage imageNamed:@"video_arrow_7x11_"];
        _arrowImageNode.style.preferredSize = CGSizeMake(7, 11);
        [self addSubnode:_arrowImageNode];
    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    ASStackLayoutSpec *leftHorizontalSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                                    spacing:8
                                                                             justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter
                                                                                   children:@[_headerImageNode, _titleNode]];

    ASStackLayoutSpec *rightHorizontalSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                                    spacing:2
                                                                             justifyContent:ASStackLayoutJustifyContentEnd alignItems:ASStackLayoutAlignItemsCenter
                                                                                   children:@[_hasMoreTextNode, _arrowImageNode]];
    
    ASLayoutSpec *blankSpec = [[ASLayoutSpec alloc] init];
    blankSpec.style.flexGrow = YES;
    blankSpec.style.flexShrink = YES;
    
    ASStackLayoutSpec *contentHorizontalSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                                       spacing:10
                                                                                justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch
                                                                                      children:@[leftHorizontalSpec, blankSpec, rightHorizontalSpec]];
    
    ASInsetLayoutSpec *contentInsetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10) child:contentHorizontalSpec];
    return contentInsetSpec;
}

@end
