//
//  ELCommunityActivityBean.h
//  ELENews
//
//  Created by EL on 2017/12/18.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELCommunityActivityBean : NSObject

@property (nonatomic, assign) NSInteger activityID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *sub;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *urlroute;

- (NSAttributedString *)titleAttributedStringWithFontSize:(CGFloat)size;
- (NSAttributedString *)subTitleAttributedStringWithFontSize:(CGFloat)size;

@end
