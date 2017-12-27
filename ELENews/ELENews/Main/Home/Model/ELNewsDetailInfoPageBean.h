//
//  ELNewsDetailInfoPageBean.h
//  ELENews
//
//  Created by EL on 2017/12/25.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ELNewsDetailArticalBean, ELNewsDetailTagBean, ELNewsDetailCommentBean, ELNewsDetailAttitudeBean, ELNewsDetailVideoBean;

@interface ELNewsDetailInfoPageBean : NSObject

@property (nonatomic, strong) ELNewsDetailArticalBean *artical;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) NSArray *vote;
@property (nonatomic, strong) NSArray *votegroup;
@property (nonatomic, strong) ELNewsDetailCommentBean *comment;
@property (nonatomic, strong) ELNewsDetailAttitudeBean *attitude;
@property (nonatomic, assign) BOOL isH5;
@property (nonatomic, strong) NSArray *video;

@end

@interface ELNewsDetailArticalBean : NSObject

@property (nonatomic, assign) NSInteger articalID;
@property (nonatomic, assign) NSInteger replynum;
@property (nonatomic, assign) NSInteger readnum;
@property (nonatomic, assign) BOOL iscollected;
@property (nonatomic, assign) BOOL expression;

@end

@interface ELNewsDetailTagBean : NSObject

@property (nonatomic, assign) NSInteger tagID;
@property (nonatomic, assign) BOOL issub;

@end

@interface ELNewsDetailCommentBean : NSObject

@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSArray *list;

@end

@interface ELNewsDetailCommentUserBean : NSObject

@property (nonatomic, assign) NSInteger userID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *avatar;

@end

@interface ELNewsDetailCommentContentBean : NSObject

@property (nonatomic, assign) NSInteger commentID;
@property (nonatomic, strong) ELNewsDetailCommentUserBean *user;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) BOOL isdigg;
@property (nonatomic, strong) NSString *publish_time;
@property (nonatomic, assign) NSInteger timestamp;
@property (nonatomic, assign) NSInteger digg;

- (NSAttributedString *)timeAttributedStringWithFontSize:(CGFloat)size;
- (NSAttributedString *)nameAttributedStringWithFontSize:(CGFloat)size;
- (NSAttributedString *)contentAttributedStringWithFontSize:(CGFloat)size;


@end

@interface ELNewsDetailAttitudeBean : NSObject

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSArray *list;

@end

@interface ELNewsDetailVideoBean : NSObject

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *img;

@end
