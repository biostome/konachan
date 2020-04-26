//
//  BaseResponse.m
//  konachan
//
//  Created by Chian on 2019/2/12.
//  Copyright © 2019 HQ. All rights reserved.
//

#import "BaseResponse.h"

@implementation BaseResponse
+(NSDictionary *)modelCustomPropertyMapper{
    return  @{
              @"ID":@"id"
              };
}
@end
