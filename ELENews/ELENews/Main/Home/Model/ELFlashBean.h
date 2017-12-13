//
//  ELFlashBean.h
//  ELENews
//
//  Created by EL on 2017/12/12.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ELFlashImageBean;
@interface ELFlashBean : NSObject

@property (nonatomic, assign) NSInteger flashID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *pt;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSArray *imgs;

- (NSAttributedString *)timeAttributedStringWithFontSize:(CGFloat)size;
- (NSAttributedString *)titleAttributedStringWithFontSize:(CGFloat)size;
- (NSAttributedString *)textAttributedStringWithFontSize:(CGFloat)size;


@end

@interface ELFlashImageBean : NSObject

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) NSString *src;
@property (nonatomic, strong) NSString *thumb;

@end
