//
//  DetailViewController.m
//  konachan
//
//  Created by Chian on 2019/2/13.
//  Copyright © 2019 HQ. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailImageView.h"
#import "DetailPersonInfoView.h"
#import "DetailCommentsView.h"
#import "DetailCommentsListView.h"
#import "DetailsTagsView.h"
#import "KonachanResponse.h"
#import "GKPhotoBrowser.h"
#import "UIImageView+WebCache.h"
#import "ViewController.h"

@interface DetailViewController ()<GKPhotoBrowserDelegate,DetailImageViewDelegate,DetailCommentsListViewDelegate,DetailsTagsViewDelegate,UIGestureRecognizerDelegate,UINavigationControllerDelegate>
@property(strong,nonatomic) DetailImageView *detailImageView;
@property(strong,nonatomic) DetailPersonInfoView *detailPersonInfoView;
@property(strong,nonatomic) DetailCommentsListView *detailCommentsListView;
@property(strong,nonatomic) DetailCommentsView *detailCommentsView;
@property(strong,nonatomic) DetailsTagsView *detailsTagsView;
@property(strong,nonatomic) UIScrollView *scrollView;
/** 这里用weak是防止GKPhotoBrowser被强引用，导致不能释放 */
@property (nonatomic, weak) GKPhotoBrowser *browser;
@property(assign,nonatomic) CGFloat commontListViewHeight;
@property(assign,nonatomic) CGFloat tagsViewHeight;
//@property(strong,nonatomic) UIButton *backButton;
@end

@implementation DetailViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.commontListViewHeight = 0;
        self.tagsViewHeight = 240;
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


bool _hidenNav;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.definesPresentationContext = YES;
    //解决滑动视图顶部空出状态栏高度的问题
    if (@available(iOS 11.0, *)) {
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
        self.navigationController.navigationBar.prefersLargeTitles = NO;
//        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
//        if([UIViewController instancesRespondToSelector:@selector(edgesForExtendedLayout)]) {
//            self.edgesForExtendedLayout = UIRectEdgeNone;
//        }
        
    }
    self.title = @"详情";
    
    [self.view setBackgroundColor:UIColor.whiteColor];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.detailImageView];
    [self.scrollView addSubview:self.detailPersonInfoView];
    [self.scrollView addSubview:self.detailCommentsListView];
    [self.scrollView addSubview:self.detailCommentsView];
    [self.scrollView addSubview:self.detailsTagsView];
    
//    [self.view addSubview:self.backButton];
//    [self.backButton bringSubviewToFront:self.scrollView];
    
    self.detailImageView.konachanResponse = self.konachanResponse;
    self.detailCommentsListView.ID = self.konachanResponse.ID;
    self.detailsTagsView.tags = [self.konachanResponse.tags componentsSeparatedByString:@" "];
    self.detailPersonInfoView.konachanResponse = self.konachanResponse;
    self.title = self.konachanResponse.author;
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.scrollView.frame = self.view.bounds;
    self.detailImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.scrollView.frame),  CGRectGetWidth(self.scrollView.frame)*self.konachanResponse.jpeg_scale);
    self.detailPersonInfoView.frame = CGRectMake(0, CGRectGetMaxY(self.detailImageView.frame), CGRectGetWidth(self.scrollView.frame), 80);
    self.detailsTagsView.frame = CGRectMake(0, CGRectGetMaxY(self.detailPersonInfoView.frame), CGRectGetWidth(self.scrollView.frame), self.tagsViewHeight);
    self.detailCommentsListView.frame = CGRectMake(0, CGRectGetMaxY(self.detailsTagsView.frame)+5, CGRectGetWidth(self.scrollView.frame), self.commontListViewHeight);
    self.detailCommentsView.frame = CGRectMake(0, CGRectGetMaxY(self.detailCommentsListView.frame), CGRectGetWidth(self.scrollView.frame), 100);
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.detailCommentsView.frame));
    
//    self.backButton.frame = CGRectMake(-20, 22, 80, 40);
    
}


- (void)showGKPhotoBrowserWithModels:(NSArray<KonachanResponse*>*)models withIndex:(NSInteger)index{
    NSMutableArray *photos = [NSMutableArray new];
    [models enumerateObjectsUsingBlock:^(KonachanResponse* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GKPhoto *photo = [GKPhoto new];
        photo.url = obj.jpeg_url;
        [photos addObject:photo];
    }];
    GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:photos currentIndex:index];
    browser.showStyle = GKPhotoBrowserShowStyleNone;
    browser.hideStyle = GKPhotoBrowserHideStyleZoomScale;
    browser.loadStyle = GKPhotoBrowserLoadStyleDeterminate;
    browser.isAdaptiveSafeArea = YES;
    browser.isLowGifMemory = YES;
    browser.isScreenRotateDisabled = NO;
    browser.delegate = self;
    self.browser = browser;
    [browser showFromVC:self];
}

