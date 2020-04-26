//
//  DetailsTagsView.h
//  konachan
//
//  Created by Chian on 2019/2/13.
//  Copyright © 2019 HQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol DetailsTagsViewDelegate <NSObject>
- (void)detailsTagsViewUpdateHeight:(CGFloat)height;
- (void)detailsTagsViewDidClickWithTag:(NSString*)tag;
@end
@interface DetailsTagsView : UIView
@property(strong,nonatomic) NSArray<NSString*> *tags;
@property(weak,nonatomic) id<DetailsTagsViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
