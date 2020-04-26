//
//  DetailsTagsView.m
//  konachan
//
//  Created by Chian on 2019/2/13.
//  Copyright © 2019 HQ. All rights reserved.
//

#import "DetailsTagsView.h"
#import "TTGTagCollectionView.h"
#import "TTGTextTagCollectionView.h"

@interface DetailsTagsView ()<TTGTextTagCollectionViewDelegate>
@property(strong,nonatomic) TTGTextTagCollectionView *tagCollectionView;

@end

@implementation DetailsTagsView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.tagCollectionView];
    }
    return self;
}

- (void)setTags:(NSArray<NSString *> *)tags{
    _tags = tags;
    [self.tagCollectionView addTags:self.tags];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.tagCollectionView.frame = CGRectMake(5, 5, CGRectGetWidth(self.frame)-10, CGRectGetHeight(self.frame)-10);
}

- (TTGTextTagCollectionView *)tagCollectionView{
    if (!_tagCollectionView) {
        _tagCollectionView = [[TTGTextTagCollectionView alloc]init];
        _tagCollectionView.delegate = self;
        _tagCollectionView.defaultConfig.selectedBackgroundColor = _tagCollectionView.defaultConfig.backgroundColor;
        
    }
    return _tagCollectionView;
}

// MARK: - TTGTextTagCollectionViewDelegate
- (void)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView
                    didTapTag:(NSString *)tagText
                      atIndex:(NSUInteger)index
                     selected:(BOOL)selected
                    tagConfig:(TTGTextTagConfig *)config{
    if ([self.delegate respondsToSelector:@selector(detailsTagsViewDidClickWithTag:)]) {
        [self.delegate detailsTagsViewDidClickWithTag:tagText];
    }
}

- (void)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView
            updateContentSize:(CGSize)contentSize{
    if ([self.delegate respondsToSelector:@selector(detailsTagsViewUpdateHeight:)]) {
        [self.delegate detailsTagsViewUpdateHeight:contentSize.height + 10];
    }
}

@end
