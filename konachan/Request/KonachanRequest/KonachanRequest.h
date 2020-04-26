//
//  KonachanRequest.h
//  konachan
//
//  Created by Chian on 2019/2/12.
//  Copyright © 2019 HQ. All rights reserved.
//

#import "BaseRequest.h"
#import "BaseResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface KonachanRequest : BaseRequest
@property(assign,nonatomic) int limit;
@property(assign,nonatomic) int page;
@property(strong,nonatomic) NSString *tags;
@end


NS_ASSUME_NONNULL_END
