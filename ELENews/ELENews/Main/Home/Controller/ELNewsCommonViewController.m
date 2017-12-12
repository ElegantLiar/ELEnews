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
#import "ELFeedOneSamllPicLeftNote.h"

@interface ELNewsCommonViewController ()<ASTableDelegate, ASTableDataSource>

@end

@implementation ELNewsCommonViewController{
    ASTableNode         *_tableNode;
    ELFeedViewModel     *_feedViewModel;
    
    
    NSMutableArray      *_listArray;
}

#pragma mark – LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _listArray = @[].mutableCopy;
    
    _feedViewModel = [[ELFeedViewModel alloc] init];
    _feedViewModel.channelID = _singleChannelBean.channelID;
    [self initUI];
    
//    [self loadPageWithContext:nil];
//    [_feedViewModel loadFirstPageDataFromNetwork];

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
        if (commonBean.page == 1) {
            [self->_listArray setArray:commonBean.list];
            [self->_tableNode reloadData];
        } else {
            [self->_listArray addObjectsFromArray:commonBean.list];
            [self insertNewRows:commonBean.list];
        }
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

#pragma mark - ASTableDataSource methods

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section{
    return _listArray.count;
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath{
    ELFeedBean *feedBean = [_listArray safeObjectAtIndex:indexPath.row];
    ASCellNode *(^cellNodeBlock)() = ^ASCellNode *() {
        ELFeedOneSamllPicLeftNote *cellNode = [[ELFeedOneSamllPicLeftNote alloc] initWithFeedBean:feedBean];
        return cellNode;
    };
    
    return cellNodeBlock;
}

#pragma mark - ASTableDelegate methods
- (void)tableNode:(ASTableNode *)tableNode willBeginBatchFetchWithContext:(ASBatchContext *)context{
    [context beginBatchFetching];
    [_feedViewModel loadNextPageDataFromNetwork];
    [self loadPageWithContext:context];
}



@end
