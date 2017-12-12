//
//  ELFeedViewModel.h
//  ELENews
//
//  Created by EL on 2017/12/7.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELFeedViewModel : NSObject

@property (nonatomic, strong, readonly) RACCommand *requestCommand;

@property (nonatomic, assign) NSInteger channelID;

@property (nonatomic, assign) NSInteger page;

- (void)loadFirstPageDataFromNetwork;

- (void)loadNextPageDataFromNetwork;


@end
