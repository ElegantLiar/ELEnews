//
//  ELFlashFeedNote.m
//  ELENews
//
//  Created by EL on 2017/12/12.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELFlashFeedNote.h"

@implementation ELFlashFeedNote{
    ELFlashBean         *_flashBean;
    ASDisplayNode       *_timeLineTopNode;
    ASDisplayNode       *_timeLineBtmNode;
    ASDisplayNode       *_timeLineLeftPaddingNode;

    ASDisplayNode       *_timeCircleNode;
    ASTextNode          *_timeLabel;
    ASTextNode          *_titleLabel;
    ASTextNode          *_textLabel;
    ASNetworkImageNode  *_photoImageNode;
    NSMutableArray      *_threePhotosArray;
    
    ASButtonNode        *_expandBtnNode;

}

- (instancetype)initWithFlashBean:(ELFlashBean *)flashBean{
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _flashBean = flashBean;
        
        _timeLineTopNode = [[ASDisplayNode alloc] init];
        _timeLineTopNode.backgroundColor = [UIColor hexChangeFloat:@"F6F6F6"];
        [self addSubnode:_timeLineTopNode];
        
        _timeLineBtmNode = [[ASDisplayNode alloc] init];
        _timeLineBtmNode.backgroundColor = [UIColor hexChangeFloat:@"F6F6F6"];
        [self addSubnode:_timeLineBtmNode];
        
        _timeLineLeftPaddingNode = [[ASDisplayNode alloc] init];
        _timeLineLeftPaddingNode.backgroundColor = ELClearColor;
        [self addSubnode:_timeLineLeftPaddingNode];
        
        _timeCircleNode = [[ASDisplayNode alloc] init];
        _timeCircleNode.backgroundColor = ELWhiteColor;
        _timeCircleNode.style.preferredSize = CGSizeMake(6, 6);
        _timeCircleNode.cornerRadius = 3;
        _timeCircleNode.borderWidth = 1.5;
        _timeCircleNode.borderColor = ELLightGrayColor.CGColor;
        [self addSubnode:_timeCircleNode];
        
        _timeLabel      = [[ASTextNode alloc] init];
        _timeLabel.attributedText = [_flashBean timeAttributedStringWithFontSize:11];
        _timeLabel.maximumNumberOfLines = 1;
        [self addSubnode:_timeLabel];

        _titleLabel      = [[ASTextNode alloc] init];
        _titleLabel.attributedText = [_flashBean titleAttributedStringWithFontSize:16];
        _titleLabel.maximumNumberOfLines = 3;
        [self addSubnode:_titleLabel];
        
        _textLabel      = [[ASTextNode alloc] init];
        _textLabel.attributedText = [_flashBean textAttributedStringWithFontSize:15];
        _textLabel.maximumNumberOfLines = 3;
        [self addSubnode:_textLabel];
        
        _expandBtnNode = [[ASButtonNode alloc] init];
        [_expandBtnNode setImageAlignment:ASButtonNodeImageAlignmentBeginning];
        [_expandBtnNode setImage:[UIImage imageNamed:@"person_arrow_9x5_"] forState:UIControlStateNormal];
        [_expandBtnNode setImage:[UIImage imageNamed:@"person_arrow_up_9x5_"] forState:UIControlStateSelected];
        [_expandBtnNode setAttributedTitle:[NSAttributedString attributedStringWithString:@"展开"
                                                                                 fontSize:11
                                                                                    color:[UIColor hexChangeFloat:@"666666"]
                                                                           firstWordColor:nil] forState:UIControlStateNormal];
        [_expandBtnNode setAttributedTitle:[NSAttributedString attributedStringWithString:@"收起"
                                                                                 fontSize:11
                                                                                    color:[UIColor hexChangeFloat:@"666666"]
                                                                           firstWordColor:nil] forState:UIControlStateSelected];
        [_expandBtnNode setContentSpacing:2];
        [_expandBtnNode addTarget:self action:@selector(expandBtnClicked:) forControlEvents:ASControlNodeEventTouchUpInside];
        
        [self addSubnode:_expandBtnNode];

        if (_flashBean.imgs.count >= 3) {
            _threePhotosArray = @[].mutableCopy;
            for (NSInteger i = 0; i < 3; i++) {
                ASNetworkImageNode *photoImageNode = [[ASNetworkImageNode alloc] init];
                CGFloat width = (ELScreenW - 80 - 10) / 3;
                photoImageNode.style.preferredSize = CGSizeMake(width, width / 19 * 14);
                ELFlashImageBean *imageBean = [_flashBean.imgs safeObjectAtIndex:i];
                photoImageNode.URL = [NSURL URLWithString:imageBean.thumb];
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
        } else {
            _photoImageNode = [[ASNetworkImageNode alloc] init];
            ELFlashImageBean *imageBean = [_flashBean.imgs safeObjectAtIndex:0];
            _photoImageNode.URL = [NSURL URLWithString:imageBean.thumb];
            _photoImageNode.style.preferredSize = CGSizeMake(197, 149);
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
    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    _timeLineTopNode.style.spacingBefore = 0;
    _timeLineTopNode.style.width = ASDimensionMakeWithPoints(2);
    _timeLineTopNode.style.height = ASDimensionMakeWithPoints(11.5);

    _timeLineBtmNode.style.flexGrow = YES;
    _timeLineBtmNode.style.flexShrink = YES;
    _timeLineBtmNode.style.spacingBefore = 0;
    _timeLineBtmNode.style.width = ASDimensionMake(1);
    
    _timeLineLeftPaddingNode.style.width = ASDimensionMakeWithPoints(5);

    _titleLabel.style.flexGrow = YES;
    _titleLabel.truncationMode = NSLineBreakByTruncatingMiddle;
    
    _textLabel.style.flexGrow = YES;
    _textLabel.truncationMode = NSLineBreakByTruncatingMiddle;
    
    ASStackLayoutSpec *timeLineVerticalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                                       spacing:0
                                                                                justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter
                                                                                      children:@[_timeLineTopNode, _timeCircleNode, _timeLineBtmNode]];
    _timeLabel.style.spacingBefore = 8;
    ASStackLayoutSpec *timeLabelVerticalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                                       spacing:0
                                                                                justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter
                                                                                      children:@[_timeLabel]];
    
    ASStackLayoutSpec *timeHorizontalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                                     spacing:5
                                                                              justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch
                                                                                    children:@[_timeLineLeftPaddingNode, timeLineVerticalStack, timeLabelVerticalStack]];
    
    
    timeHorizontalStack.style.width = ASDimensionMakeWithPoints(60.0);

    ASStackLayoutSpec *photosHorizontalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                                       spacing:5
                                                                                justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch
                                                                                      children:_flashBean.imgs.count >= 3 ? _threePhotosArray : @[_photoImageNode]];
    NSArray *verticalChildren = _flashBean.imgs.count > 0 ? @[_titleLabel, _textLabel, _expandBtnNode, photosHorizontalStack] : @[_titleLabel, _textLabel, _expandBtnNode];
    ASStackLayoutSpec *contentVerticalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                                       spacing:10
                                                                                justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart
                                                                                     children:verticalChildren];
    contentVerticalStack.style.width = ASDimensionMakeWithPoints(ELScreenW - 70 - 6);
    
    ASInsetLayoutSpec *rightContentInsetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 0, 10, 6) child:contentVerticalStack];
    
    ASStackLayoutSpec *allHorizontalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                                       spacing:10
                                                                                justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch
                                                                                      children:@[timeHorizontalStack, rightContentInsetSpec]];
    return allHorizontalStack;
}

- (void)expandBtnClicked:(ASButtonNode *)btnNode{
    btnNode.selected ^= 1;
    if (btnNode.selected) {
        _textLabel.maximumNumberOfLines = 0;
    } else {
        _textLabel.maximumNumberOfLines = 3;
    }
    [self setNeedsLayout];
}
@end
