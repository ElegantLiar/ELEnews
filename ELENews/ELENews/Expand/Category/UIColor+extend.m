//
//  UIColor+extend.m
//  ETravel
//
//  Created by XZoscar on 10-12-30.
//  Copyright 2010 华易科技. All rights reserved.
//

#import "UIColor+extend.h"

@implementation UIColor(extend)

+ (UIColor *)hexChangeFloat:(NSString *) hexColor{
	return [self hexChangeFloat:hexColor AndAlpha:1.0];
}

+ (UIColor *)hexChangeFloat:(NSString *)hexColor AndAlpha:(float)alpha{
    if(hexColor.length == 6){
        unsigned int redInt_, greenInt_, blueInt_;
        NSRange rangeNSRange_;
        rangeNSRange_.length = 2;  // 范围长度为2
        
        // 取红色的值
        rangeNSRange_.location = 0;
        [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]]
         scanHexInt:&redInt_];
        
        // 取绿色的值
        rangeNSRange_.location = 2;
        [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]]
         scanHexInt:&greenInt_];
        
        // 取蓝色的值
        rangeNSRange_.location = 4;
        [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]]
         scanHexInt:&blueInt_];
        if(alpha > 1.0f){
            alpha = 1;
        }else if (alpha < 0.0f){
            alpha = 0;
        }
        return [UIColor colorWithRed:(float)(redInt_/255.0f)
                               green:(float)(greenInt_/255.0f)
                                blue:(float)(blueInt_/255.0f)
                               alpha:alpha];
    }else if (hexColor.length == 8){
        //前2位表示透明度，后6位表示颜色
        unsigned int alphaInt_, redInt_, greenInt_, blueInt_;
        NSRange rangeNSRange_;
        rangeNSRange_.length = 2;  // 范围长度为2
        
        // 取透明度的值
        rangeNSRange_.location = 0;
        [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]]
         scanHexInt:&alphaInt_];
        
        // 取红色的值
        rangeNSRange_.location = 2;
        [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]]
         scanHexInt:&redInt_];
        
        // 取绿色的值
        rangeNSRange_.location = 4;
        [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]]
         scanHexInt:&greenInt_];
        
        // 取蓝色的值
        rangeNSRange_.location = 6;
        [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]]
         scanHexInt:&blueInt_];
        
        return [UIColor colorWithRed:(float)(redInt_/255.0f)
                               green:(float)(greenInt_/255.0f)
                                blue:(float)(blueInt_/255.0f)
                               alpha:(float)(alphaInt_/255.0f)];
    }else{
        return [UIColor whiteColor];
    }
}

@end



