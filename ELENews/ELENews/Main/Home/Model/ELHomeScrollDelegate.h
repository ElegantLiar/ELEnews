//
//  ELHomeScrollDelegate.h
//  ELENews
//
//  Created by EL on 2017/12/12.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ELHomeScrollDelegate <NSObject>

- (void)elHomeDidScrollWithContentOffset:(CGSize)contentOffset;

@end
