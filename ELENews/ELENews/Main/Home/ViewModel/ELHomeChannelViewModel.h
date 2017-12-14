//
//  ELHomeChannelViewModel.h
//  ELENews
//
//  Created by EL on 2017/12/7.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELChannelBean.h"

@interface ELHomeChannelViewModel : NSObject

@property (nonatomic, strong) ELChannelBean *channelBean;

@property (nonatomic, strong, readonly) RACCommand *requestCommand;

+ (ELHomeChannelViewModel *)shareInstance;

- (void)loadDataFromNetwork;

@end
