//
//  DetailViewController.h
//  konachan
//
//  Created by Chian on 2019/2/13.
//  Copyright © 2019 HQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class KonachanResponse;
@interface DetailViewController : UIViewController
@property(strong,nonatomic) KonachanResponse *konachanResponse;
@end

NS_ASSUME_NONNULL_END
