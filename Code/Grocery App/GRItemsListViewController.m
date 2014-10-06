//
//  GRItemsListViewController.m
//  Grocery App
//
//  Created by Rishabh Tayal on 9/26/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import "GRItemsListViewController.h"
#import "GRItemTableViewCell.h"
#import <UIImageView+AFNetworking.h>
#import <AFNetworking/AFNetworking.h>
#import "GRItemDetailViewController.h"

@interface GRItemsListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView* tableView;

@property (nonatomic, strong) NSMutableArray* datasource;

@end

@implementation GRItemsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GRWebService* caller = [[GRWebService alloc] init];
    [caller getProdctsForCategory:_categoryId callback:^(id result, NSError *error) {
        _datasource = [NSMutableArray arrayWithArray:result[@"products"]];
        DLog(@"%@", self.datasource);
        [self.tableView reloadData];
    }];
    
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
    NSString* imageurl = [NSString stringWithFormat:@"%@%@", kProductImageUrlPrefix, _datasource[indexPath.row][@"primaryMedia"][@"url"]];
    DLog(@"%@", imageurl);
    
    //Adding acceptable content type image/jpg to AFNetworking. AFNetworking, by default, doesn't support jpg
    AFImageResponseSerializer* serializer = [[AFImageResponseSerializer alloc] init];
    serializer.acceptableContentTypes = [serializer.acceptableContentTypes setByAddingObject:@"image/jpg"];
    cell.productIV.imageResponseSerializer = serializer;
    
    [cell.productIV setImageWithURL:[NSURL URLWithString:imageurl]];
    cell.productName.text = _datasource[indexPath.row][@"name"];
    cell.priceLabel.text = _datasource[indexPath.row][@"retailPrice"][@"amount"];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[GRItemDetailViewController class]]) {
        GRItemDetailViewController* itemDetail = segue.destinationViewController;
        NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
//        itemDetail.productDict = _datasource[indexPath.row];
        itemDetail.productId = self.datasource[indexPath.row][@"id"];
        itemDetail.categoryId = self.categoryId;
    }
}

@end
