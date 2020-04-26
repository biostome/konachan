//
//  KonachanResponse.m
//  konachan
//
//  Created by Chian on 2019/2/12.
//  Copyright © 2019 HQ. All rights reserved.
//

#import "KonachanResponse.h"
#import "YYModel.h"

@implementation KonachanResponse

- (float)preview_scale{
    return self.preview_height/self.preview_width;
}

- (float)jpeg_scale{
    return self.jpeg_height/self.jpeg_width;
}

@end
