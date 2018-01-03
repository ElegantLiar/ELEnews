//
//  ELDisplayViewController.h
//  ELENews
//
//  Created by EL on 2017/12/6.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "YZDisplayViewController.h"
#import "ELTabbarViewModel.h"

@interface ELDisplayViewController : YZDisplayViewController

@property (nonatomic, strong, readonly) ELTabbarViewModel *viewModel;

- (instancetype)initWithViewModel:(ELBaseViewModel *)viewModel;

- (void)bindViewModel;

@end
