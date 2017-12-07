//
//  UIColor+extend.h
//  ETravel
//
//  Created by XZoscar on 10-12-30.
//  Copyright 2010 华易科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIColor(extend)

//支持长度为6或者8的颜色值
+ (UIColor *)hexChangeFloat:(NSString *)hexColor;

+ (UIColor *)hexChangeFloat:(NSString *)hexColor AndAlpha:(float)alpha;

@end
