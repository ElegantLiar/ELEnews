//
//  ELBaseViewController.h
//  ELENews
//
//  Created by EL on 2017/12/5.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSInteger, ELBaseViewControllerNavType) {
//    ELBaseViewControllerNavTypeMainPage = 0,
//    ELBaseViewControllerNavTypeSubPage
//};
@interface ELBaseViewController : UIViewController

@property (nonatomic, strong) UIView *baseNavigationView;
@property (nonatomic, strong) UIView *baseContentView;
@property (nonatomic, strong) NSString *baseTitle;

- (void)configureNavTitle:(NSString *)navTitle iconImageUrl:(NSString *)iconImageUrl;
//@property (nonatomic, assign) ELBaseViewControllerNavType type;

@end
