//
//  ImageViewCell.m
//  konachan
//
//  Created by Chian on 2019/2/9.
//  Copyright © 2019 HQ. All rights reserved.
//

#import "ImageViewCell.h"
#import "UIImageView+WebCache.h"
#import "KonachanResponse.h"
#import "PPNetworkHelper.h"

@implementation ImageViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.imageView.layer.cornerRadius = 10;
//    self.imageView.layer.masksToBounds = YES;
}

- (void)setDataModel:(KonachanResponse *)dataModel{
    _dataModel = dataModel;
    BOOL isWifi = [PPNetworkHelper isWiFiNetwork];
    [self.imageView sd_setImageWithURL:dataModel.preview_url];
}

@end
