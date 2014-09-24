//
//  SecondViewController.m
//  Grocery App
//
//  Created by Rishabh Tayal on 9/24/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import "GRSearchViewController.h"

@interface GRSearchViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView* tableView;

@property (nonatomic, strong) NSMutableArray* datasource;

@end

@implementation GRSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_datasource) {
        _datasource = [NSMutableArray arrayWithObjects:@"Category 1", @"Category 2", @"Category 3", nil];
    }
    // Do any additional setup after loading the view, typically from a nib.
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
        cell.textLabel.text = _datasource[indexPath.row];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GRSearchViewController* searchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"GRSearchViewController"];
    searchVC.datasource = [NSMutableArray arrayWithObjects:@"Sub Cat 1", @"Sub Cat 2", @"Sub Cat 3", nil];
    [self.navigationController pushViewController:searchVC animated:YES];
}

@end
