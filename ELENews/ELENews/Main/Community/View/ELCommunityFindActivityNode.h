//
//  ELCommunityFindActivityNode.h
//  ELENews
//
//  Created by EL on 2017/12/19.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "ELCommunityActivityBean.h"

@interface ELCommunityFindActivityNode : ASCellNode

- (instancetype)initWithCommunityActivityBean:(ELCommunityActivityBean *)bean;

@end
