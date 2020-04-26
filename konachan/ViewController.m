//
//  ViewController.m
//  konachan
//
//  Created by Chian on 2019/2/9.
//  Copyright © 2019 HQ. All rights reserved.
//

#import "ViewController.h"
#import "ContentListView.h"
#import "KonachanRequest.h"
#import "KonachanResponse.h"
#import "SearchResultsController.h"
#import "DetailViewController.h"

@interface ViewController ()<ContentListViewDelegate,SearchResultsControllerDelegate,UIGestureRecognizerDelegate,UISearchResultsUpdating,UINavigationControllerDelegate>
@property(strong,nonatomic) ContentListView *contentListView;
@property(assign,nonatomic) int indexPage;
@property(strong,nonatomic) NSArray<KonachanResponse*>*dataModels;;
@property(strong,nonatomic) UISearchController *searchController;
@property(strong,nonatomic) SearchResultsController * searchResultsController;
@end

@implementation ViewController
// MARK: - init
- (instancetype)init{
    self = [super init];
    if (self) {
        self.indexPage = 1;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.contentListView];
    [self setTitle:self.tags.length?self.tags:@"首页"];
    self.definesPresentationContext = YES;
//    self.providesPresentationContextTransitionStyle = YES;
    if (@available(iOS 11.0, *)) {
//        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;
//        self.navigationController.navigationBar.prefersLargeTitles = YES;
        self.navigationItem.hidesSearchBarWhenScrolling = NO;
        self.navigationItem.searchController = self.searchController;
    } else {
        // Fallback on earlier versions
    }
    __weak typeof(self) weakself = self;
    [self loadDataCompletion:^(NSArray<KonachanResponse *> *dataModels) {
        weakself.dataModels = dataModels;
    }];
}

// MARK: - layout
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.contentListView.frame = self.view.bounds;
}

// MARK: - load data

- (void)loadDataCompletion:(void(^)(NSArray<KonachanResponse *> *dataModels))completion {
    KonachanRequest * request = [[KonachanRequest alloc] init];
    request.page = self.indexPage;
    request.tags = self.tags;
    [request requestSuccess:^(id responseObject) {
        NSArray<KonachanResponse*> *res = [NSArray yy_modelArrayWithClass:KonachanResponse.class json:responseObject];
        completion(res);
    } failure:^(NSError *error) {
        
    }];

}

// MARK: - ContentListViewDelegate
- (void)contentListViewDidClickWithItem:(NSInteger)item withDataModel:(KonachanResponse *)dataModel{
    DetailViewController * vc = [[DetailViewController alloc]init];
    vc.konachanResponse = dataModel;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)contentListViewDidRefreshNew{
    self.indexPage = 1;
    __weak typeof(self) weakself = self;
    [self loadDataCompletion:^(NSArray<KonachanResponse *> *dataModels) {
        weakself.dataModels = dataModels;
    }];
}

- (void)contentListViewDidRefreshMore{
    self.indexPage+=1;
    __weak typeof(self) weakself = self;
    [self loadDataCompletion:^(NSArray<KonachanResponse *> *dataModels) {
        NSMutableArray * mulArray = [[NSMutableArray alloc]initWithArray:self.dataModels];
        [mulArray addObjectsFromArray:dataModels];
        weakself.dataModels = mulArray;
    }];
}

int _lastPosition;    //A variable define in headfile
bool _isHidenNav;
- (void)contentListViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
//    int currentPostion = scrollView.contentOffset.y;
//    if (currentPostion - _lastPosition > 20  && currentPostion > 0) {
//        _lastPosition = currentPostion;
//        if (self.navigationController.navigationBarHidden==NO) {
//            [self.navigationController setNavigationBarHidden:YES animated:YES];
//            _isHidenNav = self.navigationController.isNavigationBarHidden;
//        }
//    }
//    else if ((_lastPosition - currentPostion > 20) && (currentPostion  <= scrollView.contentSize.height-scrollView.bounds.size.height-20) ){
//        _lastPosition = currentPostion;
//        if (self.navigationController.navigationBarHidden) {
//            [self.navigationController setNavigationBarHidden:NO animated:YES];
//            _isHidenNav = self.navigationController.isNavigationBarHidden;
//        }
//    }

}

// MARK: - SearchResultsControllerDelegate
- (void)searchResultsControllerDidSelectedWithTags:(NSString *)tags{
    self.indexPage = 1;
    self.tags = tags;
    __weak typeof(self) weakself = self;
    [self loadDataCompletion:^(NSArray<KonachanResponse *> *dataModels) {
        weakself.dataModels = dataModels;
    }];
}

// MARK: - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    [self searchResultsControllerDidSelectedWithTags:searchController.searchBar.text];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
// MARK: - setter&&getter
- (void)setDataModels:(NSArray<KonachanResponse *> *)dataModels{
    _dataModels = dataModels;
    self.contentListView.models = self.dataModels;
}

- (ContentListView *)contentListView{
    if (!_contentListView) {
        _contentListView = [[ContentListView alloc]init];
        _contentListView.delegate = self;
    }
    return _contentListView;
}

- (UISearchController *)searchController{
    if (!_searchController) {
        _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.hidesNavigationBarDuringPresentation = NO;
        _searchController.searchBar.placeholder = @"搜索关键词";
    }
    return _searchController;
}

- (SearchResultsController *)searchResultsController{
    if (!_searchResultsController) {
        _searchResultsController = [[SearchResultsController alloc]initWithStyle:(UITableViewStylePlain)];
        _searchResultsController.delegate = self;
    }
    return _searchResultsController;
}
@end
