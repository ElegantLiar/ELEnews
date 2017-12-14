//
//  ELGIFFeedNode.h
//  ELENews
//
//  Created by EL on 2017/12/13.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "ELGIFListBean.h"

@interface ELGIFFeedNode : ASCellNode

- (instancetype)initWithGIFListBean:(ELGIFListBean *)gifListBean;

@end
