//
//  ELCommunityBannerBean.h
//  ELENews
//
//  Created by EL on 2017/12/18.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELCommunityBannerBean : NSObject

@property (nonatomic, assign) NSInteger bannerID;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *urlroute;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger oid;

@end
