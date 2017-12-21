//
//  ELNewsDetailContentNode.m
//  ELENews
//
//  Created by EL on 2017/12/21.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELNewsDetailContentNode.h"

@implementation ELNewsDetailContentNode{
    ASTextNode                  *_textLabel;
    ELNewsDetailParagraphBean   *_paragraphBean;
    ASNetworkImageNode          *_imageNode;
}

- (instancetype)initWithNewsDetailParagraphBean:(ELNewsDetailParagraphBean *)bean detailPageBean:(ELNewsDetailPageBean *)pageBean{
    if (self = [super init]) {
        _paragraphBean = bean;
        
        if (_paragraphBean.type == ELNewsDetailParagraphTypeText) {
            _textLabel = [[ASTextNode alloc] init];
            _textLabel.attributedText = [NSAttributedString attributedStringWithString:_paragraphBean.showText
                                                                              fontSize:_paragraphBean.fontSize
                                                                                 color:[UIColor hexChangeFloat:@"333333"]
                                                                              lineSpac:13];
            _textLabel.maximumNumberOfLines = 0;
            _textLabel.style.width = ASDimensionMake(ELScreenW - 20);
            [self addSubnode:_textLabel];
        } else if (_paragraphBean.type == ELNewsDetailParagraphTypeImage) {
            ELFlashImageBean *imageBean = [pageBean.resources.IMG safeObjectAtIndex:_paragraphBean.imageIndex];
            _imageNode = [[ASNetworkImageNode alloc] init];
            _imageNode.URL = [NSURL URLWithString:imageBean.src];
            [self addSubnode:_imageNode];
//            _imageNode.style.width = ASDimensionMake(ELScreenW - 20);
            _imageNode.contentMode = UIViewContentModeScaleAspectFill;
            _imageNode.style.preferredSize = CGSizeMake(imageBean.showWidth, imageBean.showHeight);
        }
    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
//    ASRatioLayoutSpec *imageRatioSpec = nil;
//    if (_paragraphBean.type == ELNewsDetailParagraphTypeImage) {
//
//        imageRatioSpec = [ASRatioLayoutSpec ratioLayoutSpecWithRatio:_ratio child:_imageNode];
//    }
    
    ASStackLayoutSpec *contentHorizontalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                                        spacing:0
                                                                                 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart
                                                                                       children:@[_paragraphBean.type == ELNewsDetailParagraphTypeText ? _textLabel : _imageNode]];
    
    ASInsetLayoutSpec *contentInsetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10)
                                                                                 child:contentHorizontalStack];
    return contentInsetSpec;
}


@end
