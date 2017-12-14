//
//  ELMainTabBarController.m
//  ELENews
//
//  Created by EL on 2017/12/5.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELMainTabBarController.h"
#import "ELDisplayViewController.h"
#import "ELNavgationController.h"

@interface ELMainTabBarController ()<UITabBarControllerDelegate>

@end

@implementation ELMainTabBarController

#pragma mark – LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

#pragma mark - Intial Methods
- (void)initUI{
    self.delegate = self;
        
    NSArray *titles = @[@"首页", @"视频", @"社区", @"我"];
    NSArray *className = @[@"ELHomeViewController", @"ELVideoViewController", @"ELHomeViewController", @"ELHomeViewController"];
    NSArray *defaultImageNames = @[@"tabbar_index_normal_40x40_", @"tabbar_video_normal_40x40_", @"tabbar_community_normal_40x40_", @"tabbar_me_normal_40x40_"];
    NSArray *selectedImageNames = @[@"tabbar_index_selected_40x40_", @"tabbar_video_selected_40x40_", @"tabbar_community_selected_40x40_", @"tabbar_me_selected_40x40_"];
    
    for (NSInteger i = 0; i < titles.count; i++) {
        
        [self addChildViewController:[[NSClassFromString([className safeObjectAtIndex:i]) alloc] init] title:[titles safeObjectAtIndex:i] defaultImageName:[defaultImageNames safeObjectAtIndex:i] selectedImageName:[selectedImageNames safeObjectAtIndex:i]];
    }
        
}

#pragma mark – Target Methods

#pragma mark - Private Methods
- (void)addChildViewController:(ELDisplayViewController *)childController
                         title:(NSString *)title
              defaultImageName:(NSString *)defaultImageName
             selectedImageName:(NSString *)selectedImageName{
    childController.baseTitle = title;
    childController.tabBarItem.title = title;
    childController.tabBarItem.image = [[UIImage imageNamed:defaultImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *textAttrs = @{}.mutableCopy;
    textAttrs[NSForegroundColorAttributeName] = [UIColor hexChangeFloat:@"999999"];
    
    NSMutableDictionary *selectTextAttrs = @{}.mutableCopy;
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor hexChangeFloat:@"FF625D"];
    
    [childController.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childController.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    ELNavgationController *navgationController = [[ELNavgationController alloc] initWithRootViewController:childController];
//    [childController.navigationController setNavigationBarHidden:YES animated:NO];
    [self addChildViewController:childController];
}
#pragma mark - Setter Getter Methods

#pragma mark - External Delegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
}

@end
