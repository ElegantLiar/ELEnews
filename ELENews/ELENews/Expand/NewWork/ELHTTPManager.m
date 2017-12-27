//
//  ELHTTPManager.m
//  ELENews
//
//  Created by EL on 2017/12/7.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELHTTPManager.h"

@implementation ELHTTPManager

+ (instancetype)manager{
    static ELHTTPManager *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init{
    self = [super init];
    if (!self) return nil;
    self.requestSerializer.timeoutInterval = 10;
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                      @"application/json",
                                                      @"text/json",
                                                      @"text/javascript",
                                                      @"text/plain",
                                                      @"text/html",
                                                      nil];
    return self;
}

@end
