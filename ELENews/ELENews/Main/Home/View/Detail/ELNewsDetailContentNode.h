//
//  ELNewsDetailContentNode.h
//  ELENews
//
//  Created by EL on 2017/12/21.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "ELNewsDetailPageBean.h"

@interface ELNewsDetailContentNode : ASCellNode

- (instancetype)initWithNewsDetailParagraphBean:(ELNewsDetailParagraphBean *)bean
                                 detailPageBean:(ELNewsDetailPageBean *)pageBean;

@end