- (BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//    return UIInterfaceOrientationPortrait;
//}


// MARK: - GKPhotoBrowserDelegate
- (void)photoBrowser:(GKPhotoBrowser *)browser longPressWithIndex:(NSInteger)index{
    [browser presentViewController:[self saveImageAlert] animated:YES completion:nil] ;
}

- (UIAlertController*)saveImageAlert{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存高清图片" preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(self) weakself = self;
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        [weakself cancelBtnClick];
    }];
    UIAlertAction * save = [UIAlertAction actionWithTitle:@"保存" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [weakself saveBtnClick];
    }];
    [alert addAction:cancel];
    [alert addAction:save];
    return alert;
}


- (void)photoBrowser:(GKPhotoBrowser *)browser onDeciceChangedWithIndex:(NSInteger)index isLandspace:(BOOL)isLandspace {
    
}

- (void)saveBtnClick{
    [SDWebImageManager.sharedManager loadImageWithURL:self.konachanResponse.file_url options:(0) progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
    }];
}

- (void)cancelBtnClick{
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error == nil) {
        
    }
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}

// MARK: - DetailImageViewDelegate
- (void)detailImageViewDidClickWithResponse:(KonachanResponse *)response{
    [self showGKPhotoBrowserWithModels:@[response] withIndex:0];
}

- (void)detailImageViewDidOnLongTouchWithResponse:(KonachanResponse *)response{
    [self presentViewController:[self saveImageAlert] animated:YES completion:nil];
}

// MARK: - DetailCommentsListViewDelegate
- (void)detailCommentsListViewForHeight:(CGFloat)height{
    self.commontListViewHeight = height;
    [self.view setNeedsLayout];
}

// MARK: - DetailsTagsViewDelegate
- (void)detailsTagsViewUpdateHeight:(CGFloat)height{
    self.tagsViewHeight = height;
    [self.view setNeedsLayout];
}

- (void)detailsTagsViewDidClickWithTag:(NSString *)tag{
    ViewController * vc = [[ViewController alloc]init];
    vc.hidesBottomBarWhenPushed = NO;
    vc.tags = [@[tag] componentsJoinedByString:@" "];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)backClick:(UIButton*)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (DetailImageView *)detailImageView{
    if (!_detailImageView) {
        _detailImageView = [[DetailImageView alloc]init];
        _detailImageView.delegate = self;
    }
    return _detailImageView;
}

- (DetailPersonInfoView *)detailPersonInfoView{
    if (!_detailPersonInfoView) {
        _detailPersonInfoView = [[DetailPersonInfoView alloc]init];
    }
    return _detailPersonInfoView;
}

- (DetailCommentsView *)detailCommentsView{
    if (!_detailCommentsView) {
        _detailCommentsView = [[DetailCommentsView alloc]init];
        _detailCommentsView.backgroundColor = UIColor.whiteColor;
    }
    return _detailCommentsView;
}

- (DetailCommentsListView *)detailCommentsListView{
    if (!_detailCommentsListView) {
        _detailCommentsListView = [[DetailCommentsListView alloc]init];
        _detailCommentsListView.backgroundColor = UIColor.whiteColor;
        _detailCommentsListView.delegate = self;
    }
    return _detailCommentsListView;
}

- (DetailsTagsView *)detailsTagsView{
    if (!_detailsTagsView) {
        _detailsTagsView = [[DetailsTagsView alloc]init];
        _detailsTagsView.backgroundColor = UIColor.whiteColor;
        _detailsTagsView.delegate = self;
    }
    return _detailsTagsView;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.backgroundColor = UIColor.whiteColor;
    }
    return _scrollView;
}

//- (UIButton *)backButton{
//    if (!_backButton) {
//        _backButton = [[UIButton alloc]init];
//        [_backButton setImage:[UIImage imageNamed:@"Back Arrow"] forState:(UIControlStateNormal)];
//        [_backButton addTarget:self action:@selector(backClick:) forControlEvents:(UIControlEventTouchUpInside)];
//    }
//    return _backButton;
//}

@end
