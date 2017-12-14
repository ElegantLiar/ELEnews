//
//  ELNewsPageViewController.m
//  ELENews
//
//  Created by EL on 2017/12/12.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELNewsPageViewController.h"

#import "ELChannelBean.h"
#import "ELNewsPageBean.h"
#import "ELFlashPageBean.h"
#import "ELGifPageBean.h"

#import "ELNewsFeedNote.h"
#import "ELFlashFeedNote.h"
#import "ELGIFFeedNode.h"
#import "ELVideoNode.h"

@interface ELNewsPageViewController ()<
ASTableDelegate,
ASTableDataSource,
UIScrollViewDelegate>

@end

@implementation ELNewsPageViewController{
    ASTableNode         *_tableNode;
    ELFeedViewModel     *_feedViewModel;
    NSMutableArray      *_listArray;
}

#pragma mark – LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _listArray = @[].mutableCopy;
    
    _feedViewModel = [[ELFeedViewModel alloc] init];
    _feedViewModel.channelID = _singleChannelBean.channelID;
    _feedViewModel.flag = _singleChannelBean.flag;
    _feedViewModel.tabType = _tabType;
    
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
    [[_feedViewModel.requestCommand execute:nil] subscribeNext:^(NSArray *listArray) {
        @strongify(self);
        [self->_listArray addObjectsFromArray:listArray];
        [self insertNewRows:listArray];
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
- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section{
    return _listArray.count;
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath{
    id feedBean = [_listArray safeObjectAtIndex:indexPath.row];
    if (_feedViewModel.tabType == ELTabTypeHome) {
        if (_feedViewModel.feedType == ELFeedTypeNews) {
            return ^ASCellNode *() {
                ELNewsFeedNote *cellNode = [[ELNewsFeedNote alloc] initWithNewsListBean:feedBean];
                return cellNode;
            };
        } else if (_feedViewModel.feedType == ELFeedTypeFlash) {
            return ^ASCellNode *() {
                ELFlashFeedNote *cellNode = [[ELFlashFeedNote alloc] initWithFlashListBean:feedBean];
                return cellNode;
            };
        } else {
            return ^ASCellNode *() {
                ELGIFFeedNode *cellNode = [[ELGIFFeedNode alloc] initWithGIFListBean:feedBean];
                return cellNode;
            };
        }
    } else {
        return ^ASCellNode *() {
            ELVideoNode *cellNode = [[ELVideoNode alloc] initWithVideoListBean:feedBean];
            return cellNode;
        };
    }
}

#pragma mark - ASTableDelegate
- (void)tableNode:(ASTableNode *)tableNode willBeginBatchFetchWithContext:(ASBatchContext *)context{
    [context beginBatchFetching];
    [_feedViewModel loadNextPageDataFromNetwork];
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
