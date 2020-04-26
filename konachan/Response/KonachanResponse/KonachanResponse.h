//
//  KonachanResponse.h
//  konachan
//
//  Created by Chian on 2019/2/12.
//  Copyright © 2019 HQ. All rights reserved.
//

#import "BaseResponse.h"
@class YYModel;
NS_ASSUME_NONNULL_BEGIN
@interface KonachanResponse : BaseResponse
/// 作者
@property(strong,nonatomic) NSString *author;
@property(strong,nonatomic) NSString *created_at;
/// 创造者id
@property(strong,nonatomic) NSString *creator_id;
/// 标签
@property(strong,nonatomic) NSString *tags;
/// ID
@property(assign,nonatomic) int ID;
/// 评分
@property(assign,nonatomic) int score;

/// 文件的高度
@property(assign,nonatomic) float height;
/// 文件到宽度
@property(assign,nonatomic) float width;
/// 文件大小
@property(strong,nonatomic) NSString *file_size;
/// 源文件地址
@property(strong,nonatomic) NSURL *file_url;

/// 超大图高度
@property(assign,nonatomic) float jpeg_height;
/// 超大图宽度
@property(assign,nonatomic) float jpeg_width;
/// 超大图文件大小
@property(assign,nonatomic) float jpeg_file_size;
/// 超大图链接
@property(strong,nonatomic) NSURL *jpeg_url;

@property(assign,nonatomic) float jpeg_scale;

/// 预览图高度
@property(assign,nonatomic) float preview_height;
/// 预览图宽度
@property(assign,nonatomic) float preview_width;
/// 预览图实际高度
@property(strong,nonatomic) NSString *actual_preview_height;
/// 预览图实际宽度
@property(strong,nonatomic) NSString *actual_preview_width;
/// 预览图地址
@property(strong,nonatomic) NSURL *preview_url;

@property(assign,nonatomic) float preview_scale;

/// 中等图高度
@property(assign,nonatomic) float sample_height;
/// 中等图宽度
@property(assign,nonatomic) float sample_width;
/// 中等图文件大小
@property(assign,nonatomic) float sample_file_size;
/// 中等图地址
@property(strong,nonatomic) NSURL *sample_url;

@end

NS_ASSUME_NONNULL_END
