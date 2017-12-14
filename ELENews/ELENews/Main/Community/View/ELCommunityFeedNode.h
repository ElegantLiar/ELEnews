//
//  ELCommunityFeedNode.h
//  ELENews
//
//  Created by EL on 2017/12/14.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "ELCommunityFeedListBean.h"

@interface ELCommunityFeedNode : ASCellNode

- (instancetype)initWithCommunityFeedListBean:(ELCommunityFeedListBean *)listBean;

@end
