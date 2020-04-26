//
//  KonachanTagRequest.m
//  konachan
//
//  Created by Chian on 2019/2/12.
//  Copyright © 2019 HQ. All rights reserved.
//

#import "KonachanTagRequest.h"

@implementation KonachanTagRequest
- (instancetype)init{
    self = [super init];
    if (self) {
//        self.limit = 20;
//        self.page = 1;
//        self.name_pattern = @"";
    }
    return self;
}

- (NSString *)suffixURL{
    return @"tag.json";
}
@end
