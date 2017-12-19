//
//  ELCommunityFindViewModel.h
//  ELENews
//
//  Created by EL on 2017/12/18.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELCommunityFindViewModel : NSObject

@property (nonatomic, strong, readonly) RACCommand *requestCommand;

- (void)loadDataFromNetwork;

@end
