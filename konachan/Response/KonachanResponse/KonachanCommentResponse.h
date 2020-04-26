//
//  KonachanCommentResponse.h
//  konachan
//
//  Created by Chian on 2019/2/13.
//  Copyright © 2019 HQ. All rights reserved.
//

#import "BaseResponse.h"
#import "NSString+YYAdd.h"

NS_ASSUME_NONNULL_BEGIN

@interface KonachanCommentResponse : BaseResponse
//"id": 176495,
//"created_at": "2019-02-12T19:54:55.054Z",
//"post_id": 278465,
//"creator": "Mr.peanutbutter",
//"creator_id": 185959,
//"body": "[quote] Oh demon lord, accept this sacrifice\r\n[/quote]\r\nDoes anyone else see a pentagram in this post?"
@property(strong,nonatomic) NSString *body;
@property(strong,nonatomic) NSString *creator;
@property(strong,nonatomic) NSString *creator_id;
@property(assign,nonatomic) int ID;
@property(assign,nonatomic) int post_id;
@property(assign,nonatomic) CGFloat bodyFontHeight;
@end

NS_ASSUME_NONNULL_END
