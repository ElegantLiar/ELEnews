//
//  ELCommunityFeedBaseViewController.m
//  ELENews
//
//  Created by EL on 2017/12/14.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELCommunityFeedBaseViewController.h"
#import "ELCommunityRecommendPageBean.h"
#import "ELCommunityFeedListBean.h"
#import "ELCommunityFeedNode.h"
#import "ELCommunityFeedHeaderNote.h"
#import "ELCommunityStarNode.h"

@interface ELCommunityFeedBaseViewController ()<
ASTableDelegate,
ASTableDataSource,
UIScrollViewDelegate
>

@property (nonatomic, assign) ELCommunityFeedBaseViewControllerType type;

@end

@implementation ELCommunityFeedBaseViewController{
    ELCommunityRecommendViewModel   *_recommentViewModel;
    ASTableNode                     *_tableNode;
    NSMutableArray                  *_listArray;
    ELCommunityRecommendPageBean    *_bean;
}

#pragma mark – LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
}

#pragma mark - Intial Methods
- (instancetype)initWithVcType:(ELCommunityFeedBaseViewControllerType)vcType{
    if (self = [super init]) {
        _listArray = @[].mutableCopy;
        
        _type = vcType;
        
        _recommentViewModel = [[ELCommunityRecommendViewModel alloc] init];
        _recommentViewModel.type = _type;
    }
    return self;
}

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
        if (_bean.page == 1) {
            [_tableNode reloadData];
        } else {
            [self insertNewRows:_bean.list];
        }
        if (context) {
            [context completeBatchFetching:YES];
        }
    }];
}

- (void)insertNewRows:(NSArray *)newPhotos{
    NSInteger section = 0;
    if (_type == ELCommunityFeedBaseViewControllerTypeRecommend) {
        section = 1;
    }
    NSMutableArray *indexPaths = [NSMutableArray array];
    
    NSInteger existentedCount = _listArray.count - newPhotos.count;
    
    for (NSInteger row = existentedCount; row < _listArray.count; row++) {
        NSInteger insertRow = row;
        if (_type == ELCommunityFeedBaseViewControllerTypeRecommend) {
            insertRow = row + 1;
        }
        NSIndexPath *path = [NSIndexPath indexPathForRow:insertRow inSection:section];
        [indexPaths addObject:path];
    }
    
    [_tableNode insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - Setter Getter Methods

#pragma mark - ASTableDataSource
- (NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode{
    if (_type == ELCommunityFeedBaseViewControllerTypeRecommend) {
        return 2;
    } else if (_type == ELCommunityFeedBaseViewControllerTypeLastNews) {
        return 1;
    } else {
        return 0;
    }
}

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section{
    if (_type == ELCommunityFeedBaseViewControllerTypeRecommend) {
        if (section == 0) {
            return 2;
        } else {
            return _listArray.count + 1;
        }
    } else if (_type == ELCommunityFeedBaseViewControllerTypeLastNews) {
        return _listArray.count;
    } else {
        return 0;
    }
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_type == ELCommunityFeedBaseViewControllerTypeRecommend) {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                return ^ASCellNode *() {
                    ELCommunityFeedHeaderNote *cellNode = [[ELCommunityFeedHeaderNote alloc] initWithImageName:@"community_dabang_14x14_"
                                                                                                         Title:@"明星打榜动态"
                                                                                                       hasMore:NO];
                    return cellNode;
                };
            } else {
                return ^ASCellNode *() {
                    ELCommunityStarNode *cellNode = [[ELCommunityStarNode alloc] initWithCommunityStarsArray:_bean.stars];
                    return cellNode;
                };
            }
        } else {
            if (indexPath.row == 0) {
                return ^ASCellNode *() {
                    ELCommunityFeedHeaderNote *cellNode = [[ELCommunityFeedHeaderNote alloc] initWithImageName:@"community_dabang_14x14_"
                                                                                                         Title:@"橘乐圈"
                                                                                                       hasMore:NO];
                    return cellNode;
                };
            } else {
                ELCommunityFeedListBean *feedBean = [_listArray safeObjectAtIndex:indexPath.row - 1];
                return ^ASCellNode *() {
                    ELCommunityFeedNode *cellNode = [[ELCommunityFeedNode alloc] initWithCommunityFeedListBean:feedBean];
                    return cellNode;
                };
            }
        }
    } else if (_type == ELCommunityFeedBaseViewControllerTypeLastNews) {
        ELCommunityFeedListBean *feedBean = [_listArray safeObjectAtIndex:indexPath.row];
        return ^ASCellNode *() {
            ELCommunityFeedNode *cellNode = [[ELCommunityFeedNode alloc] initWithCommunityFeedListBean:feedBean];
            return cellNode;
        };
    } else {
        ELCommunityFeedListBean *feedBean = [_listArray safeObjectAtIndex:indexPath.row];
        return ^ASCellNode *() {
            ELCommunityFeedNode *cellNode = [[ELCommunityFeedNode alloc] initWithCommunityFeedListBean:feedBean];
            return cellNode;
        };
    }
    
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
