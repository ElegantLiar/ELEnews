//
//  ELCommunityRecommendViewModel.h
//  ELENews
//
//  Created by EL on 2017/12/14.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ELCommunityFeedBaseViewControllerType) {
    ELCommunityFeedBaseViewControllerTypeRecommend = 0,
    ELCommunityFeedBaseViewControllerTypeLastNews
};

@interface ELCommunityRecommendViewModel : NSObject

@property (nonatomic, strong, readonly) RACCommand *requestCommand;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) ELCommunityFeedBaseViewControllerType type;

- (void)loadDataFromNetwork;

- (void)loadNextPageDataFromNetwork;

@end
