//
//  DetailCommentsListView.h
//  konachan
//
//  Created by Chian on 2019/2/13.
//  Copyright © 2019 HQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol DetailCommentsListViewDelegate <NSObject>

- (void)detailCommentsListViewForHeight:(CGFloat)height;

@end
@interface DetailCommentsListView : UIView
@property(assign,nonatomic) int ID;
@property(weak,nonatomic) id<DetailCommentsListViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
