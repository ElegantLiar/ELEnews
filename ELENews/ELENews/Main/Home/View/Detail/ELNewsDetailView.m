//
//  ELNewsDetailView.m
//  ELENews
//
//  Created by EL on 2017/12/21.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELNewsDetailView.h"
#import "ELNewsDetailTitleNode.h"
#import "ELNewsDetailAuthorNode.h"
#import "ELNewsDetailContentNode.h"

@interface ELNewsDetailView()<
ASTableDelegate,
ASTableDataSource
>

@end

@implementation ELNewsDetailView{
    ASTableNode                 *_tableNode;
}

- (instancetype)init{
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    _tableNode = [[ASTableNode alloc] init];
    _tableNode.delegate = self;
    _tableNode.dataSource = self;
    [self addSubnode:_tableNode];
    _tableNode.view.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableNode.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).with.insets(UIEdgeInsetsZero);
    }];
}

#pragma mark - ASTableDataSource
- (NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode{
    return 2;
}

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    } else {
        return _pageBean.showParagraph.count;
    }
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return ^ASCellNode *() {
                ELNewsDetailTitleNode *cellNode = [[ELNewsDetailTitleNode alloc] initWithTitle:_pageBean.info.title];
                return cellNode;
            };
        } else {
            return ^ASCellNode *() {
                ELNewsDetailAuthorNode *cellNode = [[ELNewsDetailAuthorNode alloc] initWithNewsDetailInfoBean:_pageBean.info];
                return cellNode;
            };
        }
    } else {
        return ^ASCellNode *() {
            ELNewsDetailContentNode *cellNode = [[ELNewsDetailContentNode alloc] initWithNewsDetailParagraphBean:[_pageBean.showParagraph safeObjectAtIndex:indexPath.row] detailPageBean:_pageBean];
            return cellNode;
        };
    }
}

- (void)setPageBean:(ELNewsDetailPageBean *)pageBean{
    _pageBean = pageBean;
    [_tableNode reloadData];
}
@end
