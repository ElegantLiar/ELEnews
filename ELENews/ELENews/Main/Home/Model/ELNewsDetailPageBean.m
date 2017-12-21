//
//  ELNewsDetailPageBean.m
//  ELENews
//
//  Created by EL on 2017/12/21.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELNewsDetailPageBean.h"

@implementation ELNewsDetailPageBean

- (void)configureContets{
    NSMutableArray  *compontedContents = @[].mutableCopy;
    _showParagraph = @[].mutableCopy;
    
    for (ELFlashImageBean *imageBean in self.resources.IMG) {
        imageBean.showWidth = ELScreenW - 20;
        imageBean.showHeight = (ELScreenW - 20) / imageBean.width * imageBean.height;
//        if (imageBean.showHeight > 375) {
//            imageBean.showHeight = 375;
//            imageBean.showWidth = 375 / imageBean.height * imageBean.width;
//        }
    }
    
    if (_contents && _contents.length > 0) {
        NSString *contents = [_contents copy];
        NSArray *componts = [contents componentsSeparatedByString:@"</p>"];
        for (NSString *content in componts) {
            NSArray *newComponts = [content componentsSeparatedByString:@"<p>"];
            [compontedContents safeAddObject:[newComponts lastObject]];
        }
    }

    NSInteger i = 0;
    for (NSString *paraString in compontedContents) {
        ELNewsDetailParagraphBean *bean = [ELNewsDetailParagraphBean new];
        if ([paraString containsString:@"--IMG#"]) {
            bean.type = ELNewsDetailParagraphTypeImage;
            bean.imageIndex = i;
            i++;
        } else {
            bean.type = ELNewsDetailParagraphTypeText;
            bean.showText = paraString;
            bean.fontSize = 18;
        }
        [_showParagraph safeAddObject:bean];
    }
}

@end

@implementation ELNewsDetailParagraphBean

@end

@implementation ELNewsDetailInfoBean

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"newsID" : @"id"
             };
}

@end

@implementation ELNewsDetailResourcesBean

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"IMG" : ELFlashImageBean.class
             };
}

@end
