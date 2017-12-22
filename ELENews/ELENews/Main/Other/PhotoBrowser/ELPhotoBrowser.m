//
//  ELPhotoBrowser.m
//  ELENews
//
//  Created by EL on 2017/12/22.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELPhotoBrowser.h"

@implementation ELPhotoBrowser{
    UIView      *_textBgView;
    UILabel     *_nowIndexLabel;
    UILabel     *_totalNumberLabel;
    UILabel     *_titleLabel;
    UILabel     *_subTitleLabel;
}

- (void)addOtherUI{
    UIView *parentView = self.rootView ? self.rootView : self.photoBrowserWindow;

    _textBgView = [[UIView alloc] init];
    [parentView addSubview:_textBgView];
    [_textBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(parentView).with.offset(0);
        make.height.mas_equalTo(@(140));
    }];
    
    _nowIndexLabel = [ELViewFactory labelWithBackgroundColor:[UIColor clearColor]
                                                   textColor:ELWhiteColor
                                               textAlignment:NSTextAlignmentLeft
                                               numberOfLines:1
                                                        text:@""
                                                    fontSize:18];
    [_textBgView addSubview:_nowIndexLabel];
    [_nowIndexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_textBgView.mas_left).with.offset(10);
        make.top.mas_equalTo(_textBgView).with.offset(20);
    }];
    
    _totalNumberLabel = [ELViewFactory labelWithBackgroundColor:[UIColor clearColor]
                                                      textColor:[ELWhiteColor colorWithAlphaComponent:0.6]
                                                  textAlignment:NSTextAlignmentLeft
                                                  numberOfLines:1
                                                           text:@""
                                                       fontSize:10];
    [_textBgView addSubview:_totalNumberLabel];
    [_totalNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nowIndexLabel.mas_right).with.offset(0);
        make.bottom.mas_equalTo(_nowIndexLabel).with.offset(0);
    }];
    
    _titleLabel = [ELViewFactory labelWithBackgroundColor:[UIColor clearColor]
                                                textColor:ELWhiteColor
                                            textAlignment:NSTextAlignmentLeft
                                            numberOfLines:1
                                                     text:@""
                                                 fontSize:18];
    [_textBgView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_textBgView.mas_left).with.offset(35);
        make.bottom.mas_equalTo(_nowIndexLabel).with.offset(0);
        make.right.mas_equalTo(_textBgView.mas_right).with.offset(-10);
    }];
    
    _subTitleLabel = [ELViewFactory labelWithBackgroundColor:[UIColor clearColor]
                                                   textColor:[UIColor hexChangeFloat:@"666666"]
                                               textAlignment:NSTextAlignmentLeft
                                               numberOfLines:4
                                                        text:@""
                                                    fontSize:15];
    [_textBgView addSubview:_subTitleLabel];
    [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_textBgView.mas_left).with.offset(10);
        make.top.mas_equalTo(_totalNumberLabel.mas_bottom).with.offset(13);
        make.right.mas_equalTo(_textBgView.mas_right).with.offset(-10);
    }];
}

- (void)updateShowText{
    ELNewsPhotoBrowserBean *browserBean = [_photoDetailPageBean.contents safeObjectAtIndex:self.currentImageIndex];
    _nowIndexLabel.text = [NSString stringWithFormat:@"%zd", self.currentImageIndex + 1];
    _totalNumberLabel.text = [NSString stringWithFormat:@"/%zd", _photoDetailPageBean.contents.count];
    _subTitleLabel.text = browserBean.des;
    _titleLabel.text = _photoDetailPageBean.info.title;
}

- (void)setPhotoDetailPageBean:(ELNewsPhotoDetailPageBean *)photoDetailPageBean{
    _photoDetailPageBean = photoDetailPageBean;
    [self updateShowText];
}

@end
