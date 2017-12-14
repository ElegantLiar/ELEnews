//
//  ELCommunityFeedListBean.h
//  ELENews
//
//  Created by EL on 2017/12/14.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELCommunityAuthorBean.h"
#import "ELCommunityTopicBean.h"
#import "ELCommunityCommentListBean.h"

@interface ELCommunityFeedListBean : NSObject

@property (nonatomic, assign) NSInteger feedID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *share_title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, assign) NSInteger reply_num;
@property (nonatomic, assign) NSInteger page_view;
@property (nonatomic, assign) NSInteger credit_num;
@property (nonatomic, strong) NSArray *img;
@property (nonatomic, strong) NSArray *img_size;
@property (nonatomic, strong) NSArray *at_topics_content;
@property (nonatomic, strong) NSArray *at_topics_title;
@property (nonatomic, strong) NSArray *audio;
@property (nonatomic, strong) ELCommunityAuthorBean *author;
@property (nonatomic, strong) ELCommunityTopicBean *topic;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, strong) NSString *urlroute;
@property (nonatomic, assign) BOOL is_rec;
@property (nonatomic, strong) NSString *shareurl;
@property (nonatomic, strong) NSString *shareimg;
@property (nonatomic, strong) NSString *txtlead;

- (NSAttributedString *)usernameAttributedStringWithFontSize:(CGFloat)size;
- (NSAttributedString *)timeAttributedStringWithFontSize:(CGFloat)size;
- (NSAttributedString *)titleAttributedStringWithFontSize:(CGFloat)size;
- (NSAttributedString *)textAttributedStringWithFontSize:(CGFloat)size;

@end


