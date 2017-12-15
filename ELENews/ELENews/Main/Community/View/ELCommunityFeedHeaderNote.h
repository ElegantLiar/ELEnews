//
//  ELCommunityFeedHeaderNote.h
//  ELENews
//
//  Created by EL on 2017/12/15.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface ELCommunityFeedHeaderNote : ASCellNode

- (instancetype)initWithImageName:(NSString *)imageName
                            Title:(NSString *)title
                          hasMore:(BOOL)hasMore;

@end
