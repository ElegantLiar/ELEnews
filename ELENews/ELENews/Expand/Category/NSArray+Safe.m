//
//  NSArray+Safe.m
//  ECalendar-Pro
//
//  Created by suishen.mobi on 14-8-14.
//  Copyright (c) 2014年 etouch. All rights reserved.
//

#import "NSArray+Safe.h"

@implementation NSArray (Safe)

#pragma mark 查询
- (id)safeObjectAtIndex:(NSUInteger)index{
    if(index < [self count]){
        return [self objectAtIndex:index];
    }else{
        return nil;
    }
}

@end



