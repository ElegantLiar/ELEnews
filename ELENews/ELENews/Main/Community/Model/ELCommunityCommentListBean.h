//
//  ELCommunityCommentListBean.h
//  ELENews
//
//  Created by EL on 2017/12/14.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELCommunityAuthorBean.h"

@interface ELCommunityCommentListBean : NSObject

@property (nonatomic, assign) NSInteger commentID;
@property (nonatomic, strong) ELCommunityAuthorBean *author;
@property (nonatomic, assign) NSInteger floor_num;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, assign) NSInteger is_digg;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSArray *audio;
@property (nonatomic, strong) NSArray *img;
@property (nonatomic, strong) NSArray *at_topics_content;
@property (nonatomic, strong) NSArray *at_user;

@end
