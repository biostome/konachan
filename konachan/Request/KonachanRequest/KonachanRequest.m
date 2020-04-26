//
//  KonachanRequest.m
//  konachan
//
//  Created by Chian on 2019/2/12.
//  Copyright © 2019 HQ. All rights reserved.
//

#import "KonachanRequest.h"
#import <objc/runtime.h>
#import "YYModel.h"

@implementation KonachanRequest
- (instancetype)init{
    self = [super init];
    if (self) {
        self.limit = 50;
        self.page = 1;
    }
    return self;
}
- (NSString *)suffixURL{
    return @"/post.json";
}

@end

