//
//  ELCommunityRecommendViewModel.h
//  ELENews
//
//  Created by EL on 2017/12/14.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELCommunityRecommendViewModel : NSObject

@property (nonatomic, strong, readonly) RACCommand *requestCommand;

@property (nonatomic, assign) NSInteger page;


- (void)loadDataFromNetwork;

- (void)loadNextPageDataFromNetwork;

@end
