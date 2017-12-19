//
//  ELCommunityTopicCategoryBean.h
//  ELENews
//
//  Created by EL on 2017/12/18.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELCommunityTopicCategoryBean : NSObject

@property (nonatomic, assign) NSInteger cateID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *pic;

- (NSAttributedString *)topicCategoryTitleAttributedStringWithFontSize:(CGFloat)size;

@end
