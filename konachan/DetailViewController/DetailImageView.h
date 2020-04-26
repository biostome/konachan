//
//  DetailImageView.h
//  konachan
//
//  Created by Chian on 2019/2/13.
//  Copyright © 2019 HQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class KonachanResponse;
@protocol DetailImageViewDelegate <NSObject>
- (void)detailImageViewDidClickWithResponse:(KonachanResponse*)response;
- (void)detailImageViewDidOnLongTouchWithResponse:(KonachanResponse*)response;
@end

@interface DetailImageView : UIView
@property(strong,nonatomic) UIImageView *imageView;
@property(strong,nonatomic) KonachanResponse *konachanResponse;
@property(weak,nonatomic) id<DetailImageViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
