//
//  ELMacros.h
//  ELENews
//
//  Created by EL on 2017/12/5.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

/**
 *  颜色
 */
#define ELBlackColor [UIColor blackColor]
#define ELBlueColor [UIColor blueColor]
#define ELRedColor [UIColor redColor]
#define ELWhiteColor [UIColor whiteColor]
#define ELGrayColor [UIColor grayColor]
#define ELDarkGrayColor [UIColor darkGrayColor]
#define ELLightGrayColor [UIColor lightGrayColor]
#define ELGreenColor [UIColor greenColor]
#define ELCyanColor [UIColor cyanColor]
#define ELYellowColor [UIColor yellowColor]
#define ELMagentaColor [UIColor magentaColor]
#define ELOrangeColor [UIColor orangeColor]
#define ELPurpleColor [UIColor purpleColor]
#define ELBrownColor [UIColor brownColor]
#define ELClearColor [UIColor clearColor]
#define ELLineColor [[UIColor hexChangeFloat:@"999999"] colorWithAlphaComponent:0.3]

#define ELNotificationCenter [NSNotificationCenter defaultCenter]

#define ELHomeNewsScrollViewDidScrollNotification @"ELHomeNewsScrollViewDidScrollNotification"

/** 屏幕 */
#define ELScreen [UIScreen mainScreen]
/** 屏幕宽度 */
#define ELScreenW [UIScreen mainScreen].bounds.size.width
/** 屏幕高度 */
#define ELScreenH [UIScreen mainScreen].bounds.size.height
/** 屏幕bounds */
#define ELScreenBounds [UIScreen mainScreen].bounds
/** 屏幕伸缩度（Retina时值为2,非Retina值为1）*/
#define ELScreenScale [UIScreen mainScreen].scale

#define IS_iPHone6Plus ([UIScreen mainScreen].bounds.size.height == 736) ? YES : NO

#define IS_iPHone6 ([UIScreen mainScreen].bounds.size.height == 667) ? YES : NO

#define IS_iPHone5 ([UIScreen mainScreen].bounds.size.height == 568) ? YES : NO

#define IS_iPHone4 ([UIScreen mainScreen].bounds.size.height == 480) ? YES : NO
// 判断是否是iPhoneX
#define IS_iPhoneX ([UIScreen mainScreen].bounds.size.height == 812) ? YES : NO
