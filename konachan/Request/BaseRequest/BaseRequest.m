//
//  BaseRequest.m
//  konachan
//
//  Created by Chian on 2019/2/12.
//  Copyright © 2019 HQ. All rights reserved.
//

#import "BaseRequest.h"

@implementation BaseRequest

- (void)requestSuccess:(PPHttpRequestSuccess)success failure:(PPHttpRequestFailed)failure{
    NSDictionary * params = self.requestParams;
    NSString * suffixURL = self.suffixURL;
    NSString * baseURL = self.baseURL;
    NSString * url = [NSString stringWithFormat:@"%@%@",baseURL,suffixURL];
    [PPNetworkHelper openLog];
    [PPNetworkHelper GET:url parameters:params.yy_modelToJSONObject success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (nonnull NSString*)baseURL{
    return @"https://konachan.com";
}

- (NSDictionary *)requestParams{
    NSMutableDictionary * mulDic = [[NSMutableDictionary alloc]init];
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        id propertyValue = [self valueForKey:propertyName];
        if (propertyValue != nil) {
            [mulDic setValue:propertyValue forKey:propertyName];
        }
    }
    return mulDic;
}

- (nonnull NSString *)suffixURL {
    return nil;
}

@end
