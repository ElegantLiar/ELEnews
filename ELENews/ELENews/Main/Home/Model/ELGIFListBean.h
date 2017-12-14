//
//  ELGIFListBean.h
//  ELENews
//
//  Created by EL on 2017/12/13.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELNewsListBean.h"

@class ELGIFBean;

@interface ELGIFListBean : NSObject

@property (nonatomic, assign) NSInteger gifID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *txtlead;
@property (nonatomic, strong) NSString *shareurl;
@property (nonatomic, assign) NSInteger display;
@property (nonatomic, assign) NSInteger replynum;
@property (nonatomic, strong) ELGIFBean *gif;
@property (nonatomic, strong) NSString *pt;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSArray *imgs;
@property (nonatomic, strong) ELNewsAuthorBean *author;

- (NSAttributedString *)usernameAttributedStringWithFontSize:(CGFloat)size;
- (NSAttributedString *)titleAttributedStringWithFontSize:(CGFloat)size;

@end

@interface ELGIFBean : NSObject

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) NSString *mp4;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *thumb_jpg;

@end

