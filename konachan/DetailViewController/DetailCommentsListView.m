//
//  DetailCommentsListView.m
//  konachan
//
//  Created by Chian on 2019/2/13.
//  Copyright © 2019 HQ. All rights reserved.
//

#import "DetailCommentsListView.h"
#import "KonachanCommentRequest.h"
#import "KonachanCommentResponse.h"
#import "UIImageView+WebCache.h"


@interface DetailCommentsViewCell : UITableViewCell
@property(strong,nonatomic) KonachanCommentResponse *commentResponse;
@property(strong,nonatomic) UIImageView *headerImageView;
@property(strong,nonatomic) UILabel *creatorLabel;
@property(strong,nonatomic) UILabel *created_atLabel;
@property(strong,nonatomic) UILabel *bodyLabel;
@end

@implementation DetailCommentsViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)initSubView{
    self.headerImageView = [[UIImageView alloc]init];
    self.creatorLabel = [[UILabel alloc]init];
    self.creatorLabel.font = [UIFont systemFontOfSize:13];
    self.created_atLabel = [[UILabel alloc]init];
    self.created_atLabel.font = [UIFont systemFontOfSize:13];
    self.bodyLabel = [[UILabel alloc]init];
    self.bodyLabel.font = [UIFont systemFontOfSize:13];
    self.bodyLabel.numberOfLines = 0;
    
    [self.contentView addSubview:self.headerImageView];
    [self.contentView addSubview:self.creatorLabel];
    [self.contentView addSubview:self.created_atLabel];
    [self.contentView addSubview:self.bodyLabel];
    
    self.headerImageView.layer.cornerRadius = 20;
    self.headerImageView.layer.masksToBounds = YES;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.headerImageView.frame = CGRectMake(0, 5, 40, 40);
    
    self.creatorLabel.frame = CGRectMake(45, 5, 100, CGRectGetHeight(self.headerImageView.frame)/2);
    
    self.created_atLabel.frame = CGRectMake(45, CGRectGetMaxY(self.creatorLabel.frame), 100, CGRectGetHeight(self.headerImageView.frame)/2);
    
    self.bodyLabel.frame = CGRectMake(0, CGRectGetMaxY(self.headerImageView.frame), CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame)-CGRectGetHeight(self.headerImageView.frame));
}

- (void)setCommentResponse:(KonachanCommentResponse *)commentResponse{
    _commentResponse = commentResponse;
    self.headerImageView.backgroundColor = UIColor.redColor;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:@"https://konachan.com/data/avatars/73632.jpg?1549089149"]];
    self.creatorLabel.text = commentResponse.creator;
    self.created_atLabel.text = commentResponse.creator_id;
    self.bodyLabel.text = commentResponse.body;
}

-(void)setFrame:(CGRect)frame{
    frame.origin.x += 5;
    frame.size.width -= 10;
    [super setFrame:frame];
}

@end


@interface DetailCommentsListView ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic) UITableView *tableView;
@property(strong,nonatomic) NSArray<KonachanCommentResponse*> * datas;
@end


@implementation DetailCommentsListView


- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.tableView];
    }
    return self;
}

- (void)setID:(int)ID{
    _ID = ID;
    [self loadDataWithID:ID];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
}

- (void)loadDataWithID:(int)ID{
    KonachanCommentRequest * req = [[KonachanCommentRequest alloc]init];
    req.ID = ID;
    __weak typeof(self) weakself = self;
    [req requestSuccess:^(id responseObject) {
        NSArray<KonachanCommentResponse*> * datas = [NSArray yy_modelArrayWithClass:KonachanCommentResponse.class json:responseObject];
        NSMutableArray<KonachanCommentResponse*> * mulDatas = [[NSMutableArray alloc]initWithArray:datas];
        [datas enumerateObjectsUsingBlock:^(KonachanCommentResponse * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.post_id != ID) {
                [mulDatas removeObject:obj];
            }
        }];
        if (mulDatas.count>3) {
            [mulDatas removeObjectsInRange:NSMakeRange(3, mulDatas.count-3)];
        }
        weakself.datas = mulDatas;
        
        CGFloat viewForHeight = 0.0;
        for (KonachanCommentResponse * resp in mulDatas) {
            viewForHeight += resp.bodyFontHeight;
        }
        
        if ([self.delegate respondsToSelector:@selector(detailCommentsListViewForHeight:)]) {
            [self.delegate detailCommentsListViewForHeight:viewForHeight];
        }
        [weakself.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

// MARK: - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailCommentsViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCommentsViewCell"];
    cell.commentResponse = self.datas[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    KonachanCommentResponse * commentResponse = self.datas[indexPath.row];
    return commentResponse.bodyFontHeight;
}

// MARK: - UITableViewDelegate

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        [_tableView registerClass:DetailCommentsViewCell.class forCellReuseIdentifier:@"DetailCommentsViewCell"];
        _tableView.dataSource =self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
    }
    return _tableView;
}

@end
