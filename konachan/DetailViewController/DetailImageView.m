//
//  DetailImageView.m
//  konachan
//
//  Created by Chian on 2019/2/13.
//  Copyright © 2019 HQ. All rights reserved.
//

#import "DetailImageView.h"
#import "KonachanResponse.h"
#import "UIImageView+WebCache.h"

@implementation DetailImageView

- (void)setKonachanResponse:(KonachanResponse *)konachanResponse{
    _konachanResponse = konachanResponse;
    [self.imageView sd_setImageWithURL:konachanResponse.jpeg_url];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initSubView];
    }
    return self;
}

- (void)initSubView{
    self.imageView = [[UIImageView alloc]init];
    [self addSubview:self.imageView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
    
    UILongPressGestureRecognizer * longTap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTapAction:)];
    [self addGestureRecognizer:longTap];
}

- (void)longTapAction:(UILongPressGestureRecognizer*)tap{
    if (tap.state == UIGestureRecognizerStateBegan) {
        if ([self.delegate respondsToSelector:@selector(detailImageViewDidOnLongTouchWithResponse:)]) {
            [self.delegate detailImageViewDidOnLongTouchWithResponse:self.konachanResponse];
        }
    }
}

- (void)tapAction:(UITapGestureRecognizer*)tap{
    if ([self.delegate respondsToSelector:@selector(detailImageViewDidClickWithResponse:)]) {
        [self.delegate detailImageViewDidClickWithResponse:self.konachanResponse];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}

@end
