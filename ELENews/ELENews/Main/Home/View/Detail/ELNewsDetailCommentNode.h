//
//  ELNewsDetailCommentNode.h
//  ELENews
//
//  Created by EL on 2017/12/26.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "ELNewsDetailInfoPageBean.h"

@interface ELNewsDetailCommentNode : ASCellNode

- (instancetype)initWithCommentContentBean:(ELNewsDetailCommentContentBean *)contentBean;

@end

@interface ELNewsDetailCommentTitleNode : ASCellNode

- (instancetype)initWithTitle:(NSString *)title;

@end
