//
//  ELTabbarViewModel.m
//  ELENews
//
//  Created by EL on 2018/1/2.
//  Copyright © 2018年 ElegantLiar. All rights reserved.
//

#import "ELTabbarViewModel.h"

@implementation ELTabbarViewModel

- (instancetype)initWithTitle:(NSString *)title
                  tabbarTitle:(NSString *)tabbarTitle
           tabbarDefaultImage:(NSString *)tabbarDefaultImage
          tabbarSelectedImage:(NSString *)tabbarSelectedImage{
    if (self = [super init]) {
        self.title = title;
        _tabbarTitle = tabbarTitle;
        _tabbarDefaultImage = tabbarDefaultImage;
        _tabbarSelectedImage = tabbarSelectedImage;
        
        _textAttrs = @{}.mutableCopy;
        _textAttrs[NSForegroundColorAttributeName] = [UIColor hexChangeFloat:@"999999"];
        
        _selectTextAttrs = @{}.mutableCopy;
        _selectTextAttrs[NSForegroundColorAttributeName] = [UIColor hexChangeFloat:@"FF625D"];
    }
    return self;
}

@end
