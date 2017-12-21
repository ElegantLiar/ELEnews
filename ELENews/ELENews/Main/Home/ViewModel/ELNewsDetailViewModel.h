//
//  ELNewsDetailViewModel.h
//  ELENews
//
//  Created by EL on 2017/12/21.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELNewsDetailViewModel : NSObject

@property (nonatomic, strong, readonly) RACCommand *requestCommand;

- (void)loadDataFromNetworkWithNewsID:(NSInteger)newsID;

@end
