//
//  ELCommunityRecommendPageBean.h
//  ELENews
//
//  Created by EL on 2017/12/14.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELCommunityOptBean.h"

@interface ELCommunityRecommendPageBean : NSObject

@property (nonatomic, strong) NSArray *list;
@property (nonatomic, strong) ELCommunityOptBean *opt;
@property (nonatomic, strong) NSArray *stars;

@end
