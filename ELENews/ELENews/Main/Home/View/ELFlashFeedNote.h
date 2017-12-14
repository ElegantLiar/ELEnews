//
//  ELFlashFeedNote.h
//  ELENews
//
//  Created by EL on 2017/12/12.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "ELFlashListBean.h"

@interface ELFlashFeedNote : ASCellNode

- (instancetype)initWithFlashListBean:(ELFlashListBean *)flashListBean;

@end
