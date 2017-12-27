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
#import "ELNewsOneBigPicCenterFeedNote.h"
#import "ELNewsOneSmallPicLeftFeedNote.h"
#import "ELNewsThreePicFeedNote.h"

#import "ELNewsDetailViewController.h"
#import "ELNewsPhotoDetailViewController.h"
#import "ELVideoDetailViewController.h"

@interface ELNewsPageViewController ()<
ASTableDelegate,
ASTableDataSource,
UIScrollViewDelegate
>

@end

@implementation ELNewsPageViewController{
    ASTableNode         *_tableNode;
    ELFeedViewModel     *_feedViewModel;
    NSMutableArray      *_listArray;
    CGFloat             _orignalHeight;
    CGFloat             _height;
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
    
    @weakify(self);
    if (self.singleChannelBean.channelID == 0 && self.tabType == ELTabTypeHome) {
        [_feedViewModel loadFirstPageDataFromCache];
        [[_feedViewModel.cacheCommand execute:nil] subscribeNext:^(NSArray *listArray) {
            @strongify(self);
            if (self->_feedViewModel.page == 1 && listArray.count > 0) {
                [self->_listArray setArray:listArray];
                [_tableNode reloadData];
            }
            [self->_tableNode.view.mj_header endRefreshing];
        }];
    }
    
    _tableNode.view.mj_header = [ELRefreshHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self loadFirstPageData];
    }];
    
    [self loadFirstPageData];
}

#pragma mark - Intial Methods
- (void)initUI{
    _orignalHeight = self.view.height - kAppTabBarHeight;
    
    _tableNode = [[ASTableNode alloc] init];
    _tableNode.delegate = self;
    _tableNode.dataSource = self;
    [self.view addSubnode:_tableNode];
    _tableNode.view.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableNode.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(@(_orignalHeight));
    }];
}

#pragma mark – Target Methods
- (void)showDetailVcWithELNewsListBean:(ELNewsListBean *)listBean{
    ELNewsDetailViewController *detailVc = [[ELNewsDetailViewController alloc] init];
    detailVc.newsID = listBean.newsID;
    [detailVc configureNavTitle:listBean.cat.name iconImageUrl:listBean.cat.pic];
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (void)showPhotoBrowserWithNewsListBean:(ELNewsListBean *)listBean{
    ELNewsPhotoDetailViewController *detailVc = [[ELNewsPhotoDetailViewController alloc] init];
    detailVc.newID = listBean.newsID;
    [detailVc configureNavTitle:listBean.cat.name iconImageUrl:listBean.cat.pic];
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark - Private Methods
- (void)loadFirstPageData{
    [_feedViewModel loadFirstPageDataFromNetwork];
    [self loadPageWithContext:nil];
}

- (void)loadPageWithContext:(ASBatchContext *)context{
    @weakify(self);
    
    [[_feedViewModel.requestCommand execute:nil] subscribeNext:^(NSArray *listArray) {
        @strongify(self);
        if (self->_feedViewModel.page == 1 && listArray.count > 0) {
            [self->_listArray setArray:listArray];
            [_tableNode reloadData];
        } else {
            [self->_listArray addObjectsFromArray:listArray];
            [self insertNewRows:listArray];
        }
        [context completeBatchFetching:YES];

        [self->_tableNode.view.mj_header endRefreshing];
    } error:^(NSError *error) {
        @strongify(self);
        [self->_tableNode.view.mj_header endRefreshing];
        [context completeBatchFetching:YES];
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
                ELNewsListBean *newsListBean = feedBean;
                ASCellNode *cellNode = nil;
                if (newsListBean.display == ELNewsListBeanDisplayTypeOneBigPicCenter) {
                    cellNode = [[ELNewsOneBigPicCenterFeedNote alloc] initWithNewsListBean:newsListBean];
                } else if (newsListBean.display == ELNewsListBeanDisplayTypeOneSmallPicLeft) {
                    cellNode = [[ELNewsOneSmallPicLeftFeedNote alloc] initWithNewsListBean:newsListBean];
                } else if (newsListBean.display == ELNewsListBeanDisplayTypeThreePic) {
                    cellNode = [[ELNewsThreePicFeedNote alloc] initWithNewsListBean:newsListBean];
                } else {
                    cellNode = [[ELNewsFeedNote alloc] initWithNewsListBean:newsListBean];
                }
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

- (void)tableNode:(ASTableNode *)tableNode didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id feedBean = [_listArray safeObjectAtIndex:indexPath.row];
    if (_feedViewModel.tabType == ELTabTypeHome) {
        if (_feedViewModel.feedType == ELFeedTypeNews) {
            ELNewsListBean *bean = feedBean;
            if ([bean.cat.name isEqualToString:@"橘子News"]) {
                [self showPhotoBrowserWithNewsListBean:bean];
            } else {
                [self showDetailVcWithELNewsListBean:bean];
            }
        } else if (_feedViewModel.feedType == ELFeedTypeFlash) {
            return;
        } else {
            return;
        }
    } else {
        ELVideoListBean *bean = feedBean;
        ELVideoDetailViewController *detailVc = [[ELVideoDetailViewController alloc] init];
        detailVc.newsID = bean.videoID;
        [self.navigationController pushViewController:detailVc animated:YES];
    }
}

#pragma mark - ASTableDelegate
- (void)tableNode:(ASTableNode *)tableNode willBeginBatchFetchWithContext:(ASBatchContext *)context{
    [context beginBatchFetching];
    [_feedViewModel loadNextPageDataFromNetwork];
    [self loadPageWithContext:context];
}

#pragma mark -- ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_delegate && [_delegate respondsToSelector:@selector(elScrollViewHasScrolledWithContentOffset:)]) {
        [_delegate elScrollViewHasScrolledWithContentOffset:scrollView.contentOffset];
        if (scrollView.contentOffset.y > kAppNavigationBarHeight) {
            if (_height == _orignalHeight + kAppNavigationBarHeight) return;
            _height = _orignalHeight + kAppNavigationBarHeight;
        } else if (scrollView.contentOffset.y < 0) {
            return;
        } else {
            _height = _orignalHeight + kAppNavigationBarHeight - scrollView.contentOffset.y;
        }

        [_tableNode.view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@(_height));
        }];
    }
}
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
