//
//  KonachanTagRequest.h
//  konachan
//
//  Created by Chian on 2019/2/12.
//  Copyright © 2019 HQ. All rights reserved.
//

#import "BaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface KonachanTagRequest : BaseRequest
//@property(assign,nonatomic) int limit;
//@property(assign,nonatomic) int page;
//@property(assign,nonatomic) int ID;
//@property(assign,nonatomic) int after_id;
//@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *query;
@end

NS_ASSUME_NONNULL_END
