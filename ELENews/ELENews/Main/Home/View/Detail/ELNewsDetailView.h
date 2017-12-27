//
//  ELNewsDetailView.h
//  ELENews
//
//  Created by EL on 2017/12/21.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELNewsDetailPageBean.h"
#import "ELNewsDetailInfoPageBean.h"

typedef NS_ENUM(NSInteger, ELNewsDetailViewType) {
    ELNewsDetailViewTypeNews = 0,
    ELNewsDetailViewTypeVideo,
};
@interface ELNewsDetailView : UIView

@property (nonatomic, strong) ELNewsDetailPageBean *pageBean;
@property (nonatomic, strong) ELNewsDetailInfoPageBean *infoPageBean;

@property (nonatomic, assign) ELNewsDetailViewType type;

@end
