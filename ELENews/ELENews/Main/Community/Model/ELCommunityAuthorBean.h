//
//  ELCommunityAuthorBean.h
//  ELENews
//
//  Created by EL on 2017/12/14.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELCommunityAuthorBean : NSObject

@property (nonatomic, assign) NSInteger authorID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *avatar_box;
@property (nonatomic, assign) NSInteger is_follow;
@property (nonatomic, strong) NSString *url_route;

@end
