//
//  ELCommunityFindDayTopicNode.m
//  ELENews
//
//  Created by EL on 2017/12/18.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELCommunityFindDayTopicNode.h"
#import "ELCommunityTopicBean.h"

@implementation ELCommunityFindDayTopicNode{
    NSArray             *_topics;
    NSMutableArray      *_topicLabels;
    NSMutableArray      *_topicsSpecs;
    NSMutableArray      *_allHorizontalSpecs;
    NSMutableArray      *_allBtmLines;
    NSInteger           _horizonSpecNumbers;
}

- (instancetype)initWithCommunityWithTopics:(NSArray *)topics{
    if (self = [super init]) {
        _topics = topics;
        
        _topicLabels = @[].mutableCopy;
        _topicsSpecs = @[].mutableCopy;
        _allHorizontalSpecs = @[].mutableCopy;
        _allBtmLines = @[].mutableCopy;
        
        _horizonSpecNumbers = _topics.count % 2 == 0 ? _topics.count / 2 : _topics.count / 2 + 1;
        
        for (NSInteger i = 0; i < _topics.count; i++) {
            ELCommunityTopicBean *topicBean = [_topics safeObjectAtIndex:i];
            ASTextNode *topicNodeLabel = [[ASTextNode alloc] init];
            topicNodeLabel.attributedText = [topicBean findTopicNameAttributedStringWithFontSize:15];
            [self addSubnode:topicNodeLabel];
            [_topicLabels safeAddObject:topicNodeLabel];
        }
        
        for (NSInteger i = 0; i < _horizonSpecNumbers; i++) {
            ASDisplayNode *btmLineNode = [[ASDisplayNode alloc] init];
            btmLineNode.style.preferredSize = CGSizeMake(ELScreenW, 0.2);
            btmLineNode.backgroundColor = ELLineColor;
            [self addSubnode:btmLineNode];
            [_allBtmLines safeAddObject:btmLineNode];
        }
    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    for (NSInteger i = 0; i < _horizonSpecNumbers; i++) {
        ASTextNode *leftNode = [_topicLabels safeObjectAtIndex:i * 2];
        ASTextNode *rightNode = [_topicLabels safeObjectAtIndex:i * 2 + 1];
        
        ASInsetLayoutSpec *leftInsetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(5, 0, 5, 0) child:leftNode];
        ASInsetLayoutSpec *rightInsetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(5, 0, 5, 0) child:rightNode];

        ASDisplayNode *leftPaddingNode = [[ASDisplayNode alloc] init];
        leftPaddingNode.style.width = ASDimensionMake(10);
        ASStackLayoutSpec *leftNodeHorizontalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                                             spacing:0
                                                                                      justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter
                                                                                            children:@[leftPaddingNode, leftInsetSpec]];
        
        ASDisplayNode *rightPaddingNode = [[ASDisplayNode alloc] init];
        rightPaddingNode.style.width = ASDimensionMake(10);
        ASStackLayoutSpec *rightNodeHorizontalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                                             spacing:0
                                                                                      justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter
                                                                                            children:@[rightPaddingNode, rightInsetSpec]];
        
        leftNodeHorizontalStack.style.width = rightNodeHorizontalStack.style.width = ASDimensionMakeWithPoints(ELScreenW / 2);
        
        ASStackLayoutSpec *horizontalSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                                        spacing:0
                                                                                 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter
                                                                                       children:@[leftNodeHorizontalStack, rightNodeHorizontalStack]];
        horizontalSpec.style.height = ASDimensionMakeWithPoints(36);
        

        ASDisplayNode *btmLineNode = [_allBtmLines safeObjectAtIndex:i];
        
        ASStackLayoutSpec *eachVerticalSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                                      spacing:0
                                                                               justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch
                                                                                     children:@[horizontalSpec, btmLineNode]];
        
        [_allHorizontalSpecs safeAddObject:eachVerticalSpec];
    }
    
    ASStackLayoutSpec *contentVerticalSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                                     spacing:0
                                                                              justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart
                                                                                    children:_allHorizontalSpecs];
    return contentVerticalSpec;
}
@end
