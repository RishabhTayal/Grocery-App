//
//  GRCartViewController.m
//  Grocery App
//
//  Created by Rishabh Tayal on 9/24/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import "GRCartViewController.h"
#import "Cart.h"
#import <UITableView-NXEmptyView/UITableView+NXEmptyView.h>

@interface GRCartViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView* tableView;

@property (nonatomic, strong) NSMutableArray* datasource;

@end

@implementation GRCartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.nxEV_emptyView = [[[NSBundle mainBundle] loadNibNamed:@"EmptyCartView" owner:self options:nil] objectAtIndex:0];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _datasource = [NSMutableArray arrayWithArray:[Cart MR_findAll]];
    
    [self.tableView reloadData];
    NSLog(@"Cart Datasource: %@", _datasource);
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
    
}

@end
