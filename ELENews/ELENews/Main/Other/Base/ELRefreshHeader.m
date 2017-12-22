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

- (void)placeSubviews{
    [super placeSubviews];
    
    _animationView.left = (self.width - 80) / 2.f;
}


@end
