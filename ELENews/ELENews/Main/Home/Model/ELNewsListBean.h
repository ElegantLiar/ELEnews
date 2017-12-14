//
//  ELNewsListBean.h
//  ELENews
//
//  Created by EL on 2017/12/13.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ELNewsAuthorBean;

@interface ELNewsListBean : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) ELNewsAuthorBean *cat;
@property (nonatomic, assign) NSInteger display;
@property (nonatomic, strong) NSArray *gallary;
@property (nonatomic, strong) NSString *urlroute;

- (NSAttributedString *)usernameAttributedStringWithFontSize:(CGFloat)size;
- (NSAttributedString *)newsAttributedStringWithFontSize:(CGFloat)size;

@end

@interface ELNewsAuthorBean : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *pic;

@end
