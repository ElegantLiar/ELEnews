//
//  ELNewsCommonViewController.m
//  ELENews
//
//  Created by EL on 2017/12/7.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELNewsCommonViewController.h"
#import "ELChannelBean.h"
#import "ELFeedViewModel.h"
#import "ELNewsCommonBean.h"
#import "ELFeedBean.h"
#import "ELNewsFeedNote.h"

@interface ELNewsCommonViewController ()<ASTableDelegate, ASTableDataSource, UIScrollViewDelegate>

@end

@implementation ELNewsCommonViewController{
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
    [[_feedViewModel.requestCommand execute:nil] subscribeNext:^(ELNewsCommonBean *commonBean) {
        @strongify(self);
        [self->_listArray addObjectsFromArray:commonBean.list];
        [self insertNewRows:commonBean.list];
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
    ELFeedBean *feedBean = [_listArray safeObjectAtIndex:indexPath.row];
    return ^ASCellNode *() {
        ELNewsFeedNote *cellNode = [[ELNewsFeedNote alloc] initWithFeedBean:feedBean];
        return cellNode;
    };
}

#pragma mark - ASTableDelegate
- (void)tableNode:(ASTableNode *)tableNode willBeginBatchFetchWithContext:(ASBatchContext *)context{
    [context beginBatchFetching];
    [_feedViewModel loadNextPageDataFromNetwork];
    [self loadPageWithContext:context];
}

#pragma mark -- ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}
@end
