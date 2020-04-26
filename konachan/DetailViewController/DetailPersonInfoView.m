//
//  DetailPersonInfoView.m
//  konachan
//
//  Created by Chian on 2019/2/13.
//  Copyright © 2019 HQ. All rights reserved.
//

#import "DetailPersonInfoView.h"
#import "KonachanResponse.h"

@interface DetailPersonInfoView ()
@property(strong,nonatomic) UILabel *IDLabel;
@property(strong,nonatomic) UILabel *sizeLabel;
@property(strong,nonatomic) UILabel *postedLabel;
@property(strong,nonatomic) UILabel *scoreLabel;
@property(strong,nonatomic) UILabel *favoritedLabel;
@end

@implementation DetailPersonInfoView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initSubView];
    }
    return self;
}

- (void)initSubView{
    self.IDLabel = [[UILabel alloc]init];
    self.sizeLabel = [[UILabel alloc]init];
    self.postedLabel = [[UILabel alloc]init];
    self.scoreLabel = [[UILabel alloc]init];
    self.favoritedLabel = [[UILabel alloc]init];
    
    self.IDLabel.font = [UIFont systemFontOfSize:13];
    self.sizeLabel.font = [UIFont systemFontOfSize:13];
    self.postedLabel.font = [UIFont systemFontOfSize:13];
    self.scoreLabel.font = [UIFont systemFontOfSize:13];
    self.favoritedLabel.font = [UIFont systemFontOfSize:13];
    
    
    [self addSubview:self.scoreLabel];
    [self addSubview:self.postedLabel];
    [self addSubview:self.sizeLabel];
    [self addSubview:self.favoritedLabel];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.sizeLabel.frame = CGRectMake(5, 5, CGRectGetWidth(self.frame), 20);
    self.postedLabel.frame = CGRectMake(5, CGRectGetMaxY(self.sizeLabel.frame), CGRectGetWidth(self.frame), 20);
    self.scoreLabel.frame = CGRectMake(5, CGRectGetMaxY(self.postedLabel.frame), CGRectGetWidth(self.frame), 20);
    self.favoritedLabel.frame = CGRectMake(5, CGRectGetMaxY(self.scoreLabel.frame), CGRectGetWidth(self.frame), 20);
    
}


- (void)setKonachanResponse:(KonachanResponse *)konachanResponse{
    _konachanResponse = konachanResponse;
    self.IDLabel.text = [NSString stringWithFormat:@"Id:%d",konachanResponse.ID];
    self.sizeLabel.text = [NSString stringWithFormat:@"Size:%.0fx%.0f",konachanResponse.jpeg_width,konachanResponse.jpeg_height];
    self.postedLabel.text = [NSString stringWithFormat:@"Post:%@",konachanResponse.author];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score:%d",konachanResponse.score];
    
}

@end
