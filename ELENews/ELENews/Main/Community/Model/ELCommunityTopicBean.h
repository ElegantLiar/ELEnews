//
//  ELCommunityTopicBean.h
//  ELENews
//
//  Created by EL on 2017/12/14.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELCommunityTopicBean : NSObject

@property (nonatomic, assign) NSInteger topicID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *urlroute;

- (NSAttributedString *)findTopicNameAttributedStringWithFontSize:(CGFloat)size;

@end
