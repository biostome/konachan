//
//  KonachanCommentResponse.m
//  konachan
//
//  Created by Chian on 2019/2/13.
//  Copyright © 2019 HQ. All rights reserved.
//

#import "KonachanCommentResponse.h"

@implementation KonachanCommentResponse
- (CGFloat)bodyFontHeight{
    CGFloat width = UIScreen.mainScreen.bounds.size.width - 10;
    CGSize size = [self.body sizeForFont:[UIFont systemFontOfSize:13] size:CGSizeMake(width, 400) mode:NSLineBreakByCharWrapping];
    return size.height +60;
}
@end
