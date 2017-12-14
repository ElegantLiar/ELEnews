//
//  ELGIFPageBean.h
//  ELENews
//
//  Created by EL on 2017/12/13.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELGIFPageBean : NSObject

@property (nonatomic, strong) NSArray *list;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) long ts;

@end
