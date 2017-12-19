//
//  ELDisplayViewScrollDelegate.h
//  ELENews
//
//  Created by EL on 2017/12/19.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ELDisplayViewScrollDelegate <NSObject>

- (void)elScrollViewHasScrolledWithContentOffset:(CGPoint)contentOffset;

@end
