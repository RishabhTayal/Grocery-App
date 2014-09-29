//
//  SecondViewController.m
//  Grocery App
//
//  Created by Rishabh Tayal on 9/24/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import "GRSearchViewController.h"
#import "GRItemsListViewController.h"

@interface GRSearchViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (nonatomic, strong) IBOutlet UISearchBar* searchBar;

@property (nonatomic, strong) NSMutableArray* datasource;

- (IBAction)cartButtonCliceked:(id)sender;

@end

@implementation GRSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.translucent = NO;

    if (!_datasource) {
        GRWebService* caller = [[GRWebService alloc] init];
        [caller getCategoriesWithCallback:^(NSArray *result, NSError *error) {
            DLog(@"%@", result);
            _datasource = [NSMutableArray arrayWithArray:[result valueForKey:@"category"]];
            [self.tableView reloadData];
        }];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return 1;
    }
    return _datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = _datasource[indexPath.row][@"name"];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GRItemsListViewController* listVC = [self.storyboard instantiateViewControllerWithIdentifier:@"GRItemsListViewController"];
    [self.navigationController pushViewController:listVC animated:YES];
    [self.searchBar resignFirstResponder];
}

-(IBAction)cartButtonCliceked:(id)sender
{
    self.tabBarController.selectedIndex = 2;
}

#pragma mark - UISearchbar Delegate

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    GRWebService* caller = [[GRWebService alloc] init];
    if (searchText.length == 0) {
        [caller getCategoriesWithCallback:^(NSArray *result, NSError *error) {
            _datasource = [NSMutableArray arrayWithArray:[result valueForKey:@"category"]];
            [self.tableView reloadData];
        }];
    } else {
        
        [caller searchProductsForText:searchText callback:^(NSArray *result, NSError *error) {
            _datasource = [NSMutableArray arrayWithArray:[result valueForKey:@"products"]];
            [self.tableView reloadData];
        }];
    }
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    return YES;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
//    self.searchBar.showsCancelButton = NO;
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

@end
