//
//  ELFlashListBean.h
//  ELENews
//
//  Created by EL on 2017/12/13.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ELFlashImageBean;

@interface ELFlashListBean : NSObject

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
@property (nonatomic, assign) CGFloat size;
@property (nonatomic, strong) NSString *src;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *org;
@property (nonatomic, assign) BOOL high_img;

@property (nonatomic, assign) CGFloat showWidth;
@property (nonatomic, assign) CGFloat showHeight;
@end
