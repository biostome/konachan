//
//  ImageViewCell.h
//  konachan
//
//  Created by Chian on 2019/2/9.
//  Copyright © 2019 HQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class KonachanResponse;
@interface ImageViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(strong,nonatomic) KonachanResponse *dataModel;
@end

NS_ASSUME_NONNULL_END
