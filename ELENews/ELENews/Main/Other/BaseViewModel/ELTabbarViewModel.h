//
//  ELTabbarViewModel.h
//  ELENews
//
//  Created by EL on 2018/1/2.
//  Copyright © 2018年 ElegantLiar. All rights reserved.
//

#import "ELBaseViewModel.h"

@interface ELTabbarViewModel : ELBaseViewModel

- (instancetype)initWithTitle:(NSString *)title
                  tabbarTitle:(NSString *)tabbarTitle
           tabbarDefaultImage:(NSString *)tabbarDefaultImage
          tabbarSelectedImage:(NSString *)tabbarSelectedImage;

@property (nonatomic, strong) NSString *tabbarTitle;
@property (nonatomic, strong) NSString *tabbarDefaultImage;
@property (nonatomic, strong) NSString *tabbarSelectedImage;
@property (nonatomic, strong) NSMutableDictionary *textAttrs;
@property (nonatomic, strong) NSMutableDictionary *selectTextAttrs;

@end
