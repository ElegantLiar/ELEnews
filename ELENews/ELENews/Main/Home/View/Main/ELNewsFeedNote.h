//
//  ELNewsFeedNote.h
//  ELENews
//
//  Created by EL on 2017/12/12.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "ELNewsListBean.h"

@interface ELNewsFeedNote : ASCellNode

- (instancetype)initWithNewsListBean:(ELNewsListBean *)newsListBean;

@end
