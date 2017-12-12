//
//  ELNewsCommonViewController.h
//  ELENews
//
//  Created by EL on 2017/12/7.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELBaseViewController.h"
#import "ELHomeScrollDelegate.h"
@class ELSingleChannelBean;
@interface ELNewsCommonViewController : ELBaseViewController

@property (nonatomic, strong) ELSingleChannelBean *singleChannelBean;

@property (nonatomic, weak) id<ELHomeScrollDelegate> delegate;

@end
