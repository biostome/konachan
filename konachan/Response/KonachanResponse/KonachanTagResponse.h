//
//  KonachanTagResponse.h
//  konachan
//
//  Created by Chian on 2019/2/12.
//  Copyright © 2019 HQ. All rights reserved.
//

#import "BaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface KonachanTagResponse : BaseResponse
@property(assign,nonatomic) int ID,count,type,ambiguous;
@property(strong,nonatomic) NSString *name,*name_pattern;
@end

NS_ASSUME_NONNULL_END
