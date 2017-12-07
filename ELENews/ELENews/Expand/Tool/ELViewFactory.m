//
//  ELViewFactory.m
//  ELENews
//
//  Created by EL on 2017/12/5.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELViewFactory.h"

@implementation ELViewFactory

+ (UILabel *)labelWithTextColor:(UIColor *)textColor
                  numberOfLines:(NSInteger)numberOfLines
                           text:(NSString *)text
                       fontSize:(CGFloat)size{
    return [[self class] labelWithBackgroundColor:[UIColor clearColor]
                                        textColor:textColor
                                    textAlignment:NSTextAlignmentLeft
                                    numberOfLines:numberOfLines
                                             text:text
                                         fontSize:size];
}

+ (UILabel *)labelWithBackgroundColor:(UIColor *)backgroudColor textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSInteger)numberOfLines text:(NSString *)text fontSize:(CGFloat)size{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = backgroudColor;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.numberOfLines = numberOfLines;
    label.text = text;
    label.font = [UIFont systemFontOfSize:size];
    return label;
}

@end
