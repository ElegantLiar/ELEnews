//
//  ELCommunityFeedBaseViewController.h
//  ELENews
//
//  Created by EL on 2017/12/14.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELBaseViewController.h"
#import "ELCommunityRecommendViewModel.h"
#import "ELDisplayViewScrollDelegate.h"

@interface ELCommunityFeedBaseViewController : ELBaseViewController

@property (nonatomic, weak) id<ELDisplayViewScrollDelegate> delegate;

- (instancetype)initWithVcType:(ELCommunityFeedBaseViewControllerType)vcType;

@end
