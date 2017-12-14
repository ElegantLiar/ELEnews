//
//  ELVideoListBean.h
//  ELENews
//
//  Created by EL on 2017/12/14.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELVideoListBean : NSObject

@property (nonatomic, assign) NSInteger videoID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *urlroute;

- (NSAttributedString *)titleAttributedStringWithFontSize:(CGFloat)size;

@end
