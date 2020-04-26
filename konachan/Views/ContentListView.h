//
//  ContentListView.h
//  konachan
//
//  Created by Chian on 2019/2/9.
//  Copyright © 2019 HQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KonachanResponse.h"
NS_ASSUME_NONNULL_BEGIN

@protocol ContentListViewDelegate <NSObject>

- (void)contentListViewDidClickWithItem:(NSInteger)item withDataModel:(KonachanResponse*)dataModel;

- (void)contentListViewDidRefreshMore;

- (void)contentListViewDidRefreshNew;

- (void)contentListViewDidScroll:(UIScrollView *)scrollView;

@end

@interface ContentListView : UIView
@property(strong,nonatomic) UICollectionView *collectionView;
@property(weak,nonatomic) id<ContentListViewDelegate> delegate;
@property(strong,nonatomic) NSArray<KonachanResponse*> *models;
@end


NS_ASSUME_NONNULL_END
