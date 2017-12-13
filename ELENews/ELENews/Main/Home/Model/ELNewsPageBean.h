//
//  ELNewsPageBean.h
//  ELENews
//
//  Created by EL on 2017/12/12.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELNewsPageBean : NSObject

@property (nonatomic, strong) NSArray *info;
@property (nonatomic, strong) NSArray *flash;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) long ts;

@end
