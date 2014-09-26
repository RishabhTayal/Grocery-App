//
//  GRMyAccountViewController.m
//  Grocery App
//
//  Created by Rishabh Tayal on 9/24/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

#import "GRMyAccountViewController.h"
#import "GRLoginViewController.h"

@interface GRMyAccountViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView* tableView;

@end

@implementation GRMyAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Order History";
            cell.imageView.image = [UIImage imageNamed:@"history_icn"];
            break;
        case 1:
            cell.textLabel.text = @"Shipping";
            cell.imageView.image = [UIImage imageNamed:@"shipping_icn"];
            break;
        case 2:
            cell.textLabel.text = @"Payment info";
            cell.imageView.image = [UIImage imageNamed:@"billing_icn"];
            break;
        case 3:
            cell.textLabel.text = @"Favorites";
            cell.imageView.image = [UIImage imageNamed:@"billing_icn"];
            break;
        default:
            cell.textLabel.text = @"Account Info";
            cell.imageView.image = [UIImage imageNamed:@"account_icn"];
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 4:
        {
            GRLoginViewController* loginVC = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"GRLoginViewController"];
            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:loginVC] animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}

@end
