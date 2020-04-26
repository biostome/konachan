//
//  ContentListView.m
//  konachan
//
//  Created by Chian on 2019/2/9.
//  Copyright © 2019 HQ. All rights reserved.
//

#import "ContentListView.h"
#import "ImageViewCell.h"
#import "MJRefresh.h"
#import "KonachanResponse.h"


@interface ContentListView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation ContentListView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
        [self setupMJRefresh];
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.collectionView];
        [self setupMJRefresh];
    }
    return self;
}

- (void)setModels:(NSArray<KonachanResponse *> *)models{
    if ([models isEqualToArray:_models]) {
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    _models = models;
    if ([self.collectionView.mj_header isRefreshing]) {
        [self.collectionView.mj_header endRefreshing];
    }
    if ([self.collectionView.mj_footer isRefreshing]) {
        [self.collectionView.mj_footer endRefreshing];
    }
    [self.collectionView reloadData];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

- (void)setupMJRefresh{
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if ([self.delegate respondsToSelector:@selector(contentListViewDidRefreshNew)]) {
            [self.delegate contentListViewDidRefreshNew];
        }
    }];
    MJRefreshAutoFooter * autoFooter = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        if ([self.delegate respondsToSelector:@selector(contentListViewDidRefreshMore)]) {
            [self.delegate contentListViewDidRefreshMore];
        }
    }];
    autoFooter.triggerAutomaticallyRefreshPercent = -30;
    autoFooter.onlyRefreshPerDrag = YES;
    self.collectionView.mj_footer = autoFooter;
}

// MARK: - UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageViewCell" forIndexPath:indexPath];
    cell.dataModel = self.models[indexPath.item];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    KonachanResponse *dataModel = self.models[indexPath.item];
    UIEdgeInsets inset = [self collectionView:collectionView layout:collectionViewLayout insetForSectionAtIndex:indexPath.section];
    CGFloat width = ((collectionView.frame.size.width)/self.eachCount)-inset.left-inset.right;
    return CGSizeMake(width, width);
}

- (int)eachCount{
    NSString * currentDeviceModel = UIDevice.currentDevice.model;
    BOOL isPad = [currentDeviceModel containsString:@"iPad"];
    UIInterfaceOrientation statusBarOrientation = [UIApplication sharedApplication].statusBarOrientation;
    switch (statusBarOrientation) {
        case UIInterfaceOrientationLandscapeLeft:case UIInterfaceOrientationLandscapeRight:
            return isPad?4.0:3.0;
        default:
            return isPad?3.0:2.0;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(contentListViewDidClickWithItem:withDataModel:)]) {
        [self.delegate contentListViewDidClickWithItem:indexPath.item withDataModel:self.models[indexPath.item]];
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 5, 0, 5);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(contentListViewDidScroll:)]) {
        [self.delegate contentListViewDidScroll:scrollView];
    }
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.footerReferenceSize = CGSizeZero;
        layout.headerReferenceSize = CGSizeZero;
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerNib:[UINib nibWithNibName:@"ImageViewCell" bundle:nil] forCellWithReuseIdentifier:@"ImageViewCell"];
        _collectionView.dataSource =self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = UIColor.whiteColor;
    }
    return _collectionView;
}

@end

