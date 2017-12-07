//
//  NSMutableArray+Safe.h
//  testArray
//
//  Created by suishen.mobi on 13-12-26.
//  Copyright (c) 2013年 suishen.mobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Safe)

#pragma mark 增加

/**
 *  安全向数组里加入一条数据，不管这条数据是否为nil
 *
 *  @param anObject 一条需要增加的数据
 *
 *  @return 返回是否增加成功  YES:成功  NO:失败
 */
- (BOOL)safeAddObject:(id)anObject;

/**
 *  安全向数组里加入一条数据，不管这条数据是否为nil
 *
 *  @param anObject 一条需要增加的数据
 *
 *  @return 返回是否增加成功  YES:成功  NO:失败
 */
- (BOOL)safeInsertObject:(id)anObject atIndex:(NSUInteger)index;

#pragma mark 删除

/**
 *  安全从数组里删除一条数据
 *
 *  @param index 所删除数据的下标值
 *
 *  @return 是否删除成功  YES:成功  NO:失败
 */
- (BOOL)safeRemoveObjectAtIndex:(NSInteger)index;

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



