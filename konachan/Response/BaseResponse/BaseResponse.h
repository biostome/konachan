//
//  BaseResponse.h
//  konachan
//
//  Created by Chian on 2019/2/12.
//  Copyright © 2019 HQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseResponse : NSURLResponse
@property NSInteger statusCode;
@property BOOL success;
@property (nonatomic, strong) id result;
@end

NS_ASSUME_NONNULL_END
