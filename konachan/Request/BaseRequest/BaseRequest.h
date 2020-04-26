//
//  BaseRequest.h
//  konachan
//
//  Created by Chian on 2019/2/12.
//  Copyright © 2019 HQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseResponse.h"
#import "YYModel.h"
#import "PPNetworkHelper.h"

NS_ASSUME_NONNULL_BEGIN
@interface BaseRequest : NSURLRequest
- (void)requestSuccess:(PPHttpRequestSuccess)success
               failure:(PPHttpRequestFailed)failure;
- (NSDictionary*)requestParams;
- (NSString*)suffixURL;
- (NSString*)baseURL;
@end

NS_ASSUME_NONNULL_END
