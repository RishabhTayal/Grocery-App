//
//  GRItemsListViewController.m
//  Grocery App
//
//  Created by Rishabh Tayal on 9/26/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import "GRItemsListViewController.h"
#import "GRItemTableViewCell.h"

@interface GRItemsListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView* tableView;

@property (nonatomic, strong) NSMutableArray* datasource;

@end

@implementation GRItemsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _datasource = [NSMutableArray new];
    [_datasource addObject:@"a"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
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
    GRItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(GRItemTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.productIV.image = [UIImage imageNamed:@"sev"];
    cell.productName.text = @"Sev";
    cell.priceLabel.text = @"$4.99";
}

@end
