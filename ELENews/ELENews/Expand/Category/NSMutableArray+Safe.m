//
//  NSMutableArray+Safe.m
//  testArray
//
//  Created by suishen.mobi on 13-12-26.
//  Copyright (c) 2013年 suishen.mobi. All rights reserved.
//

#import "NSMutableArray+Safe.h"

@implementation NSMutableArray (Safe)

- (BOOL)safeAddObject:(id)anObject{
    if(anObject){
        [self addObject:anObject];
        return YES;
    }else{
        return NO;
    }
}

- (BOOL)safeInsertObject:(id)anObject atIndex:(NSUInteger)index{
    if(anObject){
        if(index <= [self count]){
            [self insertObject:anObject atIndex:index];
            return YES;
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}

#pragma mark 删除
- (BOOL)safeRemoveObjectAtIndex:(NSInteger)index{
    if(index < [self count] && index >= 0){
        [self removeObjectAtIndex:index];
        return YES;
    }else{
        return NO;
    }
}

#pragma mark 查询
- (id)safeObjectAtIndex:(NSUInteger)index{
    if(index < [self count]){
        return [self objectAtIndex:index];
    }else{
        return nil;
    }
}

@end



