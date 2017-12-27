//
//  ELRefreshHeader.m
//  ELENews
//
//  Created by EL on 2017/12/21.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELRefreshHeader.h"
#import "Lottie.h"


@implementation ELRefreshHeader{
    LOTAnimationView    *_animationView;
}

#pragma mark - 重写父类的方法
- (void)prepare{
    [super prepare];
    
    _animationView = [LOTAnimationView animationNamed:@"simple_loader.json" inBundle:[NSBundle mainBundle]];
    _animationView.loopAnimation = YES;
    _animationView.frame = CGRectMake((ELScreenW - 80)/2, (self.height - 80)/2, 80, 80);
    [self addSubview:_animationView];
    [_animationView play];

    //隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
    //隐藏状态
    self.stateLabel.hidden = YES;
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state{
    MJRefreshCheckState;
    switch (state) {
        case MJRefreshStateIdle:
            [_animationView play];
            break;
        case MJRefreshStatePulling:
            [_animationView play];
            break;
        case MJRefreshStateRefreshing:
            [_animationView play];
            break;
        case MJRefreshStateWillRefresh:
            [_animationView play];
            break;
        case MJRefreshStateNoMoreData:
            [_animationView pause];
            break;
        default:
            break;
    }
}

- (void)placeSubviews{
    [super placeSubviews];
    
    _animationView.left = (self.width - 80) / 2.f;
}


@end
