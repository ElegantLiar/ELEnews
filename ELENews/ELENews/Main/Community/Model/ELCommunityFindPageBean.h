//
//  ELCommunityFindPageBean.h
//  ELENews
//
//  Created by EL on 2017/12/18.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELCommunityActivityBean.h"

@interface ELCommunityFindPageBean : NSObject

@property (nonatomic, strong) NSArray *opts;
@property (nonatomic, strong) NSArray *topics;
@property (nonatomic, strong) NSArray *cats;
@property (nonatomic, strong) ELCommunityActivityBean *activity;
@property (nonatomic, strong) NSArray *banners;
@property (nonatomic, strong) NSArray *stars;

@end
