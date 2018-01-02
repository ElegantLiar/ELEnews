//
//  ELNewsPageViewController.h
//  ELENews
//
//  Created by EL on 2017/12/12.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELBaseViewController.h"
#import "ELFeedViewModel.h"
#import "ELDisplayViewScrollDelegate.h"

@class ELSingleChannelBean;

@interface ELNewsPageViewController : ELBaseViewController

@property (nonatomic, strong) ELSingleChannelBean *singleChannelBean;
@property (nonatomic, assign) ELTabType tabType;
@property (nonatomic, weak) id<ELDisplayViewScrollDelegate> delegate;

- (instancetype)initWithViewModel:(ELFeedViewModel *)viewModel;

@end
