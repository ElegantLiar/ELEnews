//
//  ELNewsDetailPageBean.h
//  ELENews
//
//  Created by EL on 2017/12/21.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELCommunityTopicCategoryBean.h"
#import "ELFlashListBean.h"
#import "ELNewsListBean.h"

@class ELNewsDetailInfoBean, ELNewsDetailResourcesBean;
@interface ELNewsDetailPageBean : NSObject

@property (nonatomic, strong) ELNewsDetailInfoBean *info;
@property (nonatomic, strong) NSString *contents;
@property (nonatomic, strong) ELNewsDetailResourcesBean *resources;
@property (nonatomic, strong) NSString *configuredContents;
@property (nonatomic, strong) NSMutableArray *showParagraph;

- (void)configureContets;

@end

typedef NS_ENUM(NSInteger, ELNewsDetailParagraphType) {
    ELNewsDetailParagraphTypeText = 0,
    ELNewsDetailParagraphTypeImage
};
@interface ELNewsDetailParagraphBean : NSObject

@property (nonatomic, assign) ELNewsDetailParagraphType type;
@property (nonatomic, assign) NSInteger imageIndex;
@property (nonatomic, assign) NSInteger fontSize;
@property (nonatomic, strong) NSString *showText;

@end


@interface ELNewsDetailInfoBean : NSObject

@property (nonatomic, assign) NSInteger newsID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *share_title;
@property (nonatomic, assign) BOOL iskol;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *txtlead;
@property (nonatomic, strong) NSString *topic;
@property (nonatomic, strong) NSString *shareurl;
@property (nonatomic, strong) NSString *publish_time;
@property (nonatomic, strong) ELNewsAuthorBean *author;
@property (nonatomic, strong) ELCommunityTopicCategoryBean *cat;
@property (nonatomic, strong) NSString *shareimg;

@end

@interface ELNewsDetailResourcesBean : NSObject

@property (nonatomic, strong) NSArray *IMG;

@end
