//
//  ELCommunityStarNode.m
//  ELENews
//
//  Created by EL on 2017/12/15.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELCommunityStarNode.h"
#import "ELCommunityStarBean.h"

@implementation ELCommunityStarNode{
    NSArray             *_starsArray;
    
    ASImageNode         *_descImageNode;
    ASNetworkImageNode  *_bigPicImageNode;
    ASNetworkImageNode  *_avatarImageNode;
    ASTextNode          *_starNameNode;
    ASImageNode         *_bottomImageNode;
    
    NSMutableArray      *_descImageNodes;
    NSMutableArray      *_bigPicImageNodes;
    NSMutableArray      *_avatarImageNodes;
    NSMutableArray      *_starNameNodes;
    NSMutableArray      *_bottomImageNodes;
    NSMutableArray      *_bgSpecs;

    CGFloat             _starNodeWidth;
    CGFloat             _starNodeHeight;
}

- (instancetype)initWithCommunityStarsArray:(NSArray *)starsArray{
    if (self = [super init]) {
        _starsArray = starsArray;
        
        _descImageNodes = @[].mutableCopy;
        _bigPicImageNodes = @[].mutableCopy;
        _avatarImageNodes = @[].mutableCopy;
        _starNameNodes = @[].mutableCopy;
        _bottomImageNodes = @[].mutableCopy;
        _bgSpecs = @[].mutableCopy;
        
        _starNodeWidth = (ELScreenW - 40) / 3;
        _starNodeHeight = (ELScreenW - 40) / 3 / 11 * 16;

        NSArray *bottomImageNames = @[
                                      @"community_stars_fastBottom_110x28_",
                                      @"community_stars_todayBottom_110x28_",
                                      @"community_stars_weekBottom_110x28_"
                                      ];
        
        NSArray *descImageNames = @[@"community_fast_40x11_",
                                    @"community_today_49x11_",
                                    @"community_week_49x11_"
                                    ];
        for (NSInteger i = 0; i < 3; i++) {
            ELCommunityStarBean *starBean = [_starsArray safeObjectAtIndex:i];
            
            ASNetworkImageNode *bigPicImageNode = [[ASNetworkImageNode alloc] init];
            bigPicImageNode.URL = [NSURL URLWithString:starBean.bgpic];
            [self addSubnode:bigPicImageNode];
            [_bigPicImageNodes safeAddObject:bigPicImageNode];
            bigPicImageNode.style.preferredSize = CGSizeMake(_starNodeWidth, _starNodeHeight / 2);
            
            ASNetworkImageNode *avatarImageNode = [[ASNetworkImageNode alloc] init];
            avatarImageNode.URL = [NSURL URLWithString:starBean.portrait];
            [self addSubnode:avatarImageNode];
            [_avatarImageNodes safeAddObject:avatarImageNode];
            avatarImageNode.style.preferredSize = CGSizeMake(30, 30);
            avatarImageNode.imageModificationBlock = ^UIImage *(UIImage *image) {
                UIImage *modifiedImage;
                CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
                UIGraphicsBeginImageContextWithOptions(image.size, false, [[UIScreen mainScreen] scale]);
                [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:30] addClip];
                [image drawInRect:rect];
                modifiedImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                return modifiedImage;
            };

            ASTextNode *starNameNode = [[ASTextNode alloc] init];
            starNameNode.attributedText = [starBean starNameAttributedStringWithFontSize:15];
            [self addSubnode:starNameNode];
            [_starNameNodes safeAddObject:starNameNode];

            ASImageNode *bottomImageNode = [[ASImageNode alloc] init];
            bottomImageNode.image = [UIImage imageNamed:[bottomImageNames safeObjectAtIndex:i]];
            [self addSubnode:bottomImageNode];
            [_bottomImageNodes safeAddObject:bottomImageNode];

            ASImageNode *descImageNode = [[ASImageNode alloc] init];
            descImageNode.image = [UIImage imageNamed:[descImageNames safeObjectAtIndex:i]];
            [self addSubnode:descImageNode];
            [_descImageNodes safeAddObject:descImageNode];

        }
    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    for (NSInteger i = 0; i < 3; i++) {
        
        ASStackLayoutSpec *bgStarVerticalSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                                        spacing:0
                                                                                 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter
                                                                                       children:@[[_bigPicImageNodes safeObjectAtIndex:i]]];
        bgStarVerticalSpec.style.preferredSize = CGSizeMake(_starNodeWidth, _starNodeHeight);
        

        ASLayoutSpec *descRightBlankSpec = [[ASLayoutSpec alloc] init];
        descRightBlankSpec.style.width = ASDimensionMake(5);
        
        ASStackLayoutSpec *descHorizontalSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                                        spacing:0
                                                                                 justifyContent:ASStackLayoutJustifyContentEnd alignItems:ASStackLayoutAlignItemsCenter
                                                                                       children:@[[_descImageNodes safeObjectAtIndex:i], descRightBlankSpec]];
        ASLayoutSpec *topBlankSpec = [[ASLayoutSpec alloc] init];
        topBlankSpec.style.height = ASDimensionMake(5);
        
        ASStackLayoutSpec *descVerticalSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                                      spacing:5
                                                                               justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStretch
                                                                                     children:@[topBlankSpec, descHorizontalSpec]];
        
        ASLayoutSpec *avatarTopBlankSpec = [[ASLayoutSpec alloc] init];
        descRightBlankSpec.style.height = ASDimensionMake(35);
        
        ASStackLayoutSpec *starNameVerticalSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                                        spacing:5
                                                                                 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter
                                                                                       children:@[avatarTopBlankSpec, [_avatarImageNodes safeObjectAtIndex:i], [_starNameNodes safeObjectAtIndex:i]]];
        
        ASStackLayoutSpec *fgStarVerticalSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                                        spacing:0
                                                                                 justifyContent:ASStackLayoutJustifyContentSpaceBetween alignItems:ASStackLayoutAlignItemsStretch
                                                                                       children:@[descVerticalSpec, starNameVerticalSpec, [_bottomImageNodes safeObjectAtIndex:i]]];
        fgStarVerticalSpec.style.preferredSize = CGSizeMake(_starNodeWidth, _starNodeHeight);
        
        ASBackgroundLayoutSpec *bgSpec = [ASBackgroundLayoutSpec backgroundLayoutSpecWithChild:fgStarVerticalSpec background:bgStarVerticalSpec];
        [_bgSpecs safeAddObject:bgSpec];
    }
    ASStackLayoutSpec *contentHorizontalStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                                        spacing:0
                                                                                 justifyContent:ASStackLayoutJustifyContentSpaceBetween alignItems:ASStackLayoutAlignItemsCenter
                                                                                       children:_bgSpecs];
    
    ASInsetLayoutSpec *contentInsetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10) child:contentHorizontalStack];
    
    return contentInsetSpec;
}

@end


