//
//  ELCommunityRecommendViewController.m
//  ELENews
//
//  Created by EL on 2017/12/14.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELCommunityRecommendViewController.h"
#import "ELCommunityRecommendViewModel.h"
#import "ELCommunityRecommendPageBean.h"
#import "ELCommunityFeedListBean.h"
#import "ELCommunityFeedNode.h"

@interface ELCommunityRecommendViewController ()<
ASTableDelegate,
ASTableDataSource,
UIScrollViewDelegate>

@end

@implementation ELCommunityRecommendViewController{
    ELCommunityRecommendViewModel   *_recommentViewModel;
    ASTableNode                     *_tableNode;
    NSMutableArray                  *_listArray;
    ELCommunityRecommendPageBean    *_bean;
}

#pragma mark – LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _listArray = @[].mutableCopy;
    
    _recommentViewModel = [[ELCommunityRecommendViewModel alloc] init];
    
    [self initUI];
}

#pragma mark - Intial Methods
- (void)initUI{
    _tableNode = [[ASTableNode alloc] init];
    _tableNode.delegate = self;
    _tableNode.dataSource = self;
    [self.baseContentView addSubnode:_tableNode];
    _tableNode.view.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableNode.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
}
#pragma mark – Target Methods

#pragma mark - Private Methods
- (void)loadPageWithContext:(ASBatchContext *)context{
    @weakify(self);
    [[_recommentViewModel.requestCommand execute:nil] subscribeNext:^(ELCommunityRecommendPageBean *bean) {
        @strongify(self);
        _bean = bean;
        [self->_listArray addObjectsFromArray:_bean.list];
        [self insertNewRows:_bean.list];
        if (context) {
            [context completeBatchFetching:YES];
        }
    }];
}

- (void)insertNewRows:(NSArray *)newPhotos{
    NSInteger section = 0;
    NSMutableArray *indexPaths = [NSMutableArray array];
    
    NSInteger existentedCount = _listArray.count - newPhotos.count;
    for (NSInteger row = existentedCount; row < _listArray.count; row++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:section];
        [indexPaths addObject:path];
    }
    
    [_tableNode insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - Setter Getter Methods

#pragma mark - ASTableDataSource
- (NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode{
    return 2;
}

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 0;
    } else {
        return _listArray.count + 1;
    }
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath{
    ELCommunityFeedListBean *feedBean = [_listArray safeObjectAtIndex:indexPath.row];
    return ^ASCellNode *() {
        ELCommunityFeedNode *cellNode = [[ELCommunityFeedNode alloc] initWithCommunityFeedListBean:feedBean];
        return cellNode;
    };
}

#pragma mark - ASTableDelegate
- (void)tableNode:(ASTableNode *)tableNode willBeginBatchFetchWithContext:(ASBatchContext *)context{
    [context beginBatchFetching];
    [_recommentViewModel loadNextPageDataFromNetwork];
    [self loadPageWithContext:context];
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
