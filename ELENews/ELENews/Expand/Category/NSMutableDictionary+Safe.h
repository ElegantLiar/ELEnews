//
//  NSMutableDictionary+Safe.h
//  ECalendar-Pro
//
//  Created by suishen.mobi on 14-1-2.
//  Copyright (c) 2014年 etouch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Safe)
@property (nonatomic,strong)dispatch_queue_t concurrentQueue;

/**
 *  安全向字典里加入一条数据，不管这条数据是否为nil
 *
 *  @param anObject 一条需要增加的数据
 *  @param key key值
 *
 *  @return 返回是否增加成功  YES:成功  NO:失败
 */
- (BOOL)safeSetObject:(id)anObject forKey:(id<NSCopying>)key;


/**
 *  安全从字典里移除一条数据，不管这条数据是否为nil,如果是nil 就什么都不作
 *
 *  @return 返回是否增加成功  YES:成功  NO:失败
 */
- (BOOL)safeRemoveObjectForKey:(id)aKey;

#pragma mark - 多线程方式
//参考  https://mikeash.com/pyblog/friday-qa-2011-10-14-whats-new-in-gcd.html

/**
 *  多线程安全向字典里加入一条数据，不管这条数据是否为nil 使用Q
 *
 *  @param anObject 一条需要增加的数据
 *  @param key key值
 *
 */
- (void)safeQSetObject:(id)anObject forKey:(id<NSCopying>)key;


/**
 *  多线程安全从字典里移除一条数据，不管这条数据是否为nil,如果是nil 就什么都不做 使用Q
 *
 *
 */
- (void)safeQRemoveObjectForKey:(id)aKey;

/**
 *  多线程安全从字典里移除一条数据，不管这条数据是否为nil,如果是nil 就什么都不做 使用Q
 *
 *
 */
- (void)safeQRemoveObjectsForKeys:(NSArray *)keyArray;

/**
 *  多线程安全从字典里移除一条数据，不管这条数据是否为nil,如果是nil 就什么都不做 使用Q
 *
 */
- (void)safeQRemoveAllObjects;

/**
 *  多线程 安全从字典中去除一条数据 使用Q
 *
 *
 */
- (id)safeQObjectForKey:(id)aKey;

@end


