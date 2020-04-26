//
//  DetailCommentsView.m
//  konachan
//
//  Created by Chian on 2019/2/13.
//  Copyright © 2019 HQ. All rights reserved.
//

#import "DetailCommentsView.h"
#import "YYCategories.h"

@interface DetailCommentsView ()<UITextViewDelegate>
@property(strong,nonatomic) UITextView *textView;
@property(strong,nonatomic) UILabel *placeHolder;
@end

@implementation DetailCommentsView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.textView];
        [self.textView addSubview:self.placeHolder];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.textView.frame = CGRectMake(5, 5, CGRectGetWidth(self.frame)-10, CGRectGetHeight(self.frame)-10);
    self.placeHolder.frame = CGRectMake(5, 0, 200, 30);
}

// MARK: - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.hasText) {
        self.placeHolder.hidden = YES;
    }else{
        self.placeHolder.hidden = NO;
    }
}

- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.layer.cornerRadius = 10;
        _textView.layer.masksToBounds = YES;
        _textView.backgroundColor = [UIColor colorWithRGB:0xdddddd];
        _textView.delegate = self;
        [_textView setUserInteractionEnabled:NO];
    }
    return _textView;
}

- (UILabel *)placeHolder{
    if (!_placeHolder) {
        _placeHolder = [[UILabel alloc]init];
        _placeHolder.font = [UIFont systemFontOfSize:13];
        _placeHolder.textColor = UIColor.lightGrayColor;
        _placeHolder.text = @"评论功能尚未开通，敬请期待！";
    }
    return _placeHolder;
}
@end
