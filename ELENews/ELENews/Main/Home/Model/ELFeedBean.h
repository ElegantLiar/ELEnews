//
//  ELFeedBean.h
//  ELENews
//
//  Created by EL on 2017/12/7.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ELFeedCatBean;
@interface ELFeedBean : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) ELFeedCatBean *cat;
@property (nonatomic, assign) NSInteger display;
@property (nonatomic, strong) NSArray *gallary;
@property (nonatomic, strong) NSString *urlroute;

- (NSAttributedString *)usernameAttributedStringWithFontSize:(CGFloat)size;
- (NSAttributedString *)newsAttributedStringWithFontSize:(CGFloat)size;


@end

@interface ELFeedCatBean : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *pic;

@end

