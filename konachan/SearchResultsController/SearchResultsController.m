//
//  SearchResultsController.m
//  konachan
//
//  Created by Chian on 2019/2/12.
//  Copyright © 2019 HQ. All rights reserved.
//

#import "SearchResultsController.h"
#import "KonachanTagRequest.h"
#import "KonachanTagResponse.h"

@interface SearchResultsController ()
@property(strong,nonatomic) NSArray<KonachanTagResponse*> * dataModels;
@end

@implementation SearchResultsController

- (void)setDataModels:(NSArray<KonachanTagResponse *> *)dataModels{
    _dataModels = dataModels;
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"reuseIdentifier"];
    
}

- (void)loadDataWithName:(NSString*)name{
    KonachanTagRequest * request = [[KonachanTagRequest alloc]init];
    request.query = name;
    __weak typeof(self) weakself = self;
    [request requestSuccess:^(id responseObject) {
        NSArray<KonachanTagResponse*> * res = [NSArray yy_modelArrayWithClass:KonachanTagResponse.class json:responseObject];
        weakself.dataModels = res;
    } failure:^(NSError *error) {
        
    }];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    if (searchController.searchBar.text.length>0) {
        [self loadDataWithName:searchController.searchBar.text];        
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataModels.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    KonachanTagResponse * response = self.dataModels[indexPath.row];
    cell.textLabel.text = response.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(searchResultsControllerDidSelectedWithTags:)]) {
            KonachanTagResponse * response = self.dataModels[indexPath.row];
            [self.delegate searchResultsControllerDidSelectedWithTags:response.name];
        }
    }];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
