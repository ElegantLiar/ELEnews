//
//  NSArray+Safe.h
//  ECalendar-Pro
//
//  Created by suishen.mobi on 14-8-14.
//  Copyright (c) 2014年 etouch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Safe)

#pragma mark 读取

/**
 *  安全获取一条数据
 *
 *  @param index 数组元素的下标
 *
 *  @return 如果成功获取数据，就返回这条数据，否则就返回nil
 */
- (id)safeObjectAtIndex:(NSUInteger)index;

@end


