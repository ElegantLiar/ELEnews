//
//  ELLaunchBean.h
//  ELENews
//
//  Created by EL on 2017/12/27.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ELLaunchSplashBean;
@interface ELLaunchBean : NSObject

@property (nonatomic, strong) ELLaunchSplashBean *splash;

@end

@interface ELLaunchSplashBean : NSObject

@property (nonatomic, strong) NSString *urlroute;
@property (nonatomic, strong) NSString *splash;

@end
