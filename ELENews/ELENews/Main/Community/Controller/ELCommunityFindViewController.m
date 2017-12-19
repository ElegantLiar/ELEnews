//
//  ELCommunityFindViewController.m
//  ELENews
//
//  Created by EL on 2017/12/14.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELCommunityFindViewController.h"
#import "ELCommunityFindViewModel.h"
#import "ELCommunityFindPageBean.h"
#import "ELCommunityFeedHeaderNote.h"
#import "ELCommunityFindAddStarNode.h"
#import "ELCommunityFindDayTopicNode.h"
#import "ELCommunityFindTopicCategoryNode.h"
#import "ELCommunityFindActivityNode.h"

@interface ELCommunityFindViewController ()<
ASTableDelegate,
ASTableDataSource,
UIScrollViewDelegate
>

@end

@implementation ELCommunityFindViewController{
    ELCommunityFindViewModel        *_findViewModel;
    ASTableNode                     *_tableNode;
    NSMutableArray                  *_listArray;
    ELCommunityFindPageBean         *_bean;
}

#pragma mark – LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _listArray = @[].mutableCopy;
    _findViewModel = [[ELCommunityFindViewModel alloc] init];

    [self initUI];

    @weakify(self);

    [_findViewModel loadDataFromNetwork];
    
    [[_findViewModel.requestCommand execute:nil] subscribeNext:^(ELCommunityFindPageBean *bean) {
        @strongify(self);
        self->_bean = bean;
        [self->_tableNode reloadData];
    }];
}

#pragma mark - Intial Methods
- (void)initUI{
    _tableNode = [[ASTableNode alloc] init];
    _tableNode.delegate = self;
    _tableNode.dataSource = self;
    [self.baseContentView addSubnode:_tableNode];
    _tableNode.view.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableNode.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).with.offset(-kAppTabBarHeight);
    }];
}
#pragma mark – Target Methods

#pragma mark - Private Methods

#pragma mark - Setter Getter Methods

#pragma mark - ASTableDataSource
- (NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode{
    return 4;
}

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1 + 1;
    } else if (section == 1) {
        return _bean.topics.count > 0 ? (1 + 1) : 0;
    } else if (section == 2) {
        return 1 + _bean.cats.count;
    } else if (section == 3) {
        return 1 + 1;
    } else {
        return 0;
    }
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return ^ASCellNode *() {
                ELCommunityFeedHeaderNote *cellNode = [[ELCommunityFeedHeaderNote alloc] initWithImageName:@"community_dabang_14x14_"
                                                                                                     Title:@"我家爱豆"
                                                                                                   hasMore:NO];
                return cellNode;
            };
        } else {
            return ^ASCellNode *() {
                ELCommunityFindDayTopicNode *cellNode = [[ELCommunityFindDayTopicNode alloc] init];
                return cellNode;
            };
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return ^ASCellNode *() {
                ELCommunityFeedHeaderNote *cellNode = [[ELCommunityFeedHeaderNote alloc] initWithImageName:@"community_discover_topic_14x15_"
                                                                                                     Title:@"每日话题"
                                                                                                   hasMore:NO];
                return cellNode;
            };
        } else {
            return ^ASCellNode *() {
                ELCommunityFindDayTopicNode *cellNode = [[ELCommunityFindDayTopicNode alloc] initWithCommunityWithTopics:_bean.topics];
                return cellNode;
            };
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            return ^ASCellNode *() {
                ELCommunityFeedHeaderNote *cellNode = [[ELCommunityFeedHeaderNote alloc] initWithImageName:@"community_discover_cat_14x15_"
                                                                                                     Title:@"话题类别"
                                                                                                   hasMore:NO];
                return cellNode;
            };
        } else {
            return ^ASCellNode *() {
                ELCommunityFindTopicCategoryNode *cellNode = [[ELCommunityFindTopicCategoryNode alloc] initWithCommunityTopicCategoryBean:[_bean.cats safeObjectAtIndex:indexPath.row - 1]];
                return cellNode;
            };
        }
    } else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            return ^ASCellNode *() {
                ELCommunityFeedHeaderNote *cellNode = [[ELCommunityFeedHeaderNote alloc] initWithImageName:@"community_discover_cat_14x15_"
                                                                                                     Title:@"活动"
                                                                                                   hasMore:NO];
                return cellNode;
            };
        } else {
            return ^ASCellNode *() {
                ELCommunityFindActivityNode *cellNode = [[ELCommunityFindActivityNode alloc] initWithCommunityActivityBean:_bean.activity];
                return cellNode;
            };
        }
    } else {
        return ^ASCellNode *() {
            return [[ASCellNode alloc] init];
        };
    }
}

#pragma mark -- ScrollViewDelegate
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    if (_feedViewModel.feedType == ELFeedTypeGif) {
//        NSArray *visibleCells = [_tableNode indexPathsForVisibleRows];
//        for (NSIndexPath *indexPath in visibleCells) {
//            ELGIFFeedNode *cellNode = [_tableNode nodeForRowAtIndexPath:indexPath];
//            [cellNode playGIF];
//        }
//    }
//}
@end
