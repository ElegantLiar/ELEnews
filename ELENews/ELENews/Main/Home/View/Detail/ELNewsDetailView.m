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
#import "ELVideoDetailContentNode.h"
#import "ELNewsDetailCommentNode.h"


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
    return 3;
}

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    } else if (section == 1){
        if (_type == ELNewsDetailViewTypeNews) {
            return _pageBean.showParagraph.count;
        } else {
            return 1;
        }
    } else {
        if (_infoPageBean.comment.list.count > 0) {
            return 1 + _infoPageBean.comment.list.count;
        } else {
            return 0;
        }
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
    } else if (indexPath.section == 1) {
        if (_type == ELNewsDetailViewTypeNews) {
            return ^ASCellNode *() {
                ELNewsDetailContentNode *cellNode = [[ELNewsDetailContentNode alloc] initWithNewsDetailParagraphBean:[_pageBean.showParagraph safeObjectAtIndex:indexPath.row] detailPageBean:_pageBean];
                return cellNode;
            };
        } else {
            return ^ASCellNode *() {
                ELVideoDetailContentNode *cellNode = [[ELVideoDetailContentNode alloc] initWithTitle:_pageBean.info.txtlead];
                return cellNode;
            };
        }
    } else {
        if (indexPath.row == 0) {
            return ^ASCellNode *() {
                ELNewsDetailCommentTitleNode *cellNode = [[ELNewsDetailCommentTitleNode alloc] initWithTitle:@"用 户 评 论"];
                return cellNode;
            };
        } else {
            return ^ASCellNode *() {
                ELNewsDetailCommentNode *cellNode = [[ELNewsDetailCommentNode alloc] initWithCommentContentBean:[_infoPageBean.comment.list safeObjectAtIndex:indexPath.row - 1]];
                return cellNode;
            };
        }
    }
}

- (void)setPageBean:(ELNewsDetailPageBean *)pageBean{
    _pageBean = pageBean;
    [_tableNode reloadData];
}

- (void)setInfoPageBean:(ELNewsDetailInfoPageBean *)infoPageBean{
    _infoPageBean = infoPageBean;
    [_tableNode reloadData];
}
@end
