//
//  SearchResultsController.h
//  konachan
//
//  Created by Chian on 2019/2/12.
//  Copyright © 2019 HQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol SearchResultsControllerDelegate <NSObject>

- (void)searchResultsControllerDidSelectedWithTags:(NSString*)tags;

@end

@interface SearchResultsController : UITableViewController<UISearchResultsUpdating>
@property(weak,nonatomic) id<SearchResultsControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
