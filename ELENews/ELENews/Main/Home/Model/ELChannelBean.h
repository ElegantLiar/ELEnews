//
//  ELChannelBean.h
//  ELENews
//
//  Created by EL on 2017/12/7.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELChannelBean : NSObject

@property (nonatomic, strong) NSArray *home;
@property (nonatomic, strong) NSArray *video;

@end

@interface ELSingleChannelBean : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, assign) NSInteger flag;
@property (nonatomic, assign) NSInteger channelID;

@end
