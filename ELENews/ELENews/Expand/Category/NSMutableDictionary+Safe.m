//
//  NSMutableDictionary+Safe.m
//  ECalendar-Pro
//
//  Created by suishen.mobi on 14-1-2.
//  Copyright (c) 2014年 etouch. All rights reserved.
//

#import "NSMutableDictionary+Safe.h"
#import <objc/runtime.h>


@implementation NSMutableDictionary (Safe)

static char safeConcurrentQueueKey;

- (dispatch_queue_t)concurrentQueue{
    dispatch_queue_t currentQueue = objc_getAssociatedObject(self, &safeConcurrentQueueKey);
    if(!currentQueue){
        currentQueue = dispatch_queue_create("com.etSafeMutableDic.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
        [self setConcurrentQueue:currentQueue];
    }
    return currentQueue;
}

- (void)setConcurrentQueue:(dispatch_queue_t)activityView{
    [self willChangeValueForKey:@"dispatch_queue_t"];
    objc_setAssociatedObject(self, &safeConcurrentQueueKey,
                             activityView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"dispatch_queue_t"];
}


- (BOOL)safeSetObject:(id)anObject forKey:(id<NSCopying>)key{
    if(anObject && key){
        [self setObject:anObject forKey:key];
        return YES;
    }else{
        return NO;
    }
}

- (BOOL)safeRemoveObjectForKey:(id)aKey{
    if(aKey){
        [self removeObjectForKey:aKey];
        return YES;
    }else{
        return NO;
    }
}

#pragma mark - 多线程方式
- (void)safeQSetObject:(id)anObject forKey:(id<NSCopying>)key{
    dispatch_barrier_async(self.concurrentQueue, ^{
        [self safeSetObject:anObject forKey:key];
    });
}

- (void)safeQRemoveObjectForKey:(id)aKey{
    dispatch_barrier_async(self.concurrentQueue, ^{
        [self safeRemoveObjectForKey:aKey];
    });
}

- (void)safeQRemoveObjectsForKeys:(NSArray *)keyArray{
    dispatch_barrier_async(self.concurrentQueue, ^{
        [self removeObjectsForKeys:keyArray];
    });
}

- (void)safeQRemoveAllObjects{
    dispatch_barrier_async(self.concurrentQueue, ^{
        [self removeAllObjects];
    });
}

- (id)safeQObjectForKey:(id)aKey{
    __block id obj;
    dispatch_sync(self.concurrentQueue, ^{
        obj = [self objectForKey:aKey];
    });
    return obj;
}

@end



